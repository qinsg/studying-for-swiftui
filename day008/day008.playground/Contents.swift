import UIKit

var greeting = "Hello, playground"

let data = "Hello, world".data(using: .utf8)!
let decoder = JSONDecoder()
let string = try? decoder.decode(String.self, from: data)

print(string)

enum SqrtError: Error{
    case OutOfBounds, NoRoot
}

func sqrt(_ number: Int) throws -> Int{
    if (number < 1 || number > 10_000) {
        throw SqrtError.OutOfBounds
    }
    var root: Int = 0
    for i in 1...100 {
        if ( i * i == number){
            root = i
            break
        }
    }
    if root == 0 {
        throw SqrtError.NoRoot
    }
    return root
}

var num = 6401
do {
    let root = try sqrt(num)
    print("the square root of \(num) is \(root)")
} catch SqrtError.OutOfBounds {
    print("\(num) out of bounds")
} catch SqrtError.NoRoot {
    print("\(num) no root")
} catch {
    print("Some error.")
}
