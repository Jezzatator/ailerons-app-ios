//
//  IndividualsSupa.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import Foundation

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
    }

}

struct lineGeoJSON: Decodable, Identifiable {
    let id: Int
    let individualID: Int
    let geoJSON: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case individualID = "individual_id"
        case geoJSON = "geojson"
    }
}

struct pointGeoJSON: Decodable, Identifiable {
    let id: Int
    let individualID: Int
    let geoJSON: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case individualID = "individual_id"
        case geoJSON = "geojson"
    }
}
