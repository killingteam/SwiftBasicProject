//
//  WDTest1.swift
//  SwiftBasicProject
//
//  Created by duoyi on 2019/7/25.
//  Copyright © 2019 NMSL. All rights reserved.
//

import UIKit



class WDTest1: NSObject {
    func pageTest() -> Void {
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        var reversedNames = names.sorted(by: backward)
        
        reversedNames = names.sorted { (s1, s2) -> Bool in
            return s1 < s2
        }
        
        //不建议这样写，在复杂代码中可读性太差了
        reversedNames = names.sorted(by: { $0 < $1 } )
        
        print(reversedNames);
        
        someFunctionThatTakesAClosure {
            print("2333")
        }
        
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        let strings = numbers.map {
            (number) -> String in
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        print(strings)
        
        let incrementByTen = makeIncrementer(forIncrement: 10)
        incrementByTen()
        // 返回的值为10
        incrementByTen()
        // 返回的值为20
        incrementByTen()
        // 返回的值为30
        
        let incrementBySeven = makeIncrementer(forIncrement: 7)
        incrementBySeven()
        // 返回的值为7
        
        incrementByTen()
        // 返回的值为40
        
        var x = 10
        var completionHandlers: [() -> Void] = []
        func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
            completionHandlers.append(completionHandler)
        }
        someFunctionWithEscapingClosure { x = 100 }
        completionHandlers.first?()
        print(x)
        
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)
        // 打印出 "5"
        
        let customerProvider = { customersInLine.remove(at: 0) }
        print(customersInLine.count)
        // 打印出 "5"
        
        print("Now serving \(customerProvider())!")
        // Prints "Now serving Chris!"
        print(customersInLine.count)
        // 打印出 "4"
        
        func serve(customer customerProvider: () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve(customer: { customersInLine.remove(at: 0) } )
        // 打印出 "Now serving Alex!"
        
        // customersInLine i= ["Barry", "Daniella"]
        var customerProviders: [() -> String] = []
        func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
            customerProviders.append(customerProvider)
        }
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))
        
        print("Collected \(customerProviders.count) closures.")
        // 打印 "Collected 2 closures."
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
        }
        // 打印 "Now serving Barry!"
        // 打印 "Now serving Daniella!"
    }
    
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 < s2
    }
    
    func someFunctionThatTakesAClosure(closure: () -> Void) {
        // 函数体部分
        closure()
        print("44444")
    }
    
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer
    }
}
