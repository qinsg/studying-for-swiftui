//
//  DetailView.swift
//  Meetup
//
//  Created by James Qin on 2024/3/22.
//

import SwiftUI

struct DetailView: View {
    @State private var viewModel: ViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Text(viewModel.meetup.name)
    }
    
    init(meetup:Meetup) {
        viewModel = ViewModel(meetup: meetup)
    }
}

#Preview {
    let meetup = Meetup(id: UUID(), photo: "xx", name: "Meet Alian")
    return DetailView(meetup: meetup)
}
