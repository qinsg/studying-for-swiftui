//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by James Qin on 2024/4/30.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                log("ScrollView: width=\(fullView.size.width) height=\(fullView.size.height)")
                ForEach(0..<50) {index in
                    GeometryReader {proxy in
                        let opacity = (200 + proxy.frame(in: .global).minY) / fullView.size.height
                        log("opacity=\(opacity)")
                        
                        let scale = min(max((proxy.frame(in: .global).minY) / (fullView.size.height / 2), 0.5), 1.5)
                        log("scale=\(scale)")
                        
                        let hue = min(opacity, 1.0)
                        
                        Text("Row #\(index) \(scale)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            //.background(colors[index % 7])
                            .background(Color(hue: hue, saturation: 1.5, brightness: 1.0))
                            .scaleEffect(scale)
                            .opacity(opacity)
                            .rotation3DEffect(
                                .degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(height: 40)
                }
            }
        }
    }
    
    func computeScale(minY: CGFloat, height: CGFloat) -> CGFloat{
        var scale = minY / (height / 2)
        if scale > 1.5 {
            scale = 1.5
        } else if ( scale < 0.5 ) {
            scale = 0.5
        }
        return scale
    }
    
}

#Preview {
    ContentView()
}
