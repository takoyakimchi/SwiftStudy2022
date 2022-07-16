// 상수
let maximumNumberOfLoginAttempts = 10
// 변수
var currentLoginAttempt = 0
var x = 0.0, y = 0.0, z = 0.0

// 자료형 지정하기
var welcomeMessage: String
welcomeMessage = "Hello World!"
var red, green, blue: Double

// print
print(welcomeMessage)
print(welcomeMessage, terminator: "")   // 줄바꿈 없이 출력하는 것
print("welcomeMessage: \(welcomeMessage)")

// 2진수, 8진수, 16진수
let decimalInteger = 17
let binaryInteger = 0b10001
let octalInteger = 0o21
let hexadecimalInteger = 0x11

// 읽기 쉽게 숫자 쓰기
let oneMillion = 1_000_000
print(oneMillion)

// Int + Double 할 때는 무조건 형변환 필수!
let three = 3
let pointOne = 0.1
let pi = Double(three) + pointOne
print(pi)

// Type Alias -> 자료형의 별칭을 지정. 문맥상 더 맞는 이름을 쓰고 싶을 때 사용!
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min

// Booleans
let orangesAreOrange = true
let turnipsAreDelicious = false

if turnipsAreDelicious{
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}

let i = 1
// swift에서는 아래와 같이 쓰면 에러가 발생함  !!!
//if i {
//    print("i is true")
//}
if i == 1 {
    print("i == 1")
}

// 튜플
let http404Error = (404, "Not Found")
let (statusCode, statusMessage) = http404Error
print(statusCode, statusMessage)

let (justStatusCode, _) = http404Error  // 튜플에서 일부만 필요하다면 이렇게 쓸 수도 있음.
print(justStatusCode)

print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")
//print(http404Error[0]) 이건 안되는구나 ..

let http200Status = (statusCode: 200, description: "OK")    // 이렇게 이름 지정해 놓으면 나중에 이걸로 액세스 가능.
print("The status code is \(http200Status.0)")
print("The status code is \(http200Status.statusCode)")     // both are okay.

// Optional -> 값이 존재하지 않을 수도 있을 때 사용!
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)   // 모든 String이 Int로 바뀔 수 있는 건 아님.
                                            // 그래서 convertedNumber는 Int? 이고, 이건 Int가 들어 있거나 값이 아예 없는 것임.

var serverRespondeCode: Int? = 404
serverRespondeCode = nil    // 아무런 값도 안 들어 있다는 뜻

var surveyAnswer: String?   // 이러면 default로 nil이 들어간다.

if convertedNumber != nil {
    // 값이 존재하는 게 확실한 경우에는 convertedNumber! 처럼 느낌표(!) 를 붙인다 -> forced unwrapping.
    print("convertedNumber has an integer value of \(convertedNumber!)")
}

let myNumber = Int(possibleNumber)
if let myNumber = myNumber {
    print("My number is \(myNumber)")
}

// Assertions
let age = -3
//assert(age >= 0, "A person's age can't be less than zero.")

// nil-coalescing operator   a ?? b
// optional a가 값을 포함하면 unwrap, 그게 아니라면 b(디폴트 값)을 반납한다.
let defaultColorName = "red"
var userDefinedColorName: String?
var colorNameToUse = userDefinedColorName ?? defaultColorName
print(colorNameToUse)

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
print(colorNameToUse)

// Range Operators
// -> closed range
for index in 1...5 {
    print("\(index) * 5 = \(index * 5)")
}

// -> half open range
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i+1) is called \(names[i])")
}

let values = [0, 1, 2, 3, 4, 5]
// -> one-sided range
for v in values[2...] {
    print(v)
}

for v in values[...2] {
    print(v)
}

for v in values[..<3] {
    print(v)
}

// String
let threeDoubleQuotationMarks = """
Escaping "the" first quotation mark
Escaping ""all"" three quotation marks \"\"\"
"""
print(threeDoubleQuotationMarks)

print(#"Hello\nWorld"#)
print(#"Hello\#nWorld"#)
print(####"Hello\####nWorld"####)

var exclamationMark: Character = "!"    // 단일문자.
print(exclamationMark, "\n")

let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)   // Character의 배열로 String을 구성할 수도 있음!
print(catString)

var string1 = "Hello"
string1.append(" World")    // String을 append 가능 (var일 때)
string1.append(exclamationMark) // Character도 append 가능 (var일 때)
print(string1)

// String에서 index의 개념이 완전히 다르다는 것을 알아두자.
let greeting = "Guten Tag!"
print(greeting[greeting.startIndex]) // G
print(greeting[greeting.index(before: greeting.endIndex)]) // !
print(greeting[greeting.index(after: greeting.startIndex)]) // u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
print(greeting[index]) // a

// 반복할 때는 이렇게
for index in greeting.indices {
    print("\(greeting[index])", terminator: " ")
}

// 문자열 삽입
var welcome = "Hello"
welcome.insert("!", at: welcome.endIndex)
welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
print(welcome)

// 문자열 삭제
welcome.remove(at: welcome.index(before: welcome.endIndex))
print(welcome)
let range = welcome.index(welcome.endIndex, offsetBy: -6) ..< welcome.endIndex
welcome.removeSubrange(range)

// Substrings
let helloWorld = "Hello, world!"
let idx = helloWorld.firstIndex(of: ",") ?? greeting.endIndex
let beginning = helloWorld[..<idx]
print(beginning)
let newString = String(beginning)
print(newString)

// 배열
var someInts: [Int] = []
someInts.append(123)
print(someInts)

var threeDoubles = Array(repeating: 0.0, count: 3)
print(threeDoubles)

var stringArray = ["Aaa", "Bbb", "Ccc", "Ddd"]
stringArray.insert("Hello", at: 1)
print(stringArray)

let removedElement = stringArray.remove(at: 0)
print(removedElement)

let lastElement = stringArray.removeLast()
print(lastElement)

// Set Type
var letters = Set<Character>()
letters.insert("a")
letters.insert("a")
print(letters)

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip Hop"]
// var favoriteGenres: Set = ["Rock", "Classical", "Hip Hop"] also okay

print(favoriteGenres.sorted())
print(favoriteGenres)

var favoriteGenres_: Set = ["Rock", "Classical", "Hip Hop"]
print(favoriteGenres_)

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
oddDigits.intersection(evenDigits).sorted()
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()

let subsetExample: Set = [1, 2, 3]
let supersetExample: Set = [1, 2, 3, 4, 5]
let disjointExample: Set = [7, 8]

print(subsetExample.isSubset(of: supersetExample))
print(supersetExample.isSuperset(of: subsetExample))
print(disjointExample.isDisjoint(with: supersetExample))

// Dictionary
var nameOfIntegers: [Int: String] = [:]
nameOfIntegers[16] = "Sixteen"
nameOfIntegers[2] = "Two"
print(nameOfIntegers)

var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
var airportsShorter = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

airports["LHR"] = "London"
print(airports)

// updateValue method: 키가 없으면 설정하고 있으면 update 하기
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue)")
}

// Dictionary -> removing value
if let removedValue = airports.removeValue(forKey: "DUB") {
    print("Removed value is \(removedValue)")
} else {
    print("There is no value for DUB")
}

// Iterating over a Dictionary
for (airportCode, airportName) in airports {
    print("Code: \(airportCode), Name: \(airportName)")
}

// Dictionary --> Array
let airportCodes = [String](airports.keys)
let airportNames = [String](airports.values)

