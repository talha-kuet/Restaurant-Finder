//
//  CLLocationCoordinate2D+Extensions.swift
//  Restaurant Finder
//
//  Created by Musaddique Billah Talha on 3/21/20.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Equatable {}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return (lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude)
}
