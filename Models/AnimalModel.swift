//
//  AnimalModel.swift
//  app
//
//  Created by Ali Sefa Alparslan on 4.12.2023.
//  Copyright © 2023 KZ. All rights reserved.
//

import Foundation
import CoreLocation

struct AnimalModel: Codable {
    var type: String?
    var kind: String?
    var birthDate: String?
    var name: String?
    var vaccine: [String]?
    var illness: [String]?
    var photos: [String]?
    var coverLater: String?
    var location: [String: Double]? // "45.34,44.17"
    var genre: String?

    func getLongitude() -> Double? {
        if let location = location {
            return location["longitude"]
        }
        return nil
    }

    func getLatitude() -> Double? {
        if let location = location {
            return location["latitude"]
        }
        return nil
    }

    func getLocation() -> Location {
        return Location(longitude: getLongitude(), latitude: getLatitude())
    }

    func get2DLocation() -> CLLocationCoordinate2D? {
        if let latitude = getLatitude(), let longitude = getLongitude() {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        return nil
    }
}

struct Location {
    var longitude: Double?
    var latitude: Double?
}
