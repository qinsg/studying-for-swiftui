//
//  ContentView.swift
//  Navigation
//
//  Created by James Qin on 2023/12/19.
//

import SwiftUI

struct Navi: Hashable, Identifiable {
    var id = UUID()
    var name: String
}

struct CustomizingNaviView: View {
    @State private var pathStore = PathStore()
    
    
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                Text("Row \(i)")
            }
            .navigationTitle("Title goes here")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct BoolBarButtonView: View {
    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Tap me") {
                            
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Or tap me") {
                            
                        }
                    }
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("Tap me") {
                            
                        }
                        Button("Tap me 2"){
                            
                        }
                    }
                }
        }
    }
}
struct EditableTitleView:View {
    @State private var title = "SwiftUI"
    
    var body: some View {
        NavigationStack{
            Text("Hello, world")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView: View {
    @State private var path:[Navi]
    
    var body: some View {
        NavigationStack {
            List(self.path){ navi in
                NavigationLink(navi.name, value: navi)
            }
            .navigationDestination(for: Navi.self) { navi in
                Text("You selected \(navi.name)")
            }
            
        }
    }
    
    init() {
        self.path = [
                    Navi(name: "name1"),
                    Navi(name: "name2"),
                    Navi(name: "name3")
                ]
    }
}

#Preview {
    ContentView()
}
