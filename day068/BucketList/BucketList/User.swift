//
//  User.swift
//  BucketList
//
//  Created by James Qin on 2024/1/25.
//

import Foundation

struct User: Identifiable, Comparable {
    let id = UUID()
    var firstName: String
    var lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}
