//
//  ContentView.swift
//  FriendFace
//
//  Created by James Qin on 2024/1/17.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    // @State private var users: [User] = [User]()
    @Query(sort: \User.name) var users: [User]
    @State private var isLoaded = false
    
    var body: some View {
        NavigationStack {
            if isLoaded == false {
                ProgressView()
            } else {
                List {
                    ForEach(users) { user in
                        Section{
                            Text("name=\(user.name)")
                            Text("age=\(user.age)")
                            Text("company=\(user.company)")
                        }
                    }
                }
            }
        }
        .onAppear(perform: loadData)
        .padding()
    }
    
    func loadData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    //if let decodeResponse = try decoder.decode([User].self, from: data) {
                    let decodeResponse = try decoder.decode([User].self, from: data)
                    
                    DispatchQueue.main.async {
                        //self.users = decodeResponse
                        try? modelContext.delete(model: User.self)
                        try? modelContext.delete(model: Friend.self)
                        for user in decodeResponse {
                            modelContext.insert(user)
                        }
                        isLoaded = true
                    }
                    return
                }catch{
                    print("Decode failed: \(error.localizedDescription)")
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

#Preview {
    ContentView()
}
