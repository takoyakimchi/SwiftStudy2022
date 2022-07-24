// 저장 프로퍼티 초기값 설정 -> init() 사용
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")

// 저장 프로퍼티 초기값 설정 -> default property values
// 초기값이 같은 값이면 이렇게 사용
struct Fahrenheit2 {
    var temperature = 32.0
}
var f2 = Fahrenheit2()
print("The default temperature is \(f2.temperature)° Fahrenheit")

// Customize Initialization
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahreiheit fahreinheit: Double) {
        temperatureInCelsius = (fahreinheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahreiheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

// parameter label이 없는 경우
struct Celsius2 {
    var temperatureInCelsius: Double
    init(fromFahreiheit fahreinheit: Double) {
        temperatureInCelsius = (fahreinheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double){
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius2(37.0)
print("bodyTemperature: \(bodyTemperature.temperatureInCelsius)")

// optional property types -> 알아서 nil로 초기화됨
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."
print(cheeseQuestion.response!)

// 상수 프로퍼티 초기화 -> 초기화하고 나면 변하지 않음.
class SurveyQuestion2 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion2(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets"

// Default Initializers
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

// initializer delegation for value types
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() { }
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - size.width / 2
        let originY = center.y - size.height / 2
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 0.0, y: 0.0), size: Size(width: 4.0, height: 5.0))

// class inheritance and initialization
// designated(지정) initializer -> 클래스의 모든 프로퍼티를 초기화 / 클래스는 반드시 한 개 이상의 designated initializer 필요
// convenience initializer -> designated initialzer 호출해야 함 무조건

// 이니셜라이저의 상속과 오버라이딩
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color // super.init() 은 implicit하게 호출됨.
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}
let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.description)")

// Automatic initializer inheritance
// rule 1:  subclass가 지정 초기자를 하나도 정의하지 않는 경우,
//          superclass의 모든 지정 초기자를 자동 상속
// rule 2:  subclass가 superclass의 지정 초기자를 모두 구현한 경우, super의 편리한 초기자를 자동 상속
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() { // convinience
        self.init(name: "[Unnamed]") // designated
    }
}

let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()
class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
