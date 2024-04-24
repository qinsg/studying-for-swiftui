//
//  ContentView.swift
//  Flashzilla
//
//  Created by James Qin on 2024/4/23.
//

import SwiftUI

struct DifferentiateWithoutColorView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    // let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    // tolerance can help save battery power.
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        VStack {
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }
                Text("Success")
            }
            .padding()
            .background(differentiateWithoutColor ? .black : .green)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            
            Text("Hello, World")
                .onReceive(timer, perform: { time in
                    if counter == 5 {
                        timer.upstream.connect().cancel()
                        print("The timer is stopped.")
                    } else {
                        print("The time is now \(time)")
                    }
                    
                    counter += 1
                })
                .onChange(of: scenePhase) { oldValue, newValue in
                    if newValue == .active {
                        print("Active")
                    } else if newValue == .inactive {
                        print("Inactive")
                    } else if newValue == .background {
                        print("Background")
                    } else {
                        print("Unknown")
                    }
                }
        }
        .contentShape(.rect)
        .onTapGesture {
            print("VStack tapped")
        }
    }
}

struct ReduceMotionView: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    
    var body: some View {
        Button("Hello, World!"){
            if reduceMotion {
                scale *= 1.5
            } else {
                withAnimation {
                    scale *= 1.5
                }
            }
        }
        .scaleEffect(scale)
    }
}

struct OptionalAnimationView: View {
    @State private var scale = 1.0
    
    var body: some View {
        Button("Hello, World!") {
            withOptionalAnimation {
                scale *= 1.5
            }
        }
        .scaleEffect(scale)
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws ->Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

struct ContentView: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        Text("Hello, World")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundStyle(.white)
            .clipShape(.capsule)
    }
}

#Preview {
    ContentView()
}
