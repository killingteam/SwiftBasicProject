//
//  WDTest.swift
//  SwiftBasicProject
//
//  Created by duoyi on 2019/7/19.
//  Copyright © 2019 NMSL. All rights reserved.
//

import UIKit

class WDTest: NSObject {

    func testFun() -> Void {
        let meaningOfLife = 42
        print("2333 = \(meaningOfLife)")
        print("IntMax = \(Int.max)")
        
        let twoThousand: UInt16 = 2_000
        let one: UInt8 = 1
        let twoThousandAndOne = twoThousand + UInt16(one)
        print("twoThousandAndOne = \(twoThousandAndOne)")
        
        let http404Error = (404, "Not Found")
        let (statusCode, statusMessage) = http404Error
        print("The status code is \(statusCode)")
        // 输出 "The status code is 404"
        print("The status message is \(statusMessage)")
        // 输出 "The status message is Not Found"
        
        let http200Status = (statusCode: 200, description: "OK")
        print("The status code is \(http200Status.statusCode)")
        // 输出 "The status code is 200"
        print("The status message is \(http200Status.description)")
        // 输出 "The status message is OK"
        
        var serverResponseCode: Int? = 404
        // serverResponseCode 包含一个可选的 Int 值 404
        serverResponseCode = nil
        
        print("2333 = \(String(describing: serverResponseCode))")
        
        //可选值的强制解析
        let convertedNumber :String? = nil
        if convertedNumber != nil {
            print("convertedNumber has an integer value of \(convertedNumber!).")
            
            if let actualNumber = Int(convertedNumber!) {
                print("\'\(convertedNumber!)\' has an integer value of \(actualNumber)")
            } else {
                print("\'\(convertedNumber!)\' could not be converted to an integer")
            }
            // 输出 "'123' has an integer value of 123"
        }
        // 输出 "convertedNumber has an integer value of 123."
        
//        let age = -3
//        assert(age >= 0, "A person's age cannot be less than zero")
        
//        if age > 10 {
//            print("You can ride the roller-coaster or the ferris wheel.")
//        } else if age > 0 {
//            print("You can ride the ferris wheel.")
//        } else {
//            assertionFailure("A person's age can't be less than zero.")
//        }
    }
    
    func stringTest() -> Void {
        
    }
}
