//
//  Individuals.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 12/01/2024.
//

import Foundation

// MARK: - Welcome
struct Individuals: Codable {
    let individuals: [Individual]
}

// MARK: - Individual
struct Individual: Codable {
    let studyID: Int
    let individualLocalIdentifier, individualTaxonCanonicalName: String
    let sensorTypeID, sensorID, individualID: Int
    let locations: [Location]

    enum CodingKeys: String, CodingKey {
        case studyID = "study_id"
        case individualLocalIdentifier = "individual_local_identifier"
        case individualTaxonCanonicalName = "individual_taxon_canonical_name"
        case sensorTypeID = "sensor_type_id"
        case sensorID = "sensor_id"
        case individualID = "individual_id"
        case locations
    }
}

// MARK: - Location
struct Location: Codable {
    let timestamp: Int
    let locationLong, locationLat: Double

    enum CodingKeys: String, CodingKey {
        case timestamp
        case locationLong = "location_long"
        case locationLat = "location_lat"
    }
}
