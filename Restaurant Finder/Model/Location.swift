//
//  Location.swift
//  Restaurant Finder
//
//  Created by Musaddique Billah Talha on 3/22/20.
//

import Foundation

struct Location: Codable {
    let address: String?
    let latitude: Double
    let longitude: Double

    private enum CodingKeys: String, CodingKey {
        case address
        case latitude = "lat"
        case longitude = "lng"
    }
}
