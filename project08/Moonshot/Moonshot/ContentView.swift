//
//  ContentView.swift
//  Moonshot
//
//  Created by James Qin on 2023/12/15.
//

import SwiftUI

struct GridLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) {mission in
                    NavigationLink {
                        //Text("Detail View")
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
        }
    }
}

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List {
            ForEach(missions) {mission in
                NavigationLink {
                    //Text("Detail View")
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack(alignment:.center) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                        
                    }
                    .frame(width: 300, height: 50, alignment: .leading)
                    // .background(.white)
                }
            }
        }
    }
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showList = true
    
    var body: some View {
        NavigationStack {
            Group {
                //            ScrollView {
                if showList {
                    ListLayout(astronauts: astronauts, missions: missions)
                }else{
                    GridLayout(astronauts: astronauts, missions: missions)
                }
                //}
            }
            .navigationTitle("Moonshot")
            .toolbar {
                Button(showList ? "Display as Grid" : "Display as List") {
                    showList.toggle()
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    ContentView()
}
