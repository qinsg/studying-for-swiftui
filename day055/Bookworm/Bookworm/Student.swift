//
//  Student.swift
//  Bookworm
//
//  Created by James Qin on 2024/1/5.
//

import Foundation
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
