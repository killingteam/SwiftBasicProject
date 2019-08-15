//
//  TitleCell.swift
//  SwiftBasicProject
//
//  Created by duoyi on 2019/8/15.
//  Copyright © 2019 NMSL. All rights reserved.
//

import UIKit
import SnapKit

class TitleCell: UICollectionViewCell {
    lazy var titleLable:UILabel = {
        let lable = UILabel.init()
        lable.textColor = UIColor.blue
        return lable
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.titleLable)
        self.titleLable.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
