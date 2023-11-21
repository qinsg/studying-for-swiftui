//
//  ContentView.swift
//  WeSplit
//
//  Created by James Qin on 2023/11/10.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var checkAmount = 100.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    @FocusState private var amountIsFocused: Bool
    
    var noTips: Bool {
        if tipPercentage == 0 {
            return true
        } else {
            return false
        }
    }
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
//        let tipSelection = Double(tipPercentage)
//        let tipValue = checkAmount / 100 * tipSelection
//        let grandTotal = checkAmount + tipValue
        let amountPerPerson = totalAmount / peopleCount
        return amountPerPerson
        //return 0
    }
    var totalAmount: Double {
        let tipSelection: Double = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
//
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    Picker("Tip percentage", selection: $tipPercentage) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
                        ForEach(0..<101) {
                            Text("\($0)%")
                        }
                    }
                    // .pickerStyle(.segmented)
                }
                Section("Total amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(noTips ? .red : .black)
                }
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
//                Section {
//                    
//                }
//                Section {
//                    
//                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        //        Form {
////            TextField("Enter your name:", text: $name)
////            Text("Hello, \(name)")
//            ForEach(0..<100) {
//                Text("Row \($0)")
//            }
//        }
//        Button("Tap Count \(tapCount)") {
//            self.tapCount += 1
//        }
//        NavigationStack{
//            Form {
//                Picker("Select your student", selection: $selectedStudent) {
//                    ForEach(students, id: \.self) {
//                        Text($0)
//                    }
//                }
////                Section {
////                    Text("Hello, World.")
////                    Text("Hello, World.")
////                    Text("Hello, World.")
////                    Text("Hello, World.")
////                }
////                Section {
////                    Text("Hello, World.")
////                    Text("Hello, World.")
////                    Text("Hello, World.")
////                    Text("Hello, World.")
////                    Text("Hello, World.")
////                    Text("Hello, World.")
////                }
//            }
//            .navigationTitle("SwiftUI")
//            .navigationBarTitleDisplayMode(.inline)
////            
//        }
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
    }
}

#Preview {
    ContentView()
}
