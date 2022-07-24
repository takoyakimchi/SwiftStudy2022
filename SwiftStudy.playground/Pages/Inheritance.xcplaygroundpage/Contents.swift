// 클래스 -> 메소드, 프로퍼티 및 다른 특성을 다른 클래스로부터 상속할 수 있음.
// superclass --- subclass

// base class 정의
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        
    }
}

let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")

// Subclassing
class Bicycle: Vehicle {
    var hasBasket = false // 자기 자신만의 속성
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

class Tandem: Bicycle { // tandem -> 둘이 타는 자전거
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")

// overriding -> overriding methods
class Train: Vehicle {
    override func makeNoise(){
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()

// overriding -> overriding properties
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")

// overriding -> overriding property observers
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")

// 특정 메소드, 프로퍼티, 서브스크립트가 오버라이드 되는 것을 방지하려면 final 키워드를 사용한다.
// syntax: final var, final func, final class func, final subscript

// 클래스 전체를 final할 수도 있다.
// syntax: final class
