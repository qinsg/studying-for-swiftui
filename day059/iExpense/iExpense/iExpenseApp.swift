//
//  iExpenseApp.swift
//  iExpense
//
//  Created by James Qin on 2023/12/12.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expenses.self)
    }
}
