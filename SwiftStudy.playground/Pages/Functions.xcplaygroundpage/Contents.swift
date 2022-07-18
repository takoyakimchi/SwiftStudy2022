// 인자와 리턴값이 있는 함수
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

print(greet(person: "Anna"))
print(greet(person: "Brian"))

// 인자가 없고 리턴값이 있는 함수
func sayHelloWorld() -> String {
    return "hello, world"
}

print(sayHelloWorld())

// 인자가 여러 개
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}

func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}

print(greet(person: "Tim", alreadyGreeted: true))
print(greet(person: "Mark", alreadyGreeted: false))

// no return values
func greet2(person: String) {
    print("Hello, \(person)!")
}

greet2(person: "Dave")

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
printWithoutCounting(string: "hello, world")

// 여러 개의 리턴 값
func minMax(array: [Int]) -> (Int, Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1...] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print(bounds.0, bounds.1)

// optional tuple return
func minMax2(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1...] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

//print(minMax(array: []))
//let emptyArray: [Int] = []
//print(minMax2(array: emptyArray))

// implicit return -> property getter에서도 사용
// ->
func greeting(for person: String) -> String {
    "Hello, " + person + "!" // implicit return (String)
}
print(greeting(for: "Dave"))

func implicitAdd(num1: Int, num2: Int) -> Int {
    num1 + num2 // implicit return (Int)
}
print(implicitAdd(num1: 30, num2: 50))

// Argument Labels
// usage: func someFunction(argumentLabel parameterName: Int)
func greet(person: String, from hometown: String) -> String {
    return "Hello, \(person)! Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Seoul")) // 인자 라벨 사용 -> 가독성 up
// print(greet(person: "Bill", hometown: "Seoul")) -> ERROR

func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    print("First Parameter: \(firstParameterName), Second Parameter: \(secondParameterName)")
}
someFunction(100, secondParameterName: 200)

// Default Parameter Values
func someFunction2(_ parameterWithoutDefault: Int, _ parameterWithDefault: Int = 12) {
    print(parameterWithoutDefault, parameterWithDefault)
}
someFunction2(10)
someFunction2(10, 0)

// Variadic Parameter(집합 파라미터)
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

func arithmeticMean2(_ numbers: [Double]) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

func exampleFunction(_ numbers: Int..., str: String) {
    print("\(numbers) \(str)")
}

arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(5.5, 5.7)
arithmeticMean2([5.5, 5.7])
exampleFunction(10, 20, 30, str: "Hello") // variadic parameter 뒤에는 꼭 argument label을 제시해야 한다.

// In-Out Parameters -> 함수 파라미터는 기본적으로 constant이다. C에서 포인터를 넣는 거랑 비슷
// 값을 변경하고 함수 호출 끝날 때까지 유지하고 싶으면 inout 쓰기
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

var num1 = 10
var num2 = 20
swapTwoInts(&num1, &num2)
print(num1, num2)

// Function Types
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    a + b
}

func multiplyTwoInt(_ a: Int, _ b: Int) -> Int {
    a * b
}

var mathFunction: (Int, Int) -> Int = addTwoInts
print("Result: \(mathFunction(3, 5))")

mathFunction = multiplyTwoInt
print("Result: \(mathFunction(3, 5))")

let anotherMathFunction = addTwoInts
print("Result: \(anotherMathFunction(10, 20))")

func printMathResult(_ mathFunction: (Int, Int) -> Int, _ num1: Int, _ num2: Int) {
    print("Result: \(mathFunction(num1, num2))")
}

printMathResult(multiplyTwoInt, 100, 200)

// Function Types as Return Types
func stepForward(_ input: Int) -> Int {
    return input + 1
}

func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = 5
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)

print("Counting to zero:")
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}
