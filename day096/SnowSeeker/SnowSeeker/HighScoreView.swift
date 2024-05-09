//
//  HighScoreView.swift
//  SnowSeeker
//
//  Created by James Qin on 2024/5/8.
//

import SwiftUI

struct HighScoreView: View {
    @Environment(Player.self) var player: Player
    
    var body: some View {
        @Bindable var player1 = player
        // Text("Your high score: \(player.highScore)")
        Stepper("High score: \(player1.highScore)", value: $player1.highScore)
    }
}

#Preview {
    HighScoreView()
}
