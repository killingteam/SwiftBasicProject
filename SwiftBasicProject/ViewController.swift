//
//  ViewController.swift
//  SwiftBasicProject
//
//  Created by cs on 2019/7/4.
//  Copyright © 2019 NMSL. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let testObject:WDTest = WDTest.init()
//        testObject.testFun()
//        testObject.stringTest()
//        testObject.arrayTest()
//        testObject.controll()
        
//        let testObject:WDTest1 = WDTest1.init()
//        testObject.pageTest()
        
//        let enumerationTest = WDEnumerationTest.init()
//        enumerationTest.enumerationTest()
        
//        let some = WDSomeClass.init()
//        some.test()
        
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print(response.request ?? "")  // 原始的URL请求
            print(response.response ?? "") // HTTP URL响应
            print(response.data ?? "")     // 服务器返回的数据
            print(response.result)   // 响应序列化结果，在这个闭包里，存储的是JSON数据
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }


}

