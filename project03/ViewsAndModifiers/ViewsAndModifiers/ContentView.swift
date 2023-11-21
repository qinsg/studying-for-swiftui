//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by James Qin on 2023/11/18.
//

import SwiftUI

struct ContentView: View {
    // @State private var useRedText = false
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    
    var body: some View {
        VStack {
            motto1
                .foregroundStyle(.red)
                .modifier(Title())
            motto2
                .foregroundStyle(.blue)
        }
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    ContentView()
}
