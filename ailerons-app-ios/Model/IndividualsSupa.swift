//
//  IndividualsSupa.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import Foundation
import MapKit

import Foundation

// MARK: - SupaIndivElement
struct SupaIndivElement: Codable {
    let id: Int
    let createdAt: String
    let individualName: String
    let commonName, binomialName, sex, description: String
    let featureCollection: FeatureCollection?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case individualName = "individual_name"
        case commonName = "common_name"
        case binomialName = "binomial_name"
        case sex, description
        case featureCollection = "feature_collection"
    }
}

// MARK: - FeatureCollection
struct FeatureCollection: Codable {
    let type: String
    let features: [Feature]
}

// MARK: - Feature
struct Feature: Codable {
    let type: FeatureType
    let geometry: Geometry
    let properties: Properties
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: GeometryType
    let coordinates: [Double]
}

enum GeometryType: String, Codable {
    case point = "Point"
}

// MARK: - Properties
struct Properties: Codable {
    let individualID: Int
    let individualName: String
    let timestamp: String

    enum CodingKeys: String, CodingKey {
        case individualID = "individual_id"
        case individualName = "individual_name"
        case timestamp
    }
}

//enum IndividualName: String, Codable {
//    case poupette = "Poupette"
//}

enum FeatureType: String, Codable {
    case feature = "Feature"
}

typealias SupaIndiv = [SupaIndivElement]
