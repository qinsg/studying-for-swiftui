//
//  DetailView.swift
//  HabitTracking
//
//  Created by James Qin on 2023/12/22.
//

import SwiftUI

struct DetailView: View {
    @Binding var path: NavigationPath
    @Binding var activities: Activities
    
    var item: ActivityItem
    
    var body: some View {
        Form{
            Section("Activity Name"){
                Text(item.name)
            }
            Section("Type"){
                Text(item.type)
            }
            Section("Description"){
                Text(item.description)
            }
            Section("The number of times you want to do"){
                Text(String(item.wanted))
            }
            Section("The number of times you have finished") {
                Text(String(item.finished))
            }
            Button("Finished One Time"){
                var newItem = item
                newItem.finished += 1
                if let index = activities.items.firstIndex(of: item) {
                    activities.items[index] = newItem
                }
                path = NavigationPath()
            }
        }.navigationTitle("Detail of Activity")
    }
}

//#Preview {
struct DetailView_Previews: PreviewProvider {
    @State static var path = NavigationPath()
    @State static var item = ActivityItem(name: "Studing swiftUI", type: "Study", description: "A plan for improvement,A plan for improvement,A plan for improvement,A plan for improvement", wanted: 10)
    @State static var activities = Activities()
    
    static var previews: some View {
        DetailView(path: $path, activities: $activities, item: item)
    }
}
