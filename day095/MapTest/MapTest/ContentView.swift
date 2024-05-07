//
//  ContentView.swift
//  MapTest
//
//  Created by James Qin on 2024/5/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: testMap)
    }
    
    func testMap() {
        let numbers = ["1", "2", "fish", "3"]
        let eventsMap = numbers.map(Int.init)
        let eventsCompactMap = numbers.compactMap(Int.init)
        print("eventsMap=\(eventsMap)")
        print("eventsCompactMap=\(eventsCompactMap)")
    }
}

#Preview {
    ContentView()
}
