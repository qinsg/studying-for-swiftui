//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by James Qin on 2024/1/17.
//

import SwiftUI
import SwiftData

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
