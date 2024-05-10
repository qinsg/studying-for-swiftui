//
//  Resort.swift
//  SnowSeeker
//
//  Created by James Qin on 2024/5/9.
//

import Foundation
import SwiftData

struct Resort: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    init(id: String, name: String, country: String, description: String, imageCredit: String, price: Int, size: Int, snowDepth: Int, elevation: Int, runs: Int, facilities: [String]) {
        self.id = id
        self.name = name
        self.country = country
        self.description = description
        self.imageCredit = imageCredit
        self.price = price
        self.size = size
        self.snowDepth = snowDepth
        self.elevation = elevation
        self.runs = runs
        self.facilities = facilities
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}
