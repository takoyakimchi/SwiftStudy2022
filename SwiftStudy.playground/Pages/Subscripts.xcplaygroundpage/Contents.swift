// subscript -> 배열 원소에 간단하게 접근하는 문법!

// read-only subscript 구현
struct TimeTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index // read-only
    }
}
let threeTimesTable = TimeTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")

// matrix using subscripts
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
//let someValue = matrix[2, 2]
//print(matrix)

// type subscripts
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let planet = Planet[4]
print(planet)
