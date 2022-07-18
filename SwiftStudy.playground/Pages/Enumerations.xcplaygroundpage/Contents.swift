// Enumerations

import Darwin

enum CompassPoint {
    case north
    case south
    case east
    case west
} // C에서와는 다르게 integer value를 갖지 않음. (C에서는 이렇게 쓰면 0,1,2,3의 값을 가짐)

enum Planet { // 첫 글자는 대문자로, 복수보다는 단수로 쓰는 것이 관행
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west
directionToHead = .east // 이미 타입이 명시되어 있기 때문에 이렇게 간단하게 쓰는 것이 가능

directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("When the sun rises")
case .west:
    print("When the skies are blue") // 모든 case를 다 고려하고 있기 때문에 default가 필요없다
}

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

// Iterating over enumeration cases
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")

for beverage in Beverage.allCases {
    print(beverage)
}

// Associated Values
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case let .upc(numberSystem, manufacterer, product, check):
    print("UPC: \(numberSystem), \(manufacterer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR code: \(productCode)")
}

// Raw Values
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
    // case raw = "\r" 중복 안 됨!!
}

// 암시적 raw value
enum PlanetAgain: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum CompassPointAgain: String {
    case east, west, south, north
}

print(PlanetAgain.venus.rawValue)
let sunsetDirection = CompassPointAgain.west.rawValue
print(sunsetDirection)

// Initializing from a raw value
let possiblePlanet = PlanetAgain(rawValue: 3) // type of possiblePlanet: Planet?

let positionToFind = 11
if let otherPlanet = PlanetAgain(rawValue: positionToFind) {
    switch otherPlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}

// Recursive Enumerations 재귀적 열거형
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))
