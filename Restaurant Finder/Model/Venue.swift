//
//  Venue.swift
//  Restaurant Finder
//
//  Created by Musaddique Billah Talha on 3/22/20.
//

import Foundation

struct Venue: Codable {
    let venueId: String
    let name: String
    let location: Location
    let categories: [VenueCategory]?

    private enum CodingKeys: String, CodingKey {
        case venueId = "id"
        case name
        case location
        case categories
    }
}
