//
//  Location.swift
//  BucketList
//
//  Created by James Qin on 2024/1/26.
//

import Foundation
import MapKit

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
