//
//  ContentView.swift
//  iExpense
//
//  Created by James Qin on 2023/12/12.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // @State private var expenses = Expenses()
    @Environment(\.modelContext) var modelContext
    @Query(filter: #Predicate<ExpenseItem> { item in
        if item.type == "Business" {
            return true
        } else {
            return false
        }
    }, sort: \ExpenseItem.name) var business: [ExpenseItem]
    
    @Query(filter: #Predicate<ExpenseItem> { item in
        if item.type == "Personal" {
            return true
        } else {
            return false
        }
    }, sort: \ExpenseItem.name) var personal: [ExpenseItem]
    
    @State private var showAddExpense = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    ForEach(business) { item in
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
//                        for i in offsets.makeIterator() {
//                            let theItem = expenses.items.filter{ $0.type == "Business"}[i]
//                            for index in 0..<expenses.items.count {
//                                if (expenses.items[index].id == theItem.id) {
//                                    expenses.items.remove(at: index)
//                                }
//                            }
//                        }
                    }
                }
                List {
                    ForEach(personal) { item in
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
//                        for i in offsets.makeIterator() {
//                            let theItem = expenses.items.filter{ $0.type == "Personal"}[i]
//                            for index in 0..<expenses.items.count {
//                                if (expenses.items[index].id == theItem.id) {
//                                    expenses.items.remove(at: index)
//                                }
//                            }
//                        }
                    }
                }
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus"){
                    showAddExpense = true
//                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
//                    modelContext.insert(expense)
//                    expenses.items.append(expense)
                    
                }
            }
            .navigationTitle("iExpense")
            .sheet(isPresented: $showAddExpense){
                // AddView(expenses: expenses)
                AddView()
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
//            let theItem = expenses.items.filter{ $0.type == "Personal"}[i]
//            print("id=\(theItem.id) name=\(theItem.name)")
//            for index in 0..<expenses.items.count {
//                let item = expenses.items[index]
//                print("for loop: index=\(index) id=\(item.id) name=\(item.name)")
//                
//            // ForEach(expenses.items.indices) { index in
//                if (expenses.items[index].id == theItem.id) {
//                    print("index=\(index)  name=\(expenses.items[index].name)")
//                    expenses.items.remove(at: index)
//                }
//            }
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
