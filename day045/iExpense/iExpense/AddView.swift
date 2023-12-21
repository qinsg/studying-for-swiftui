//
//  AddView.swift
//  iExpense
//
//  Created by James Qin on 2023/12/13.
//

import SwiftUI

struct AddView: View {
    @State private var name = "新项目"
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Binding var path: NavigationPath
    
    // @Environment(\.dismiss) var dismiss
    
    let types = ["Business", "Personal"]
    
    var expenses: Expenses
    
    var body: some View {
        //NavigationStack{
            Form {
                // TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            // Hide back button so that the program can check and save
            .navigationBarBackButtonHidden()
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    //dismiss()
                    path = NavigationPath()
                }
            }
        //}
    }
}

//#Preview {
//    AddView(expenses: Expenses())
//}
