import UIKit

enum Sizes: Comparable {
    case small
    case medium
    case large
}

let first = Sizes.small
let second = Sizes.large
print(first < second)

let day = 5
print("My true love gave to me…")

switch day {
case 5:
    print("5 golden rings")
    fallthrough
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 French hens")
    fallthrough
case 2:
    print("2 turtle doves")
    fallthrough
default:
    print("A partridge in a pear tree")
}

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for os in platforms {
    print("Swift works great on \(os).")
}

for i in 1...12 {
    print("The \(i) times table:")

    for j in 1...12 {
        print("  \(j) x \(i) is \(j * i)")
    }

    print()
}

for i in 1..<5 {
    print("Counting 1 up to 5: \(i)")
}

var lyric = "Haters gonna"

for _ in 1...5 {
    lyric += " hate"
}
print(lyric)

let names = ["Sterling", "Cyril", "Lana", "Ray", "Pam"]

for _ in names {
    print("[CENSORED] is a secret agent!")
}

// let names1 = ["Piper", "Alex", "Suzanne", "Gloria"]
print(names[1...3])
print(names[1...])

var itemsSold: Int = 0
while itemsSold < 5000 {
    itemsSold += 100
    print(itemsSold)
    if itemsSold % 1000 == 0 {
        print("\(itemsSold) items sold - a big milestone!")
    }
}

for number in 1...100 {
    if(number.isMultiple(of: 3) && number.isMultiple(of: 5)) {
        print("FizzBuzz")
    } else if (number.isMultiple(of: 3)) {
        print("Fizz")
    } else if (number.isMultiple(of: 5)) {
        print("Buzz")
    }else{
        print("\(number)")
    }
}
