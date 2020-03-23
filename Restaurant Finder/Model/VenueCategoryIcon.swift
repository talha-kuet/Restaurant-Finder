//
//  VenueCategoryIcon.swift
//  Restaurant Finder
//
//  Created by Musaddique Billah Talha on 3/22/20.
//

import Foundation

struct VenueCategoryIcon: Codable {
    let prefix: String
    let suffix: String

    var categoryIconUrl: String {
        return String(format: "%@%d%@", prefix, 88, suffix)
    }
}
