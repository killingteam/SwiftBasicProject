//
//  ViewController.swift
//  SwiftBasicProject
//
//  Created by cs on 2019/7/4.
//  Copyright © 2019 NMSL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let testObject:WDTest = WDTest.init()
//        testObject.testFun()
//        testObject.stringTest()
        testObject.arrayTest()
    }


}

