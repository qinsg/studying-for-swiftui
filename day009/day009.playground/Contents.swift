import UIKit

//func greetUser() {
//    print("Hi there.")
//}
//
//greetUser()
//var greetCopy = greetUser
//greetCopy()
//
//let sayHello = {(name: String, name2: String) -> (String, String) in
//    return (("Hi, hello.\(name) \(name2)"),"test")
//}
//let (result, name) = sayHello("qin", "shi")
//print(result)
//print(name)
//
//func makeArray(size: Int, generator:() -> Int) -> [Int] {
//    var numbers = [Int]()
//    
//    for _ in 0..<size {
//        let newNumber = generator()
//        numbers.append(newNumber)
//    }
//    return numbers
//}
//
//// we can call it.
//let rolls = makeArray(size: 50) {
//    Int.random(in: 1...20)
//}
//print(rolls)
//
//func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void){
//    print("Call first")
//    first()
//    print("Call second")
//    second()
//    print("Call third")
//    third()
//    print("Done!")
//}
//
//doImportantWork {
//    print("This is the first work.")
//} second: {
//    print("This is the second work.")
//} third: {
//    print("This is the third work.")
//}
//
//var playWithDog = {
//    print("Fetch!")
//}
//func play(using playType: () -> Void) -> String {
//    print("Let's play a game")
//    playType()
//    return "OK"
//}
//let news = play(using: playWithDog)
//print(news)
//
//func makeCake(instructions: () -> Void) {
//    print("Wash hands")
//    print("Collect ingredients")
//    instructions()
//    print("Here's your cake!")
//}
//makeCake {
//    print("Mix egg and flour")
//}


let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
luckyNumbers.filter { !$0.isMultiple(of: 2) }
    .sorted()
    .map { ("\($0) is a lucky number") }
    .forEach { print($0) }

