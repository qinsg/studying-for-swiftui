//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by James Qin on 2024/4/30.
//

import SwiftUI

struct ContentView1:View {
    var body: some View {
        HStack {
            Text("Important")
                .frame(width: 200)
                .background(.blue)
            
//            Image(.photo)
//                .resizable()
//                .scaledToFit()
//                .containerRelativeFrame(.horizontal) { size, axis in
//                    size * 0.8
//                }
            GeometryReader { proxy in
                Image(.photo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width * 0.8)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            
        }
    }
}

struct ContentView2: View {
    var body: some View {
        GeometryReader { proxy in
            Image(.photo)
                .resizable()
                .scaledToFit()
                .frame(width: proxy.size.width * 0.8)
                
        }
    }
}

struct ContentView3: View {
    var body: some View {
        VStack {
            GeometryReader { proxy in
                Text("Hello, world.")
                    .frame(width: proxy.size.width * 0.9, height: 40)
                    .background(.red)
            }
            .background(.green)
            
            Text("More text")
                .background(.blue)
        }
    }
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader {proxy in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Gloabal center: \(proxy.frame(in: .global).midX) x \(proxy.frame(in: .global).midY)")
                        print("Custom center: \(proxy.frame(in: .named("Custom")).midX) x \(proxy.frame(in: .named("Custom")).midY)")
                        print("Local center: \(proxy.frame(in: .local).midX) x \(proxy.frame(in: .local).midY)")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}

struct ContentView4: View {
    var body: some View {
        OuterView().background(.red)
            .coordinateSpace(name: "Custome")
    }
}

struct ContentView5: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) {index in
                    GeometryReader {proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(
                                .degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5,
                                                      axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct ContentView6: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    GeometryReader { proxy in
                        Text("Number \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .rotation3DEffect(
                                .degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    Text("Number \(num)")
                        .font(.largeTitle)
                        .padding()
                        .background(.red)
                        .frame(width: 200, height: 200)
                        .visualEffect { content, proxy in
                            content
                                .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                        }
                    }
                    //.frame(width: 200, height: 200)
                }
            }
    }
}

#Preview {
    ContentView()
}
