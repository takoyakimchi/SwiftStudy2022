// closure -> 람다와 비슷
/*
 closure의 종류
 global functions -> 이름 있음, 값 캡처 안함
 nested functions -> 이름 있음, enclosing function 에서 값 캡처함
 closure expressions -> 이름 없음, 간결하게 표기, 값 캡처
 */

// Closure expressions -> sorted method
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted(by: backward)
// sorted(by:) 이 메소드는, 정렬하고 싶은 배열의 원소와 같은 자료형의 2개의 인자 및 Bool 리턴값을 갖는 클로저를 받음.
// s1 > s2 가 true이면 s1이 s2보다 먼저 나오도록 함. -> 결론적으로는 역순 정렬

// Closure Expression Syntax
//  { (Parameters) -> Returntype in
//      statements
//  }

reversedNames = names.sorted(by: {(s1: String, s2: String) -> Bool in
    return s1 > s2
})

// Inferring Type From Context 자료형 추론?
reversedNames = names.sorted(by: {s1, s2 in return s1 > s2}) // 이렇게 인자로서 넘겨주는 경우에는 거의 추론이 가능

// Single Expression 인 경우에는 아래와 같이 implicit return이 가능함
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 })

// Shorthand Argument Names
reversedNames = names.sorted(by: { $0 > $1 }) // sorted(by:)가 String을 요구하기 때문에 타입 추론 가능

// Operator Methods
reversedNames = names.sorted(by: >) // > is a method

// Trailing Closures 후위 클로저 -> 함수의 마지막 인자가 클로저이고 이게 길다면 후위 클로저 사용
reversedNames = names.sorted() { $0 > $1 }
reversedNames = names.sorted { $0 > $1 }

let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output // !쓰는이유 -> dictionary subscripts return an optional value
        number /= 10
    } while number > 0
    return output
}

// Capturing Values
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount // capture two values: runningTotal and amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen() // 10
incrementByTen() // 20
incrementByTen() // 30
incrementByTen() // 40
// incrementByTen은 상수인데 어떻게 값이 계속 변함? --> 클로저는 참조 타입(reference type)이기 때문.

// Escaping Closures:
// 함수의 인자로서 클로저를 받고, 해당 클로저가 함수가 끝나고도 호출되도록 하고 싶으면, 인자 앞에 @escaping을 붙인다.
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler) // 나중에도 호출 가능
}
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure() // 함수 안에서 끝남
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 } // self 꼭 명시
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
completionHandlers.first?()
print(instance.x)

// Autoclosures
// 함수에 인자로서 넘길 때 쓰임. 자동 클로저는 인자 값이 없음. 실제 계산을 나중으로 미룰 수 있음.
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = { customersInLine.remove(at: 0) } // 여기서는 실행 안됨 -> delaying evaluation
print(customersInLine.count)

print("Now serving \(customerProvider())!")
print(customersInLine.count)

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) }) // 클로저 넣어 주기

func serve2(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve2(customer: customersInLine.remove(at: 0)) // @autoclosure 명시했으니까, 클로저의 리턴 값과 같은 값 넣어 주기

