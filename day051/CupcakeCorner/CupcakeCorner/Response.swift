//
//  Response.swift
//  CupcakeCorner
//
//  Created by James Qin on 2023/12/26.
//

import Foundation

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct Response: Codable {
    var results: [Result]
}
