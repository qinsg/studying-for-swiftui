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
    @Query(filter: #Predicate<User> { user in
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
    @State private var showingUpcomingOnly = false
    
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            // UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: [SortDescriptor(\User.name)])
            UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    // delete current data
                    try? modelContext.delete(model: User.self)
                    // prepare some sample data
                    let first = User(name: "Ed sheeran\(Int.random(in: 1...100))", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Rosa Diaz\(Int.random(in: 1...100))", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Roy Kent\(Int.random(in: 1...100))", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Johnny English\(Int.random(in: 1...100))", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))
                    
                    // insert sample data
                    modelContext.insert(first)
                    let job1 = Job(name: "Organize sock drawer", priority: 3)
                    let job2 = Job(name: "Make plans with Alex", priority: 4)
                    first.jobs?.append(job1)
                    first.jobs?.append(job2)
                    
                    modelContext.insert(second)
                    let job3 = Job(name: "Organize sock drawer", priority: 3)
                    second.jobs?.append(job3)
                    
                    modelContext.insert(third)
                    let job4 = Job(name: "Make plans with Alex", priority: 4)
                    third.jobs?.append(job4)
                    
                    modelContext.insert(fourth)
                    let job5 = Job(name: "Organize sock drawer", priority: 3)
                    let job6 = Job(name: "Make plans with Alex", priority: 4)
                    fourth.jobs?.append(job5)
                    fourth.jobs?.append(job6)
                }
                Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                    showingUpcomingOnly.toggle()
                }
                //  It will appear a sort menu
//                Picker("Sort", selection: $sortOrder) {
//                    Text("Sort by Name")
//                        .tag([
//                            SortDescriptor(\User.name),
//                            SortDescriptor(\User.joinDate)
//                        ])
//                    
//                    Text("Sort by Join Date")
//                        .tag([
//                            SortDescriptor(\User.joinDate),
//                            SortDescriptor(\User.name)
//                        ])
//                }
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate)
                            ])
                        
                        Text("Sort by Join Date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name)
                            ])
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
