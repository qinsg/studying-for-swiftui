//
//  ContentView.swift
//  Navigation
//
//  Created by James Qin on 2023/12/19.
//

import SwiftUI

//struct SimpleNavigationView: View {
//    var body: some View {
//        NavigationStack {
//            List(0..<100) { i in
//                NavigationLink("Select \(i)", value: i)
//            }
//            .navigationDestination(for: Int.self) { selection in
//                    DetailView(number: selection)
//            }
//        }
//    }
//}

//struct ProgramIntView: View {
//    @State private var path = [Int]()
//    
//    var body: some View {
//        NavigationStack(path: $path) {
//            VStack {
//                Button("Show 32"){
//                    path = [32]
//                }
//                Button("Show 64") {
//                    path.append(64)
//                }
//                Button("Show 32 then 64") {
//                    path = [32, 64]
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                DetailView(number: selection)
//            }
//        }
//    }
//}

struct ProgramPathView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(0..<5) { i in
                    NavigationLink("Select Number: \(i)", value: i)
                }
                ForEach(0..<5) { i in
                    NavigationLink("Select String: \(i)", value: String(i))
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected the number \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected the string \(selection)")
            }
            .toolbar{
                Button("Push 556") {
                    path.append(556)
                }
                Button("Push Hello") {
                    path.append("Hello")
                }
            }
        }
        
    }
}

struct ContentView: View {
    @State private var pathStore = PathStore()
    
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView(number: 0, pathStore: $pathStore)
                .navigationDestination(for: Int.self) {i in
                    DetailView(number: i, pathStore: $pathStore)
                }
        }
    }
}

#Preview {
    ContentView()
}
