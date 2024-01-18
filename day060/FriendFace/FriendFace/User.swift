//
//  User.swift
//  FriendFace
//
//  Created by James Qin on 2024/1/17.
//

import Foundation

struct User: Identifiable, Codable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
