//
//  ContentView.swift
//  iExpense
//
//  Created by James Qin on 2023/12/12.
//

import SwiftUI
import Observation

@Observable
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct UserTestView: View {
    @State private var user = User()
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
        .padding()
    }
}

struct SecondtView: View {
    @Environment(\.dismiss) var dismiss
    
    let name: String
    
    var body: some View {
        // Text("hello, \(name)")
        Button("Dissmiss") {
            dismiss()
        }
    }
}

struct ShowOrHideView: View {
    @State private var user = User()
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondtView(name: "qinsg")
        }
    }
}

struct DeleteDemoView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationStack{
            VStack {
                List{
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: { indexSet in
                        numbers.remove(atOffsets: indexSet)
                    })
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct UserDefaultView: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
        .frame(width: 232, height: 44, alignment: .center)
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        .font(.title)
    }
}

struct AppStorageView: View {
    @AppStorage("tapCount") private var tapCount = 0
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
        .frame(width: 232, height: 44, alignment: .center)
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        .font(.title)
    }
}

struct CodeUser: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State private var user = CodeUser(firstName: "Taylor", lastName: "Swift")
    
    
    var body: some View {
        Form{
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
            
            Button("Save User") {
                let encoder = JSONEncoder()
                
                if let data = try? encoder.encode(user) {
                    print("save user:")
                    print(user)
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }
            
            Button("Get User") {
                let decoder = JSONDecoder()
                
                let defaults = UserDefaults.standard
                
                if let data = defaults.value(forKey: "UserData") as? Data {
                    if let codeUser = try? decoder.decode(CodeUser.self, from: data){
                        user = codeUser
                        print(user)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
