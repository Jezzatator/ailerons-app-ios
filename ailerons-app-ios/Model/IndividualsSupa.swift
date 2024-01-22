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
    let geoJSON: Geojson
    
    enum CodingKeys: String, CodingKey {
        case id
        case individualID = "individual_id"
        case geoJSON = "geojson"
    }
}

struct PointGeoJSON: Codable, Identifiable {
    let id: Int
        let createdAt: String
        let csvID, individualID, recordID: Int
        let geojson: Geojson

        enum CodingKeys: String, CodingKey {
            case id
            case createdAt = "created_at"
            case csvID = "csv_id"
            case individualID = "individual_id"
            case recordID = "record_id"
            case geojson
        }
    }

    // MARK: - Geojson
    struct Geojson: Codable {
        let type: String
        let features: [Feature]
    }

    // MARK: - Feature
    struct Feature: Codable {
        let type: FeatureType
        let properties: Properties
        let geometry: Geometry
    }

    // MARK: - Geometry
    struct Geometry: Codable {
        let coordinates: [Double]
        let type: GeometryType
    }

    enum GeometryType: String, Codable {
        case point = "Point"
    }

    // MARK: - Properties
    struct Properties: Codable {
        let individualID: Int
        let indCommonName: IndCommonName
        let indName: IndName
        let icon: Int?
        let timestamp: Timestamp

        enum CodingKeys: String, CodingKey {
            case individualID = "individual_id"
            case indCommonName = "ind_common_name"
            case indName = "ind_name"
            case icon, timestamp
        }
    }

    enum IndCommonName: String, Codable {
        case raieBan = "Raie Ban"
        case requin = "Requin"
        case requinPape = "Requin Pape"
    }

    enum IndName: String, Codable {
        case fonzy = "Fonzy"
        case jeanPaul = "Jean-Paul"
        case jeanPaulII = "Jean-Paul II"
    }

    enum Timestamp: Codable {
        case dateTime(Date)
        case integer(Int)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Int.self) {
                self = .integer(x)
                return
            }
            if let x = try? container.decode(Date.self) {
                self = .dateTime(x)
                return
            }
            throw DecodingError.typeMismatch(Timestamp.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Timestamp"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .dateTime(let x):
                try container.encode(x)
            case .integer(let x):
                try container.encode(x)
            }
        }
        
        func toInt() -> Int {
               switch self {
               case .dateTime(let date):
                   return Int(date.timeIntervalSince1970)
               case .integer(let value):
                   return value
               }
           }
    }

    enum FeatureType: String, Codable {
        case feature = "Feature"
    }
