//
//  HistoricalEvent.swift
//  EraMap
//
//  Created by Can Arda on 19.03.26.
//

import Foundation
import CoreLocation

struct HistoricalEvent: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let year: Int
    let era: Era
    let latitude: Double
    let longitude: Double
    let imageName: String?
    let significance: Int

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var displayYear: String {
        year < 0 ? "\(abs(year)) BC" : "AD \(year)"
    }
}
