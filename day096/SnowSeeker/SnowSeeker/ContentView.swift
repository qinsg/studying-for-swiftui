//
//  ContentView.swift
//  SnowSeeker
//
//  Created by James Qin on 2024/5/8.
//

import SwiftUI

struct ContentView1: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all), preferredCompactColumn: .constant(.detail)) {
            NavigationLink("Primary") {
                Text("New view")
            }
            NavigationLink("Second") {
                Text("Second view")
            }
            .navigationTitle("Main")
        } content: {
            Text("Sub Menu")
                .navigationTitle("Content")
        } detail: {
            Text("detail")
                .navigationTitle("Detail")
            Button("Tap Me") {
                selectedUser = User()
                isShowingUser.toggle()
            }
            .sheet(item: $selectedUser) { user in
                Text(user.id)
                    .presentationDetents([.medium, .large])
            }
//            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
//                Button(user.id) { }
//            }
        }
        .navigationSplitViewStyle(.balanced)
        
    }
}

struct ContentView2: View {
    @State private var layoutVertically = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
//            VStack {
//                UserView()
//            }
            VStack(content: UserView.init)
        } else {
//            HStack {
//                UserView()
//            }
            HStack(content: UserView.init)
        }
        
        Button {
            layoutVertically.toggle()
        } label: {
            Text("Change")
        }
        
    }
}

struct TestViewThatFitsView: View {
    var body: some View {
        ViewThatFits {
            Rectangle()
                .frame(width: 500, height: 200)
            
            Circle()
                .frame(width: 200, height: 200)
        }
    }
}

struct SearchableContentView: View {
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
    var filteredNAmes: [String] {
        if searchText.isEmpty {
            allNames
        } else {
            allNames.filter { $0.localizedStandardContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredNAmes, id: \.self) { name in
                Text(name)
            }
            // make sure the view is inside a NavigationStack, otherwise nowhere to put the search box
            // Text("Searching for \(searchText)")
                .searchable(text: $searchText, prompt: "Look for something")
                .navigationTitle("Searching")
        }
    }
}

struct ContentView: View {
    @State private var player = Player()
    
    var body: some View {
        VStack {
            Text("Welcome")
            HighScoreView()
        }
        .environment(player)
    }
}

#Preview {
    ContentView()
}
