//
//  Express.swift
//  iExpense
//
//  Created by James Qin on 2024/1/15.
//

import Foundation
import SwiftData

@Model
class Expenses {
    @Relationship(deleteRule: .cascade) var items = [ExpenseItem]()
    
    init(items: [ExpenseItem] = [ExpenseItem]()) {
        self.items = items
    }
}
