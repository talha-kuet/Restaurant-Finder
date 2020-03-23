//
//  VenueCategory.swift
//  Restaurant Finder
//
//  Created by Musaddique Billah Talha on 3/22/20.
//

import Foundation

struct VenueCategory: Codable {
    let categoryId: String
    let name: String
    let icon: VenueCategoryIcon

    private enum CodingKeys: String, CodingKey {
        case categoryId = "id"
        case name
        case icon
    }
}
