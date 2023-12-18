//
//  MissionView.swift
//  Moonshot
//
//  Created by James Qin on 2023/12/18.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) {width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                if mission.formattedLaunchDate != "N/A" {
                    Text(mission.formattedLaunchDate)
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.5))
                        .padding(.vertical)
                }
                VStack(alignment:.leading) {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    Text("Mission Hightlights")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
//                    Rectangle()
//                        .frame(height: 2)
//                        .foregroundStyle(.lightBackground)
//                        .padding(.vertical)
                    NavigationLink{
                        CrewView(crew: crew, mission: mission)
                    }label: {
                        Text("Crew")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                            .padding(.bottom, 5)
                    }
                    
                }
                .padding(.horizontal)
                
                
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map{ member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
