//
//  PlaceMarker.swift
//  Restaurant Finder
//
//  Created by Musaddique Billah Talha on 3/21/20.
//

import UIKit
import GoogleMaps

class PlaceMarker: GMSMarker {
  
    let venue: Venue
  
    init(venue: Venue) {

        self.venue = venue
        super.init()

        position = CLLocationCoordinate2D(latitude: venue.location.latitude, longitude: venue.location.longitude)
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
        icon = GMSMarker.markerImage(with: .blue)
    }

}
