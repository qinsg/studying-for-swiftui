//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by James Qin on 2024/4/8.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
