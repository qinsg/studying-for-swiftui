//
//  ListView.swift
//  Meetup
//
//  Created by James Qin on 2024/3/22.
//

import SwiftUI

struct ListView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.meetups) {meetup in
                NavigationLink {
                  DetailView(meetup: meetup)
                } label: {
                    HStack(alignment: .center){
                        Image(meetup.photo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text(meetup.name)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(meetup.formattedAddDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .frame(width: 300, height: 50, alignment: .leading)
                }
            }
        }
    }
}

#Preview {
    ListView()
}
