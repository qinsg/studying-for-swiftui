//
//  DetailView.swift
//  Navigation
//
//  Created by James Qin on 2023/12/19.
//

import SwiftUI

struct DetailView: View {
    var number: Int
    @Binding var pathStore: PathStore
    
    var body: some View {
        VStack {
            NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
                .navigationTitle("Number: \(number)")
                .toolbar {
                    Button("Home") {
                        pathStore.path = NavigationPath()
                    }
                }
        }
    }
    
//    init(number: Int) {
//        self.number = number
//        print("Creating detail view \(number)")
//    }
}

//#Preview {
//    @State var path = [32]
//    DetailView(number: 3, path: $path)
//}
