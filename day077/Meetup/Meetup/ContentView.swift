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
    
    var body: some View {
        if showMap {
            MapView()
        } else {
            ListView()
        }
    }
}

#Preview {
    ContentView()
}
