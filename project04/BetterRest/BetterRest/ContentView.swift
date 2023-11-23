//
//  ContentView.swift
//  BetterRest
//
//  Created by James Qin on 2023/11/21.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmout = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var bettrBedTime: String {
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(hour + minute), estimatedSleep: sleepAmout, coffee: Int64(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)
        }catch {
            return "0:0"
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                //VStack(alignment: .leading, spacing: 0) {
                Section("When do you want to wake up?") {
//                    Text("When do you want to wake up?")
//                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                //VStack(alignment: .leading, spacing: 0) {
                Section("Desired amount of sleep") {
//                    Text("Desired amount of sleep")
//                        .font(.headline)
                    Stepper("\(sleepAmout.formatted()) hours", value: $sleepAmout, in: 4...12, step: 0.25)
                }
                //VStack(alignment: .leading, spacing: 0) {
                Section("Daily coffee intake"){
//                    Text("Daily coffee intake")
//                        .font(.headline)
                    // Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                    //Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                        ForEach(0..<21) {
                            Text("^[\($0) cup](inflect: true)")
                        }
                    }
                    .labelsHidden()
                }
                Section("Your ideal bedtime is") {
                    Text("\(bettrBedTime)")
                        .font(.largeTitle)
                }
            }
            .navigationTitle("Better Rest")
//            .toolbar {
//                Button("Calculate", action: calculateBedTime)
//            }
//            .alert(alertTitle, isPresented: $showingAlert){
//                Button("OK") {}
//            } message: {
//                Text(alertMessage)
//            }
        }
    }
    
//    func calculateBedTime() {
//        do{
//            let config = MLModelConfiguration()
//            let model = try SleepCalculator(configuration: config)
//            
//            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            let hour = (components.hour ?? 0) * 60 * 60
//            let minute = (components.minute ?? 0) * 60
//            
//            let prediction = try model.prediction(wake: Int64(hour + minute), estimatedSleep: sleepAmout, coffee: Int64(coffeeAmount))
//            let sleepTime = wakeUp - prediction.actualSleep
//            
//            alertTitle = "Your ideal bedtime is..."
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//            // more code here
//        }catch {
//            // something went wrong
//            alertTitle = "Error"
//            alertMessage = "Sorry, there  was a problem calculating your bedtime."
//        }
//        showingAlert = true
//    }
}

#Preview {
    ContentView()
}
