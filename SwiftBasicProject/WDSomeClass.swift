//
//  WDSomeClass.swift
//  SwiftBasicProject
//
//  Created by duoyi on 2019/7/29.
//  Copyright © 2019 NMSL. All rights reserved.
//

import UIKit

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
    
}
