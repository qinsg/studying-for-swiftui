//
//  ContentView.swift
//  Navigation
//
//  Created by James Qin on 2023/12/19.
//

import SwiftUI


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
struct ContentView:View {
    @State private var title = "SwiftUI"
    
    var body: some View {
        NavigationStack{
            Text("Hello, world")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
