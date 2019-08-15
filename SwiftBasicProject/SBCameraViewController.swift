//
//  SBCameraViewController.swift
//  SwiftBasicProject
//
//  Created by duoyi on 2019/8/13.
//  Copyright © 2019 NMSL. All rights reserved.
//

import UIKit
import CoreImage
import GPUImage
import AVFoundation
import SnapKit

class SBCameraViewController: UIViewController {
    var selectIndex = 0
    
    
    let fbSize = Size(width: 1920, height: 1080)
    let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
    var shouldDetectFaces = true
    lazy var lineGenerator: LineGenerator = {
        let gen = LineGenerator(size: self.fbSize)
        gen.lineWidth = 5
        return gen
    }()
    let saturationFilter = SaturationAdjustment()
    let blendFilter = AlphaBlend()
    var camera:Camera!
    var renderView:RenderView!
    
    //高斯模糊
    lazy var gaussianBlurFilter:GaussianBlur! = {
        let filter = GaussianBlur.init()
        return filter
    }()
    
    //查表滤镜
    lazy var lookUpFilter:LookupFilter! = {
        let path:String! = Bundle.main.path(forResource: "filterResources/892801501567939852359ba6ee4d4ad8", ofType: "png")
        let image:UIImage! = UIImage.init(contentsOfFile: path)
        
        let lookUpFilter = LookupFilter.init()
        lookUpFilter.intensity = 0.5
        lookUpFilter.lookupImage = PictureInput.init(image: image)
        return lookUpFilter
    }()
    
    //模仿ios7控制中心的模糊效果
    lazy var iOSBlurFilter:iOSBlur! = {
        let fiter = iOSBlur.init()
        return fiter
    }()
    
    lazy var collectionView:UICollectionView = {
        let rect = UIScreen.main.bounds
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: rect.height - 70, width: rect.width, height: 70), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        
        // 注册cell
        collectionView.register(TitleCell.self, forCellWithReuseIdentifier: "TitleCell")
        
        return collectionView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.renderView = RenderView.init(frame: self.view.bounds)
        self.view.addSubview(self.renderView)
        self.view.addSubview(self.collectionView)
        
        do {
            camera = try Camera(sessionPreset:.hd1920x1080)
            camera.runBenchmark = true
            camera.delegate = self
//            camera --> saturationFilter --> blendFilter --> renderView
//            camera --> lookUpFilter --> renderView
//            lineGenerator --> blendFilter
            camera --> renderView

            camera.startCapture()
        } catch {
            fatalError("Could not initialize rendering pipeline: \(error)")
        }
        
        let slider:UISlider = UISlider.init()
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = 0.5
        slider.addTarget(self, action: #selector(sliderChanged(seliderValue:)), for: .valueChanged)
        self.view.addSubview(slider)
        
        slider.snp.makeConstraints { (make) in
            make.right.equalTo(-16.0)
            make.left.equalTo(16.0)
            make.height.equalTo(44.0)
            make.bottom.equalTo(-70.0)
        }
    }
    
    @objc func sliderChanged(seliderValue:UISlider) {
        if self.selectIndex == 1 {
            lookUpFilter.intensity = seliderValue.value
        }else if self.selectIndex == 2 {
            gaussianBlurFilter.blurRadiusInPixels = seliderValue.value * 80.0
        }
        
    }
}

extension SBCameraViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TitleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath) as! TitleCell
        cell.titleLable.text = "\(indexPath.row)"
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        camera.removeAllTargets()
        lookUpFilter.removeAllTargets()
        gaussianBlurFilter.removeAllTargets()
        iOSBlurFilter.removeAllTargets()
        
        if indexPath.row == 1 {
            camera --> lookUpFilter --> renderView
        }else if indexPath.row == 2 {
            camera --> gaussianBlurFilter --> renderView
        }else if indexPath.row == 3{
            camera --> iOSBlurFilter --> renderView
        }else {
            camera --> renderView
        }
        self.selectIndex = indexPath.row
    }
}

extension SBCameraViewController: CameraDelegate {
    func didCaptureBuffer(_ sampleBuffer: CMSampleBuffer) {
        guard shouldDetectFaces else {
            lineGenerator.renderLines([]) // clear
            return
        }
        if let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
            let attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, CMAttachmentMode(kCMAttachmentMode_ShouldPropagate))!
            let img = CIImage(cvPixelBuffer: pixelBuffer, options: attachments as? [String: AnyObject])
            var lines = [Line]()
            for feature in (faceDetector?.features(in: img, options: [CIDetectorImageOrientation: 6]))! {
                if feature is CIFaceFeature {
                    lines = lines + faceLines(feature.bounds)
                }
            }
            lineGenerator.renderLines(lines)
        }
    }
    
    func faceLines(_ bounds: CGRect) -> [Line] {
        // convert from CoreImage to GL coords
        let flip = CGAffineTransform(scaleX: 1, y: -1)
        let rotate = flip.rotated(by: CGFloat(-.pi / 2.0))
        let translate = rotate.translatedBy(x: -1, y: -1)
        let xform = translate.scaledBy(x: CGFloat(2/fbSize.width), y: CGFloat(2/fbSize.height))
        let glRect = bounds.applying(xform)
        
        let x = Float(glRect.origin.x)
        let y = Float(glRect.origin.y)
        let width = Float(glRect.size.width)
        let height = Float(glRect.size.height)
        
        let tl = Position(x, y)
        let tr = Position(x + width, y)
        let bl = Position(x, y + height)
        let br = Position(x + width, y + height)
        
        return [.segment(p1:tl, p2:tr),   // top
            .segment(p1:tr, p2:br),   // right
            .segment(p1:br, p2:bl),   // bottom
            .segment(p1:bl, p2:tl)]   // left
    }
}
