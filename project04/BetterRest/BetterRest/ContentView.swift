//
//  ContentView.swift
//  BetterRest
//
//  Created by James Qin on 2023/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmout = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Stepper("\(sleepAmout.formatted()) Hours", value: $sleepAmout, in: 4...12, step: 0.25)
            let tomorrow = Date.now.addingTimeInterval(86400)
            let rang = Date.now...tomorrow
            
            DatePicker("Please enter a date:", selection: $wakeUp, in: rang)
                .labelsHidden()
//
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .shortened))
        }
        .padding()
    }
    
    func getTody() -> Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? .now
        return date
    }
    
}

#Preview {
    ContentView()
}
