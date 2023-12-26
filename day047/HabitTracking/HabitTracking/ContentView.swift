//
//  ContentView.swift
//  HabitTracking
//
//  Created by James Qin on 2023/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showAddActivity = false
    @State private var path = NavigationPath()
    @State private var currentItem = ActivityItem()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(activities.items) { item in
                    HStack {
                        VStack(alignment: .leading, content: {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        })
                        
                        Spacer()
                        Text(String(item.wanted))
                        Text(String(item.finished))
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        path.append(item)
                    }
                }
                
            }
            .navigationDestination(for: ActivityItem.self, destination: { selection in
                DetailView(path: $path, activities: $activities, item: selection)

            })
            .navigationTitle("Habit Tracking")
            .toolbar {
                Button("Add Activity", systemImage: "plus"){
                    showAddActivity = true
                }
            }
            .sheet(isPresented: $showAddActivity, content: {
                AddView(activities: activities)
            })
        }
    }
}

#Preview {
    ContentView()
}
