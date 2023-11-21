import UIKit

let employee1 = [
    "name": "John",
    "job": "singer",
    "location": "Nanjing"
]

print(employee1["job1", default: "Unknown"])

let hasGraduated = [
    "Eric": false,
    "Maeve": true,
    "Otis": false
]
print(hasGraduated["Otis", default: false])

let olympics = [
    2012: "london",
    2016: "Rio de Janeiro",
    2021: "tokyo"
]
print(olympics[2012, default: "Unknown"])

// create a set
var people = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "James"])
print(people)

var (inserted, memberAfterInsert) = people.insert("James");
if !inserted {
    print("\(memberAfterInsert) already exists")
}

var readings = Set([true, false, true, true])
print(readings)

var cities: Set<String> = ["nanjing", "Shanghai", "Beijing"]
print(cities)

let staffReviews = Set([1, 2, 1, 2, 3])

enum Weekday{
    case monday
    case tuesday
    case friday
}

enum Season{
    case summer, fall, winter, spring
}

var day = Weekday.monday
day = Weekday.tuesday
day = Weekday.friday

print(Weekday.monday)
print(day)

var workday = Weekday.monday
day = .tuesday
day = .monday

let username: String
username = "James"
print(username)
