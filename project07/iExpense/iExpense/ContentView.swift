//
//  ContentView.swift
//  iExpense
//
//  Created by James Qin on 2023/12/12.
//

import SwiftUI
import Observation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showAddExpense = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    ForEach(expenses.items.filter{ $0.type == "Business"}) { item in
                        HStack {
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle((item.amount < 10.0) ? .green : (item.amount < 100.0) ? .blue :.red)
                        }
                    }
                    .onDelete{ offsets in
                        for i in offsets.makeIterator() {
                            let theItem = expenses.items.filter{ $0.type == "Business"}[i]
                            for index in 0..<expenses.items.count {
                                if (expenses.items[index].id == theItem.id) {
                                    expenses.items.remove(at: index)
                                }
                            }
                        }
                    }
                }
                List {
                    ForEach(expenses.items.filter{ $0.type == "Personal"}) { item in
                        HStack {
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle((item.amount < 10.0) ? .green : (item.amount < 100.0) ? .blue :.red)
                        }
                    }
                    .onDelete{ offsets in
                        for i in offsets.makeIterator() {
                            let theItem = expenses.items.filter{ $0.type == "Personal"}[i]
                            for index in 0..<expenses.items.count {
                                if (expenses.items[index].id == theItem.id) {
                                    expenses.items.remove(at: index)
                                }
                            }
                        }
                    }
                }
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus"){
                    showAddExpense = true
//                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
//                    expenses.items.append(expense)
                }
            }
            .navigationTitle("iExpense")
            .sheet(isPresented: $showAddExpense){
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let theItem = expenses.items.filter{ $0.type == "Personal"}[i]
            print("id=\(theItem.id) name=\(theItem.name)")
            for index in 0..<expenses.items.count {
                let item = expenses.items[index]
                print("for loop: index=\(index) id=\(item.id) name=\(item.name)")
                
            // ForEach(expenses.items.indices) { index in
                if (expenses.items[index].id == theItem.id) {
                    print("index=\(index)  name=\(expenses.items[index].name)")
                    expenses.items.remove(at: index)
                }
            }
        }
    }
    
    
//    func removeItems(at offsets: IndexSet){
//        print("offsets:\(offsets)")
//        for i in offsets.makeIterator() {
//            print("i=\(i)")
//            let theItem = expenses.items[i]
//            ForEach(expenses.items) { item in
//                if item.id == theItem.id {
//                    expenses.
//                }
//            }
//            // expenses.items.remove(at: theItem.self)
//        }
//        // expenses.items.remove(atOffsets: offsets)
//    }
}

#Preview {
    ContentView()
}
