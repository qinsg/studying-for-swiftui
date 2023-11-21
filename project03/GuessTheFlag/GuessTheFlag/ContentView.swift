//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by James Qin on 2023/11/16.
//

import SwiftUI

struct FlagImage: View {
    var img: String
    var body: some View {
        Image(img)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct BigTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var remainRounds = 3
    @State private var showingResetGame = false
    
    var body: some View {
        ZStack {
//            Color.blue
//                .ignoresSafeArea()
//            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
            
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .modifier(BigTitle())
                            //.foregroundStyle(.white)
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
//                            Image(countries[number])
//                                .clipShape(.capsule)
//                                .shadow(radius: 5)
                            FlagImage(img: countries[number])
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
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
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        showingScore = true
        remainRounds -= 1
        if remainRounds == 0 {
            showingResetGame = true
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func resetGame() {
        remainRounds = 8
        score = 0
    }
}

#Preview {
    ContentView()
}
