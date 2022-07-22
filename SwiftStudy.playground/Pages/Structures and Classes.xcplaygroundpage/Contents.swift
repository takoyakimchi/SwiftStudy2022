/*
 Structure(구조체)와 클래스의 차이
 (둘 다 가능한 것)
 Define properties to store values
 -> 값을 저장하는 Property 정의
 Define methods to provide functionality
 -> 메소드 정의
 Define subscripts to provide access to their values using subscript syntax
 -> 값을 접근하는 subscript 정의(get, set ??)
 Define initializers to set up their initial state
 -> 초기 상태를 설정하는 Initializer 정의
 Be extended to expand their functionality beyond a default implementation
 -> 기본 구현을 넘어선 기능 확장
 Conform to protocols to provide standard functionality of a certain kind
 -> 특정한 종류의 표준 기능을 제공하기 위한 프로토콜 순응(conform) ??????????
 
 (클래스만 가능한 것)
 상속(Inheritance): 클래스의 속성들을 다른 클래스에 상속시킴
 타입 캐스팅(Type Casting): 클래스 인스턴스의 타입을 런타임에 확인하고 해석
 소멸자(Deinitializers): 할당된 자원 해제
 참조 카운트(Reference Counting): 클래스 인스턴스에 하나 이상의 참조가 가능 (??)
 */

// 구조체
struct Resolution {
    var width = 0
    var height = 0
}

// 클래스
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()

print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
someVideoMode.resolution.width = 1280

let vga = Resolution(width: 640, height: 480)

// 구조체는 value type 이다.
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

cinema.width = 2048
print("cinema.width = \(cinema.width)")
print("hd.width = \(hd.width)") // 값이 안 바뀌므로 value type이라는 걸 확인

// enum도 value type이다.
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")

// 클래스는 reference type이다.
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)") // 바뀐 것을 확인 -> 레퍼런스 타입.

// Identity Operators
// === : 같은 인스턴스를 참조
// !== : 다른 인스턴스를 참조
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
