//
//  ContentView.swift
//  Animations
//
//  Created by James Qin on 2023/11/27.
//

import SwiftUI

struct ContentView: View {
    let letters = Array("Hello SwiftUI")
    @State private var antimationAmount = 1.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) {num in
                    Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 2), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(.rect(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.bouncy) {
                            dragAmount = .zero
                        }
                    }
            )
            //.animation(.bouncy, value: dragAmount)
            
//        print(antimationAmount)
//        return VStack {
//            Button("Tap Me"){
//                enabled.toggle()
//                // antimationAmount += 1
////                withAnimation(.spring(duration: 1, bounce: 0.5)) {
////                    antimationAmount += 1
////                }
//            }
//            .padding(50)
//            .background(enabled ? .red : .blue)
//            .foregroundStyle(.white)
//            .animation(.default, value: enabled)
////            .rotation3DEffect(
////                .degrees(antimationAmount),
////                   axis: (x: 1.0, y: 1.0, z: 0.0)
////            )
//            .scaleEffect(antimationAmount)
//            .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
//            .animation(.spring(duration: 2, bounce: 0.9), value: enabled)
//        }
    }
}

#Preview {
    ContentView()
}
