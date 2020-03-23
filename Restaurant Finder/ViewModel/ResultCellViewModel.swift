//
//  ResultCellViewModel.swift
//  Restaurant Finder
//
//  Created by Musaddique Billah Talha on 3/22/20.
//

import Foundation

struct ResultCellViewModel {
    
    let name: String
    let address: String
    let categoryIconURL: URL?
    let location: Location
    
    init(venue: Venue) {
        
        self.name = venue.name
        self.address = venue.location.address ?? ""
        self.location = venue.location
        
        if let categories = venue.categories {
            if !categories.isEmpty {
                self.categoryIconURL = URL(string: categories[0].icon.categoryIconUrl)
            }
            else {
                self.categoryIconURL = nil
            }
        }
        else {
            self.categoryIconURL = nil
        }
    }
}
