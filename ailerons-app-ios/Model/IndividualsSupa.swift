//
//  IndividualsSupa.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import Foundation
import MapKit

struct SupaIndiv: Codable, Identifiable {
    
    let id: Int
    let individualName: String
    let commonName: String
    let binomialName: String
    let age: Int
    let size: Int
    let weight: Int
    let sex: String
    let totalDistance: Int
    let description: String
    let icon: Int
    let picture: String
    let pointsGeoJSON: [PointGeoJSON]?
    let linesGeoJSON: [LineGeoJSON]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case individualName = "individual_name"
        case commonName = "common_name"
        case binomialName = "binomial_name"
        case age
        case size
        case weight
        case sex
        case totalDistance = "total_distance"
        case description
        case icon
        case picture
        case pointsGeoJSON = "point_geojson"
        case linesGeoJSON = "line_geojson"
    }

}

struct LineGeoJSON: Codable, Identifiable {
    let id: Int
    let individualID: Int
    let geoJSON: GeoJSON
    
    enum CodingKeys: String, CodingKey {
        case id
        case individualID = "individual_id"
        case geoJSON = "geojson"
    }
}

struct PointGeoJSON: Codable, Identifiable {
    let id: Int
    let individualID: Int
    let geoJSON: GeoJSON
    
    enum CodingKeys: String, CodingKey {
        case id
        case individualID = "individual_id"
        case geoJSON = "geojson"
    }
}

// MARK: - GeoJSON
struct GeoJSON: Codable {
    let type: String
    let geometry: Geometry
    let properties: Properties
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: String
    let coordinates: [Double]
}

// MARK: - Properties
struct Properties: Codable {
    let individualID: Int
    let indCommonName, indName: String
    let icon: Int
    let timestamp: String

    enum CodingKeys: String, CodingKey {
        case individualID = "individual_id"
        case indCommonName = "ind_common_name"
        case indName = "ind_name"
        case icon, timestamp
    }
}
