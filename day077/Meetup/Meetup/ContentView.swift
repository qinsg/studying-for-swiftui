//
//  ContentView.swift
//  Meetup
//
//  Created by James Qin on 2024/2/28.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    @State private var showMap = true
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            if showMap {
                MapView()
            } else {
                ListView()
            }
        }
        .sheet(isPresented: $showingSheet, content: {
            EditMeetupView()
        })
        HStack(spacing: 50) {
            Button("Add Meetup") {
                showingSheet = true
            }
        }
    }
}

#Preview {
    ContentView()
}
