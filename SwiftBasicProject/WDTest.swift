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
        
//        使用intersection(_:)方法根据两个集合中都包含的值创建的一个新的集合。
//        使用symmetricDifference(_:)方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
//        使用union(_:)方法根据两个集合的值创建一个新的集合。
//        使用subtracting(_:)方法根据不在该集合中的值创建一个新的集合。
        
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        
        oddDigits.union(evenDigits).sorted()
        // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        oddDigits.intersection(evenDigits).sorted()
        // []
        oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
        // [1, 9]
        oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
        // [1, 2, 9]
        
        
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]
        
        houseAnimals.isSubset(of: farmAnimals)
        // true
        farmAnimals.isSuperset(of: houseAnimals)
        // true
        farmAnimals.isDisjoint(with: cityAnimals)
        // true
        
        var namesOfIntegers = [Int: String]()
        namesOfIntegers[16] = "sixteen"
        namesOfIntegers = [:]
        // namesOfIntegers 又成为了一个 [Int: String] 类型的空字典
        
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        print("The dictionary of airports contains \(airports.count) items.")
        if airports.isEmpty {
            print("The airports dictionary is empty.")
        } else {
            print("The airports dictionary is not empty.")
        }
        airports["LHR"] = "London"
        
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        
        if let airportName = airports["DUB"] {
            print("The name of the airport is \(airportName).")
        } else {
            print("That airport is not in the airports dictionary.")
        }
        
        if let removedValue = airports.removeValue(forKey: "DUB") {
            print("The removed airport's name is \(removedValue).")
        } else {
            print("The airports dictionary does not contain a value for DUB.")
        }
        
        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }
        
        let airportCodes = [String](airports.keys)
        // airportCodes 是 ["YYZ", "LHR"]
        
        let airportNames = [String](airports.values)
        // airportNames 是 ["Toronto Pearson", "London Heathrow"]
    }
    
    func controll() -> Void {
        let minutes = 60
//        for tickMark in 0..<minutes {
//            // 每一分钟都渲染一个刻度线（60次）
//            print(tickMark)
//        }
        
        let minuteInterval = 5
        for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
            // 每5分钟渲染一个刻度线 (0, 5, 10, 15 ... 45, 50, 55)
            print(tickMark)
        }
        
        let hours = 12
        let hourInterval = 3
        for tickMark in stride(from: 3, through: hours, by: hourInterval) {
            // 每3小时渲染一个刻度线 (3, 6, 9, 12)
            print(tickMark)
        }
        
        let someCharacter: Character = "z"
        switch someCharacter {
        case "a", "A":
            print("The first letter of the alphabet")
        case "z":
            print("The last letter of the alphabet")
        default:
            print("Some other character")
        }
        // 输出 "The last letter of the alphabet"
        
        var approximateCount = 62
        approximateCount = 0
        let countedThings = "moons orbiting Saturn"
        let naturalCount: String
        switch approximateCount {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        print("There are \(naturalCount) \(countedThings).")
        
        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("\(somePoint) is at the origin")
        case (_, 0):
            print("\(somePoint) is on the x-axis")
        case (0, _):
            print("\(somePoint) is on the y-axis")
        case (-2...2, -2...2):
            print("\(somePoint) is inside the box")
        default:
            print("\(somePoint) is outside of the box")
        }
        
        let anotherPoint = (2, 0)
        switch anotherPoint {
        case (let x, 0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }
        
        let yetAnotherPoint = (1, -1)
        switch yetAnotherPoint {
        case let (x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        // 输出 "(1, -1) is on the line x == -y"
        
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2, 3, 5, 7, 11, 13, 17, 19:
            description += " a prime number, and also"
            fallthrough
        default:
            description += " an integer."
        }
        print(description)
        // 输出 "The number 5 is a prime number, and also an integer."
        
        let finalSquare = 25
        var board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        var square = 0
        var diceRoll = 0
        gameLoop: while square != finalSquare {
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 }
            switch square + diceRoll {
            case finalSquare:
                // 骰子数刚好使玩家移动到最终的方格里，游戏结束。
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                // 骰子数将会使玩家的移动超出最后的方格，那么这种移动是不合法的，玩家需要重新掷骰子
                continue gameLoop
            default:
                // 合法移动，做正常的处理
                square += diceRoll
                square += board[square]
            }
        }
        print("Game over!")
        
        greet(person: ["name": "John"])
        greet(person: ["name": "Jane", "location": "Cupertino"])
        
        if #available(iOS 10, macOS 10.12, *) {
            // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
        } else {
            // 使用先前版本的 iOS 和 macOS 的 API
        }
        
        arithmeticMean(1, 2, 3, 4, 5)
        // 返回 3.0, 是这 5 个数的平均数。
        arithmeticMean(3, 8.25, 18.75)
        // 返回 10.0, 是这 3 个数的平均数。
        
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        
        var currentValue = 3
        let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
        
        print("Counting to zero:")
        // Counting to zero:
        while currentValue != 0 {
            print("\(currentValue)... ")
            currentValue = moveNearerToZero(currentValue)
        }
        print("zero!")
    }
    
    func greet(person: [String: String]) {
        guard let name = person["name"] else {
            return
        }
        print("Hello \(name)")
        guard let location = person["location"] else {
            print("I hope the weather is nice near you.")
            return
        }
        print("I hope the weather is nice in \(location).")
    }
    
    func arithmeticMean(_ numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    func stepForward(_ input: Int) -> Int {
        return input + 1
    }
    func stepBackward(_ input: Int) -> Int {
        return input - 1
    }
    
    func chooseStepFunction(backward: Bool) -> (Int) -> Int {
        return backward ? stepBackward : stepForward
    }
}
