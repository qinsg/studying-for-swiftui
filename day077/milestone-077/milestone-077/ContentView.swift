//
//  ContentView.swift
//  milestone-077
//
//  Created by James Qin on 2024/2/27.
//

import SwiftUI

extension BinaryInteger {
    static func *(lhs: Self, rhs: Double) -> Double {
        return Double(lhs) * rhs
    }
    
    static func *(lhs: Double, rhs: Self) -> Double {
        return lhs * Double(rhs)
    }
}

@propertyWrapper
struct NonNegative<Value: BinaryInteger> {
    var value: Value
    
    init(wrappedValue: Value) {
        if wrappedValue < 0 {
            value = 0
        } else {
            value = wrappedValue
        }
    }
    
    var wrappedValue: Value {
        get {value}
        set {
            if newValue < 0 {
                value = 0
            } else {
                value = newValue
            }
        }
    }
}

struct User {
    @NonNegative var score = 0
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: test)
    }
    
    func test() {
        let exmpleInt: Int64 = 50_000_000_000_000_001
        print(exmpleInt)
        
        let result = exmpleInt * 1.0
        print(String(format: "%.0f", result))
        
        var example = NonNegative(wrappedValue: 5)
        example.wrappedValue -= 10
        print(example.wrappedValue)
        
        var user = User()
        user.score += 10
        print(user.score)
        user.score -= 20
        print(user.score)
    }
}

#Preview {
    ContentView()
}
