//
//  AddView.swift
//  HabitTracking
//
//  Created by James Qin on 2023/12/22.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Study"
    @State private var description = ""
    @State private var wanted = 1
    
    @Environment(\.dismiss) var dismiss
    
    let types = ["Study", "Working", "Life", "Other"]
    var activities: Activities
    
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(types, id:\.self){
                        Text($0)
                    }
                }
                TextEditor(text: $description)
                    .lineSpacing(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                TextField("Wanted", value: $wanted, format: .number).keyboardType(.numberPad)
                
            }
            Button("Save") {
                let item = ActivityItem(name: name, type: type, description: description, wanted: wanted)
                activities.items.append(item)
                dismiss()
            }
        }
        .navigationTitle("Add Activity")
        .navigationBarTitleDisplayMode(.large)
        .toolbar{
            Button("Save"){
                let item = ActivityItem(name: name, type: type, description: description, wanted: wanted)
                activities.items.append(item)
                dismiss()
            }
        }
    }
   
}

#Preview {
    AddView(activities: Activities())
}
