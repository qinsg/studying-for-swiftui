//
//  ContentView.swift
//  SnowSeeker
//
//  Created by James Qin on 2024/5/8.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    @State private var sortOrder = [
        SortDescriptor(\Resort.id),
        SortDescriptor(\Resort.name),
        SortDescriptor(\Resort.country)
    ]
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    var sortedResorts: [Resort] {
        filteredResorts.sorted(using: sortOrder)
    }
    
    var body: some View {
        NavigationSplitView {
            List(sortedResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        VStack(alignment: .leading){
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                    }
                    if favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                            .foregroundStyle(.red)
                    }
                }
            }
            
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resrot")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder){
                        Text("Sort by Default")
                            .tag([
                                SortDescriptor(\Resort.id),
                                SortDescriptor(\Resort.name),
                                SortDescriptor(\Resort.country)
                            ])
                        Text("Sort by Alphabetical")
                            .tag([
                                SortDescriptor(\Resort.name),
                                SortDescriptor(\Resort.id),
                                SortDescriptor(\Resort.country)
                            ])
                        Text("Sort by Country")
                            .tag([
                                SortDescriptor(\Resort.country),
                                SortDescriptor(\Resort.id),
                                SortDescriptor(\Resort.name)
                            ])
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
    
}

#Preview {
    ContentView()
}
