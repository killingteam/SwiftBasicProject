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
    let fbSize = Size(width: 640, height: 480)
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
    var lookUpFilter:LookupFilter!
    var lookupImg:PictureOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.renderView = RenderView.init(frame: self.view.bounds)
        self.view.addSubview(self.renderView)
        
        let path:String! = Bundle.main.path(forResource: "filterResources/892801501567939852359ba6ee4d4ad8", ofType: "png")
        let image:UIImage! = UIImage.init(contentsOfFile: path)
        
        lookUpFilter = LookupFilter.init()
        lookUpFilter.intensity = 0.5
        lookUpFilter.lookupImage = PictureInput.init(image: image)
        
        do {
            camera = try Camera(sessionPreset:.vga640x480)
            camera.runBenchmark = true
            camera.delegate = self
//            camera --> saturationFilter --> blendFilter --> lookUpFilter --> renderView
            camera --> lookUpFilter --> renderView
            lineGenerator --> blendFilter
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
            make.center.equalTo(self.view)
            make.right.equalTo(16.0)
            make.right.equalTo(-16.0)
            make.height.equalTo(44.0)
        }
    }
    
    @objc func sliderChanged(seliderValue:UISlider) {
        lookUpFilter.intensity = seliderValue.value
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
