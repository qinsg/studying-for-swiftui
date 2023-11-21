import UIKit

//struct Album {
//    let title: String
//    let artist: String
//    let year: Int
//    
//    func printSummary() {
//        print("\(title) (\(year)) by \(artist)")
//    }
//}
//
//let red = Album(title: "Red", artist: "Taylar Swift", year: 2012)
//let wings = Album(title: "Wings", artist: "BTS", year: 2016)
//
//print(red.title)
//print(wings.artist)
//
//red.printSummary()
//wings.printSummary()
//
//struct Employee {
//    let name: String
//    var vacationRemaining: Int
//    
//    mutating func takeVacation(days: Int) {
//        if vacationRemaining > days {
//            vacationRemaining -= days
//            print("I'm going on vacation!")
//            print("Days remaining: \(vacationRemaining)")
//        } else {
//            print("Oops! There aren't enough days remaining.")
//        }
//    }
//}
//
//var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
//archer.takeVacation(days: 5)
//print(archer.vacationRemaining)

struct Employee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    var vacationRemaining: Int {
        // vacationAllocated - vacationTaken
        get {
            vacationAllocated - vacationTaken
        }
        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

//var archer = Employee(name: "Sterling", vacationAllocated: 14)
//archer.vacationTaken += 4
//print(archer.vacationRemaining)
//archer.vacationTaken += 4
//print(archer.vacationRemaining)

var archer = Employee(name: "Sterling Archer", vacationAllocated: 14)
archer.vacationTaken += 4
print(archer.vacationRemaining)
archer.vacationRemaining = 5
print(archer.vacationAllocated)

struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }
        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")

// 定义十二星座的array
let zodiacSigns = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo",
                   "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"]
// 定义中国所有省份的字典
let provinces = ["Hebei": 74_000_000, "Shandong": 95_000_000, "Shaanxi": 37_000_000,
                 "Gansu": 26_000_000, "Qinghai": 6_000_000, "Fujian": 39_000_000,
                 "Guangdong": 104_000_000, "Guangxi": 48_000_000, "Hainan": 9_000_000,
                 "Yunnan": 48_000_000, "Guizhou": 35_000_000, "Sichuan": 83_000_000,
                 "Hubei": 59_000_000, "Hunan": 68_000_000, "Jiangxi": 46_000_000,
                 "Anhui": 60_000_000, "Jiangsu": 79_000_000, "Zhejiang": 55_000_000,
                 "Henan": 95_000_000, "Shanxi": 37_000_000, "Inner Mongolia": 25_000_000,
                 "Liaoning": 43_000_000, "Jilin": 27_000_000, "Heilongjiang": 38_000_000,
                 "Xinjiang": 21_000_000, "Ningxia": 6_000_000, "Beijing": 21_000_000,
                 "Tianjin": 15_000_000, "Shanghai": 24_000_000, "Chongqing": 30_000_000,
                 "Tibet": 3_000_000]

// 定义所有省份的字典，key用拼音，值用省份的中文名称
let provincesInChinese = ["Hebei": "河北", "Shandong": "山东", "Shaanxi": "陕西",
                          "Gansu": "甘肃", "Qinghai": "青海", "Fujian": "福建",
                          "Guangdong": "广东", "Guangxi": "广西", "Hainan": "海南",
                          "Yunnan": "云南", "Guizhou": "贵州", "Sichuan": "四川",
                          "Hubei": "湖北", "Hunan": "湖南", "Jiangxi": "江西",
                          "Anhui": "安徽", "Jiangsu": "江苏", "Zhejiang": "浙江",
                          "Henan": "河南", "Shanxi": "山西", "Inner Mongolia": "内蒙古",
                          "Liaoning": "辽宁", "Jilin": "吉林", "Heilongjiang": "黑龙江",
                          "Xinjiang": "新疆", "Ningxia": "宁夏", "Beijing": "北京",
                          "Tianjin": "天津", "Shanghai": "上海", "Chongqing": "重庆",
                          "Tibet": "西藏"]
