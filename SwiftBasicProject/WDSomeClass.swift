//
//  WDSomeClass.swift
//  SwiftBasicProject
//
//  Created by duoyi on 2019/7/29.
//  Copyright © 2019 NMSL. All rights reserved.
//

import UIKit

extension Double {
    var km: Double { return self * 1_000.0 }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

extension Int {
    mutating func square() {
        self = self * self
    }
}

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
        
//        set {
//            origin.x = newValue.x - (size.width / 2)
//            origin.y = newValue.y - (size.height / 2)
//        }
    }
}

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    //只读属性
    var volume: Double {
        return width * height * depth
    }
}

class StepCounter {
    var totalSteps: Int = 0 {
        //在新的值被设置之前调用
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        //在新的值被设置之后立即调用
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

struct PointTest {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}

enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

struct BlackjackCard {
    
    // 嵌套的 Suit 枚举
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    // 嵌套的 Rank 枚举
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

class WDSomeClass: NSObject {
    let someResolution = Resolution()
    let someVideoMode = VideoMode()
    let vga = Resolution(width:640, height: 480)
    
    let hd = Resolution(width: 1920, height: 1080)

    func test() -> Void {
        print("The width of someResolution is \(someResolution.width)")
        //深拷贝
        var cinema = hd
        cinema.width = 2048
        print("hd = \(hd)")
        print("cinema = \(cinema)")
        
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        
        print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
        // 打印 "The frameRate property of theEighty is now 30.0"
        
        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
        }
        
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
        // 该区间表示整数0，1，2
        rangeOfThreeItems.firstValue = 6
        // 该区间现在表示整数6，7，8
        
        var square = Rect(origin: Point(x: 0.0, y: 0.0),
                          size: Size(width: 10.0, height: 10.0))
        let initialSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        // 打印 "square.origin is now at (10.0, 10.0)”
        
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        // About to set totalSteps to 200
        // Added 200 steps
        stepCounter.totalSteps = 360
        // About to set totalSteps to 360
        // Added 160 steps
        stepCounter.totalSteps = 896
        // About to set totalSteps to 896
        // Added 536 steps
        
        let somePoint = PointTest(x: 4.0, y: 5.0)
        if somePoint.isToTheRightOfX(x: 1.0) {
            print("This point is to the right of the line where x == 1.0")
        }
        
        var ovenLight = TriStateSwitch.Low
        ovenLight.next()
        // ovenLight 现在等于 .High
        ovenLight.next()
        // ovenLight 现在等于 .Off
        
        let threeTimesTable = TimesTable(multiplier: 3)
        print("six times three is \(threeTimesTable[6])")
        // 打印 "six times three is 18"
        
        let anonymousCreature = Animal(species: "")
        // anonymousCreature 的类型是 Animal?, 而不是 Animal
        
        if anonymousCreature == nil {
            print("The anonymous creature could not be initialized")
        }
        // 打印 "The anonymous creature could not be initialized"
        
        let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
        print("theAceOfSpades: \(theAceOfSpades.description)")
        // 打印 “theAceOfSpades: suit is ♠, value is 1 or 11”
        
        let oneInch = 25.4.mm
        print("One inch is \(oneInch) meters")
        // 打印 “One inch is 0.0254 meters”
        let threeFeet = 3.ft
        print("Three feet is \(threeFeet) meters")
        // 打印 “Three feet is 0.914399970739201 meters”
        
        let aMarathon = 42.km + 195.m
        print("A marathon is \(aMarathon) meters long")
        // 打印 “A marathon is 42195.0 meters long”
        
        3.repetitions(task: {
            print("Hello!")
        })
        
        3.repetitions {
            print("Goodbye!")
        }
        
        var someInt = 3
        someInt.square()
        
        746381295[0]
        // 返回 5
        746381295[1]
        // 返回 9
        746381295[2]
        // 返回 2
        746381295[8]
        // 返回 7
        
        var anotherInt = 107
        swapTwoValues(&someInt, &anotherInt)
        
        var someString = "hello"
        var anotherString = "world"
        swapTwoValues(&someString, &anotherString)
        
        let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
        // doubleIndex 类型为 Int?，其值为 nil，因为 9.3 不在数组中
        let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
        // stringIndex 类型为 Int?，其值为 2
    }
    
    class Bank {
        static var coinsInBank = 10_000
        static func distribute(coins numberOfCoinsRequested: Int) -> Int {
            let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
            coinsInBank -= numberOfCoinsToVend
            return numberOfCoinsToVend
        }
        static func receive(coins: Int) {
            coinsInBank += coins
        }
    }
    
    func swapTwoValues<TTTTTT>(_ a: inout TTTTTT, _ b: inout TTTTTT) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    struct Stack<Element> {
        var items = [Element]()
        mutating func push(_ item: Element) {
            items.append(item)
        }
        mutating func pop() -> Element {
            return items.removeLast()
        }
    }
    
    func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    
    
}

protocol Container {
    associatedtype ItemType
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // Container 协议的实现部分
    typealias ItemType = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
