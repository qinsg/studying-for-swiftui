//
//  ContentView.swift
//  UnitConvertor
//
//  Created by James Qin on 2023/11/12.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    @State private var inputValue = 0.0
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    @FocusState private var isInputFocused: Bool
    
    var outputValue: Double {
        var value = 0.0
        switch inputUnit {
        case 0:
            switch outputUnit {
            case 0:
                value = inputValue
            case 1:
                value = inputValue * 9 / 5 + 32
            case 2:
                value = inputValue + 273.15
            default:
                break
            }
        case 1:
            switch outputUnit {
            case 0:
                value = (inputValue - 32) * 5 / 9
            case 1:
                value = inputValue
            case 2:
                value = (inputValue - 32) * 5 / 9 + 273.15
            default:
                break
            }
        case 2:
            switch outputUnit {
            case 0:
                value = inputValue - 273.15
            case 1:
                value = (inputValue - 273.15) * 9 / 5 + 32
            case 2:
                value = inputValue
            default:
                break
            }
        default:
            break
        }
        return value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input Value") {
                    TextField("Input", value: $inputValue, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .focused($isInputFocused)
                }
                Section("Input Unit") {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(0..<units.count) {
                            Text("\(units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section("Output Unit") {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(0..<units.count) {
                            Text("\(units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section("Output Value") {
                    Text("\(outputValue, specifier: "%.2f")")
                }
            }
            .navigationTitle("Unit Convertor")
            //.navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isInputFocused {
                    Button("Done") {
                        isInputFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
