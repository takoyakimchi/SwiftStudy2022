// 인스턴스 메소드
class Counter {
    var count = 0
    func increment() { // 인스턴트 메소드
        count += 1
    }
    func increment(by amount: Int){
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()
counter.increment()
counter.increment(by: 50)
counter.reset()

// 인스턴스 메소드 내에서 값 변경
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        // x += deltaX
        // y += deltaY
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 5.0, y: 4.0)

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight.next()

