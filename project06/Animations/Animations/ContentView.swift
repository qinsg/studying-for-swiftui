//
//  ContentView.swift
//  Animations
//
//  Created by James Qin on 2023/11/27.
//

import SwiftUI

struct ContentView: View {
    @State private var antimationAmount = 1.0
    
    var body: some View {
        print(antimationAmount)
        return VStack {
            Button("Tap Me"){
                // antimationAmount += 1
                withAnimation(.spring(duration: 1, bounce: 0.5)) {
                    antimationAmount += 1
                }
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
//            .rotation3DEffect(
//                .degrees(antimationAmount),
//                   axis: (x: 1.0, y: 1.0, z: 0.0)
//            )
            .scaleEffect(antimationAmount)
        }
    }
}

#Preview {
    ContentView()
}
