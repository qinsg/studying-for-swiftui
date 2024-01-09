//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by James Qin on 2024/1/9.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
