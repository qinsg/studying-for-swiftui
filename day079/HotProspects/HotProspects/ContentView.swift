//
//  ContentView.swift
//  HotProspects
//
//  Created by James Qin on 2024/4/8.
//

import SwiftUI

struct SelectedView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    // @State private var selection: String?
    @State private var selection = Set<String>()
    @State private var selectedTab = "One"
    
    var body: some View {
        
        List(users, id: \.self, selection: $selection) { user in
        //List(users, id: \.self) { user in
            Text(user)
        }
        if selection.isEmpty == false {
            Text("You selected \(selection.formatted())")
        }
        EditButton()
    }
}

struct ContentView: View {
    @State private var selectedTab = "One"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .tabItem {
                    Label("One", systemImage: "star")
                }
                .tag("One")
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
            Button("Show tab 2"){
                selectedTab = "Two"
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
        }
    }
}

#Preview {
    ContentView()
}
