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
        let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
        let catString = String(catCharacters)
        print(catString)
        
        var word = "cafe"
        print("the number of characters in \(word) is \(word.count)")
        // 打印输出 "the number of characters in cafe is 4"
        word += "\u{301}"    // 拼接一个重音, U+0301
        print("the number of characters in \(word) is \(word.count)")
        // 打印输出 "the number of characters in café is 4"
        
//        let greeting = "Guten Tag!"
//        greeting[greeting.startIndex]
//        // G
//        greeting[greeting.index(before: greeting.endIndex)]
//        // !
//        greeting[greeting.index(after: greeting.startIndex)]
//        // u
//        let index = greeting.index(greeting.startIndex, offsetBy: 7)
//        greeting[index]
//        // a
        
        var welcome = "hello there!"
        let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
        welcome.removeSubrange(range)
        print(welcome)
        
        let greeting = "Hello, world!"
        let index = greeting.index(of: ",") ?? greeting.endIndex
        let beginning = greeting[..<index]
        print(greeting)
        print(beginning)
    }
    
    func arrayTest() -> Void {
        var someInts = [Int]()
        someInts.append(3)
        print("someInts is of type [Int] with \(someInts.count) items.")
        
        let threeDoubles = Array(repeating: 0.0, count: 3)
        // threeDoubles 是一种 [Double] 数组，等价于 [0.0, 0.0, 0.0]
        
        let anotherThreeDoubles = Array(repeating: 2.5, count: 3)
        // anotherThreeDoubles 被推断为 [Double]，等价于 [2.5, 2.5, 2.5]
        
        let sixDoubles = threeDoubles + anotherThreeDoubles
        // sixDoubles 被推断为 [Double]，等价于 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
        
        print("sixDoubles is of type [sixDoubles] with \(sixDoubles.count) items.")
        
        var shoppingList: [String] = ["Eggs", "Milk"]
        // shoppingList 已经被构造并且拥有两个初始项。
        shoppingList += ["Baking Powder"]
        shoppingList += ["Chocolate Spread", "Cheese", "Butter" , "23333"]
        print(shoppingList)
        
        shoppingList[4...6] = ["Bananas", "Apples"]
        shoppingList.insert("Maple Syrup", at: 0)
        print(shoppingList)
        
        for item in shoppingList {
            print(item)
        }
        
        for (index, value) in shoppingList.enumerated() {
            print("Item \(String(index + 1)): \(value)")
        }
        
        var testArray = [AnyObject]()//用var声明
        //一个可变的数组，let声明的为不可变数组，注意AnyObject说明这个数组可以放任何元素。
        testArray.append(1 as AnyObject)//加入一个数字1
        testArray.append(true as AnyObject)//加入一个Bool
        let aLabel = UILabel()
        let aBtn = UIButton()
        testArray.append(aBtn)//加入一个UIButton
        testArray.append(aLabel)//加入一个UILabel
        
        testArray.append("test" as AnyObject)//加入一个字符串
        print(testArray)
        
        var letters = Set<Character>()
        print("letters is of type Set<Character> with \(letters.count) items.")
        // 打印 "letters is of type Set<Character> with 0 items."
        letters.insert("a")
        // letters 现在含有1个 Character 类型的值
        
        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
        // favoriteGenres 被构造成含有三个初始值的集合
        print("I have \(favoriteGenres.count) favorite music genres.")
        favoriteGenres.insert("Jazz")
        
        if let removedGenre = favoriteGenres.remove("Rock") {
            print("\(removedGenre)? I'm over it.")
        } else {
            print("I never much cared for that.")
        }
        
        if favoriteGenres.contains("Funk") {
            print("I get up on the good foot.")
        } else {
            print("It's too funky in here.")
        }
        
        for genre in favoriteGenres {
            print("\(genre)")
        }
        
        for genre in favoriteGenres.sorted() {
            print("\(genre)")
        }
    }
}
