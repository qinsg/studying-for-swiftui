//
//  Meetup.swift
//  Meetup
//
//  Created by James Qin on 2024/3/22.
//

import Foundation

struct Meetup: Codable, Equatable, Identifiable {
    var id: UUID
    var photo: String
    var name: String
    var addDate: Date?
    
    static func ==(lhs: Meetup, rhs: Meetup) -> Bool {
        lhs.id == rhs.id
    }
    
    var formattedAddDate: String {
        addDate?.formatted(date: .abbreviated, time: .standard) ?? "N/A"
    }
    
    #if DEBUG
    static let example = Meetup(id: UUID(), photo: "xx", name: "Meet Alian")
    #endif
}
