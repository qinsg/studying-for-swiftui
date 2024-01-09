//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by James Qin on 2024/1/9.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    // @Query(sort: \User.name) var users: [User]
    @Query(filter: #Predicate<User> { user in
        //user.name.contains("R")
        //user.name.localizedStandardContains("R")
//        user.name.localizedStandardContains("R") &&
//        user.city == "London"
        // !!!important: else branch can't be remove
        if user.name.localizedStandardContains("R") {
            if user.city == "London" {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }, sort: \User.name) var users: [User]
        
    @State private var path = [User]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(users) { user in
                NavigationLink(value: user) {
                    Text(user.name)
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }
            .toolbar {
//                Button("Add User", systemImage: "plus") {
//                    let user = User(name: "", city: "", joinDate: .now)
//                    modelContext.insert(user)
//                    path = [user]
//                }
                Button("Add Samples", systemImage: "plus") {
                    // delete current data
                    try? modelContext.delete(model: User.self)
                    // prepare some sample data
                    let first = User(name: "Ed sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))
                    
                    // insert sample data
                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
