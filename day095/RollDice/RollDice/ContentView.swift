//
//  ContentView.swift
//  RollDice
//
//  Created by James Qin on 2024/5/7.
//

import SwiftUI

struct ContentView: View {
    @State private var total = 0
    @State private var score = 0
    @State private var history = [Int]()
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Score:")
                    .font(.title)
                Text(String(total))
                    .font(.largeTitle)
            }
            Spacer()
//            ScrollView(.vertical) {
//                VStack(alignment: .leading) {
//                    ForEach(0..<history.count, id: \.self) {index in
//                        Text(String(history[index]))
//                    }
//                }
//                
//            }
//            .defaultScrollAnchor(.top)
//            .frame(width: 300, height: 200)
//            .background(.gray)
            HStack {
                HStack {
                    if history.count > 1 {
                        Text("Previous:")
                            .font(.title)
                        Text(String(history[history.count-2]))
                            .font(.largeTitle)
                    }
                }
                Spacer()
                HStack {
                    if !history.isEmpty {
                        Text("Last:")
                            .font(.title)
                        Text(String(history[history.count-1]))
                            .font(.largeTitle)
                    }
                }
            }
            Spacer()
            Text(String(score))
                .font(.largeTitle)
                .frame(width: 100, height: 100)
                .background(.purple)
            Spacer()
            Spacer()
            Button("Start") {
                roll()
            }
            
            Spacer()
        }
    }
    
    func roll() {
        score = Int.random(in: 1...6)
        history.append(score)
        total += score
    }
}

#Preview {
    ContentView()
}
