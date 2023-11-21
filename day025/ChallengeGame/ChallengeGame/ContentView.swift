//
//  ContentView.swift
//  ChallengeGame
//
//  Created by James Qin on 2023/11/20.
//

import SwiftUI

struct BigTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            //.font(.largeTitle.weight(.semibold))
            .font(.system(size: 100))
            .foregroundStyle(.red)
    }
}

struct ContentView: View {
    @State private var roshambots = ["Rock", "Paper", "Scissors"]
    @State private var selectedItem = Int.random(in: 0...2);
    @State private var shouldWin = true
    @State private var score = 0
    @State private var remainRounds = 3
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var showingResetGame = false
    
//    var needWin: Bool {
//        return Bool.random()
//    }
//    var selectedItem: Int {
//        return Int.random(in: 0...2)
//    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Select Roshambot")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15){
                    VStack{
                        Image(roshambots[selectedItem])
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    Text("You need to ")
                        .font(.title)
                        .foregroundStyle(.secondary)
                    Text(shouldWin ? "Win" : "Fail")
                        .modifier(BigTitle())
                        
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Text("Please select your answer ")
                    .font(.title)
                    .font(.subheadline.weight(.heavy))
                    .foregroundStyle(.white)
                VStack(spacing: 20) {
                    HStack(alignment: .center, spacing: 30){
                        ForEach(0..<roshambots.count) { number in
                            Button{
                                itemTapped(number)
                            }label: {
                                Image(roshambots[number])
                                    .resizable()
                                    .frame(width: 80,height: 80)
                            }
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Text("Remain Round: \(remainRounds)")
                    .foregroundStyle(.white)
                    .font(.title)
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score), remain rounds is \(remainRounds)")
        }
        .alert("Reset Game", isPresented: $showingResetGame) {
            Button("Reset Game", action: resetGame)
        } message: {
            Text("Your score is \(score)")
        }
    }
    func itemTapped(_ number: Int) {
        //
        print("number = \(number)")
        var result: Bool = false
        
        let item = roshambots[selectedItem]
        switch item {
            case "Rock":
                if shouldWin && roshambots[number].elementsEqual("Paper"){
                    result = true
                }
                if !shouldWin && roshambots[number].elementsEqual("Scissors"){
                    result = true
                }
            case "Paper":
                if shouldWin && roshambots[number].elementsEqual("Scissors"){
                    result = true
                }
                if !shouldWin && roshambots[number].elementsEqual("Rock"){
                    result = true
                }
            case "Scissors":
                if shouldWin && roshambots[number].elementsEqual("Rock"){
                    result = true
                }
                if !shouldWin && roshambots[number].elementsEqual("Paper"){
                    result = true
                }
            default:
                print("default")
        }
        
        if result {
            score += 1
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        // print("Number: \(number)")
        showingScore = true
        
        remainRounds -= 1
        if remainRounds == 0 {
            showingResetGame = true
        }
    }
    func askQuestion() {
        selectedItem = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    func resetGame() {
        remainRounds = 10
        selectedItem = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
