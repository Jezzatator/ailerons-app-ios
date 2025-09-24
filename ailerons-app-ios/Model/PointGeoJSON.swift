//
//  PointGeoJSON.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 21/09/2025.
//

import Foundation

/// Représente un point GeoJSON selon le standard RFC 7946
struct PointGeoJSON: Codable, Sendable, Identifiable {
    let id: Int
    let type: String
    let geometry: PointGeometry
    let properties: PointProperties?
    
    init(id: Int, longitude: Double, latitude: Double, properties: PointProperties? = nil) {
        self.id = id
        self.type = "Feature"
        self.geometry = PointGeometry(coordinates: [longitude, latitude])
        self.properties = properties
    }
}

/// Géométrie d'un point GeoJSON
struct PointGeometry: Codable, Sendable {
    let type: String
    let coordinates: [Double] // [longitude, latitude, elevation?]
    
    init(coordinates: [Double]) {
        self.type = "Point"
        self.coordinates = coordinates
    }
    
    var longitude: Double {
        coordinates.count >= 2 ? coordinates[0] : 0.0
    }
    
    var latitude: Double {
        coordinates.count >= 2 ? coordinates[1] : 0.0
    }
    
    var elevation: Double? {
        coordinates.count >= 3 ? coordinates[2] : nil
    }
}

/// Propriétés associées au point
struct PointProperties: Codable, Sendable {
    let name: String?
    let description: String?
    let category: String?
    let timestamp: Date?
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case category
        case timestamp
    }
}
