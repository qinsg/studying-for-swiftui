//
//  UserView.swift
//  SnowSeeker
//
//  Created by James Qin on 2024/5/8.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

#Preview {
    UserView()
}
