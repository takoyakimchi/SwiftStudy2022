// 프로퍼티
// 저장 프로퍼티(Stored Properties): 값(상수, 변수)을 저장하고 있는 프로퍼티
// -> 클래스, 구조체
// 계산된 프로퍼티(Computed Properties): 특정하게 계산한 값을 반환
// -> 클래스, 구조체, enum

// Stored Properties
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// rangeOfFourItems.firstValue = 10

// 클래스는 let으로 선언하더라도 프로퍼티가 변경 가능함 -> 참조 타입이기 때문.

// Lazy Stored Properties(지연 저장 프로퍼티): 값이 처음으로 사용되기 전까지는 계산되지 않는 프로퍼티. lazy var ~~
class DataImporter {
    var filename = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data") // 이 시점까지는 DataImporter() 인스턴스가 생성 X
print(manager.importer.filename) // importer 프로퍼티에 접근 -> 이제 DataImporter() 인스턴스가 생성됨

// Computed Properties -> getter & setter(optional) 제공!
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
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

// setter 간단하게 쓰기
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2)) // implicit return
        }
        set { // newValue 사용하면 인자 이름 지정 X
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// Read-only Computed Properties
// getter 있고 setter 없음
// computed property는 모두 var로 선언
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("The volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

// Property Observers -> 새 값이 설정될 때마다 호출됨. (값이 같아도)
// willSet -> 값이 저장되기 직전에 호출됨
// didSet -> 값이 저장된 직후에 호출됨

class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            print("About to set totalSteps to \(newValue)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 300
stepCounter.totalSteps = 550
stepCounter.totalSteps = 350
print(stepCounter.totalSteps)

// Property Wrappers -> 값의 제약조건을 설정하는 부분을 따로 분리? 재사용도 가능.
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height) // 0 (초기값)

rectangle.height = 10
print(rectangle.height) // 10

rectangle.height = 15
print(rectangle.height) // 12

// 초기값 설정
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int
    
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }
    
    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

// init()
struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)

// init(wrappedValue:)
struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)

// init(wrappedValue:maximum:)
struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)

// mix use
struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}

var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)

mixedRectangle.height = 100
print(mixedRectangle.height)

mixedRectangle.width = 100
print(mixedRectangle.width)
