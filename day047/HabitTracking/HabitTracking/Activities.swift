//
//  Activities.swift
//  HabitTracking
//
//  Created by James Qin on 2023/12/22.
//

import Foundation

struct ActivityItem: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    
    // name of activity
    var name: String = ""
    
    // type of activity
    var type: String = ""
    
    // description of the activity
    var description: String = ""
    
    // The number of times you want to do
    var wanted: Int = 0
    
    // The number of times you have finished
    var finished: Int = 0
}

@Observable
class Activities {
    var items = [ActivityItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedItems = try? JSONDecoder().decode([ActivityItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        // if here, create an empty array
        items = []
    }
}
