//
//  ContentView.swift
//  Edutainment
//
//  Created by James Qin on 2023/12/5.
//

import SwiftUI

struct NumberButton: View {
    let number: Int
    let action: () -> Void
    
    init(number: Int, action: @escaping () -> Void) {
        self.number = number
        self.action = action
    }
    
    var body: some View {
        let label = Label{
            
        }icon: {
            Circle()
                .frame(width: 44,height: 44, alignment: .center)
                .overlay(Text("\(number)")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                )
        }
        
        Button{
            action()
        } label: {
            label
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                )
                .compositingGroup()
                .shadow(radius: 5, x:0, y: 3)
                .contentShape(Rectangle())
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct SubmitButton: View {
    let img: String = "sun.max"
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button{
            action()
        } label: {
            Label("Submit", systemImage: img)
                .frame(width: 112,height: 44, alignment: .center)
                .font(.headline)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.green)
                )
                .compositingGroup()
                .shadow(radius: 5, x:0, y: 3)
                .contentShape(Rectangle())
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct ContentView: View {
    @State private var level = 9
    @State private var first = Int.random(in: 1...9)
    @State private var second = Int.random(in: 1...9)
    @State private var result = 0
    @State private var hasStarted = false
    @State private var showAlert = false
    
    var answer: Int {
        return first * second
    }
    
    var body: some View {
        NavigationStack {
            Form{
                Section("Please select the level") {
                    Stepper("\(level) * \(level)", value: $level, in: 2...12, step: 1, onEditingChanged: onEditingChanged)
                }
                Section("Please answer"){
                    HStack(alignment:.center) {
                        Spacer()
                        Text("\(first)")
                        Spacer()
                        Text("*")
                        Spacer()
                        Text("\(second)")
                        Spacer()
                        Text("=")
                        Spacer()
                        Text(hasStarted ? "\(result)" : "")
                        Spacer()
                    }
                }
                Section("Please click the button"){
                    VStack {
                        HStack {
                            NumberButton(number: 0, action: {
                                clickAnswer(0)
                            })
                            Spacer()
                            NumberButton(number: 1, action: {
                                clickAnswer(1)
                            })
                            Spacer()
                            NumberButton(number: 2, action: {
                                clickAnswer(2)
                            })
                            Spacer()
                            NumberButton(number: 3, action: {
                                clickAnswer(3)
                            })
                            
                        }
                        Spacer()
                        HStack {
                            NumberButton(number: 4, action: {
                                clickAnswer(4)
                            })
                            Spacer()
                            NumberButton(number: 5, action: {
                                clickAnswer(5)
                            })
                            Spacer()
                            NumberButton(number: 6, action: {
                                clickAnswer(6)
                            })
                            Spacer()
                            NumberButton(number: 7, action: {
                                clickAnswer(7)
                            })
                        }
                        Spacer()
                        HStack {
                            NumberButton(number: 8, action: {
                                clickAnswer(8)
                            })
                            Spacer()
                            NumberButton(number: 9, action: {
                                clickAnswer(9)
                            })
                            Spacer()
                            if hasStarted {
                                SubmitButton(action: {
                                    checkResult()
                                })
                            } else {
                                Text("")
                                    .frame(width: 112, height: 44, alignment: .center)
                                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edutainment")
            .toolbar{
                Button("Start", action: startGame)
            }
            .alert("Score", isPresented: $showAlert) {
                Button("Continue", action: startGame)
            } message: {
                if result == answer {
                    Text("Your answer is right")
                } else {
                    Text("Your answer is wrong. The correct answer is \(answer)")
                }
            }
        }
    }
    func onEditingChanged(isEditing: Bool){
        if isEditing {
            return
        } else {
            startGame()
        }
    }
    
    func startGame() {
        first = Int.random(in: 1...level)
        second = Int.random(in: 1...level)
        hasStarted = false
        result = 0
    }
    
    func clickAnswer(_ number: Int){
        print("number=\(number)")
        hasStarted = true
        result = result * 10 + number
    }
    
    func checkResult() {
        showAlert = true
    }
}

#Preview {
    ContentView()
}
