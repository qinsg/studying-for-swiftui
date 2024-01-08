//
//  BookwormApp.swift
//  Bookworm
//
//  Created by James Qin on 2024/1/5.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
