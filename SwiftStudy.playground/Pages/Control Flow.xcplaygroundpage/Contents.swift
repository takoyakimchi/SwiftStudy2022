// for문
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs.")
}

for idx in 1...5 {
    print("\(idx) * 5 = \(idx * 5)")
}

for _ in 1...10 {
    print("Hello")
}

// 간격 설정하기
let minutes = 60
let minuteInterval = 5
for i in stride(from: 0, to: minutes, by: minuteInterval) {
    print("time is now: \(i)")
}

// 간격 설정하기(closed range)
for i in stride(from: 0, through: minutes, by: minuteInterval) {
    print("Closed Range Time: \(i)")
}

// while 문
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0
while square < finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    square += diceRoll
    if square < board.count {   // 이거 안하면 board[square] 가 배열의 범위를 벗어날 수 있음.
        square += board[square]
    }
}
print("Game Over!")

// repeat-while: do-while 과 유사한 것
square = 0 ; diceRoll = 0
repeat {
    square += board[square] // ladder or snake
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    square += diceRoll
} while square < finalSquare // 이 조건은 첫 번째 loop가 끝날 때 까지 판별되지 않음.
print("Game Over!")

// switch
let randomString = "AEIOUaeiouBbCc"
for ch in randomString.indices {
    switch randomString[ch] {
    case "A", "a", "E", "e", "I", "i", "O", "o", "U", "u":
        print("\(randomString[ch]) is a vowel")
    default:
        print("\(randomString[ch]) is a consonant")
    }
}

let someCharacter: Character = "A"
switch someCharacter {
case "A", "a":
    print("letter A")
default:
    print("not the letter A")
}

// Interval Matching
let scores = ["John": 60, "Jake": 75, "Mark": 90, "Anna": 55, "Terry": 70]
for (studentName, score) in scores {
    switch score {
    case 90...100:
        print("\(studentName) got A")
    case 80..<90:
        print("\(studentName) got B")
    case 70..<80:
        print("\(studentName) got C")
    default:
        print("\(studentName) got F")
    }
}

// Tuples
let somePoint = (0, 0)  // (0, 0)인 경우 4가지 case에 모두 만족하는데, 첫 번째 matching case만 사용되고 나머지는 무시된다.
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0): // _ : match any possible value
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}

// Value Bindings
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0): // y값이 0인 모든 튜플과 매치되며, x값을 임시적인 상수 x에 할당함.
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y)")
} // 여기에서 default 없어도 되는가 ? -> 마지막 case가 남은 모든 값을 탐색하기 때문에 괜찮음.

// switch -> where
let yetAnotherPoint = (5, 5)
switch yetAnotherPoint {
case let (x, y) where x == y: // where절이 true일 때만 match된다.
    print("(\(x), \(y)) is on x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on x == -y")
case let (x, y):
    print("(\(x), \(y)) is on somewhere else")
}

// continue
let inputString = "great minds think alike"
var outputString = ""
let charToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for ch in inputString {
    if charToRemove.contains(ch) {
        continue
    }
    outputString.append(ch)
}
print(outputString)

// switch -> fallthrough
let num = 5
switch num {
case 2, 3, 5, 7:
    print("\(num) is a prime number.")
    fallthrough // 다음 case는 확인하지 않으므로 주의!
default:
    print("\(num) is an integer.")
}

// Label Statements -> 루프 여러개 중첩돼 있을 때 어떤 걸 종료할 지 선택할 수 있음!
outerLoop: for i in 1...5 {
    for j in 1...5 {
        print("\(i) \(j)")
        if i == 3 && j == 3 {
            break outerLoop
        }
    }
}

// Early Exit
// guard 문 -> guard 조건 else { 조건이 false일 때 실행 }
// if 문을 써도 되는데 가독성 때문에 사용한다.
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return  // guard문 안쪽이 실행됐다면 무조건 return, break, continue, throw 등을 써서 fall through되지 않게 해야 한다.
    }
    
    print("Hello, \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    
    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Cupertino"])
greet(person: [:])

@available(macOS 10.12, *)
struct ColorPreference {
    var bestColor = "blue"
}

func chooseBestColor() -> String {
    guard #available(macOS 10.12, *) else {
        return "gray"
    }
    let colors = ColorPreference()
    return colors.bestColor
}

print(chooseBestColor())
