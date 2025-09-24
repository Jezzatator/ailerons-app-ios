//
//  DataRequest.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 21/09/2025.
//

import Foundation

protocol DataRequest: Sendable {
    associatedtype Response: Codable & Sendable
    var endpoint: String { get }
    var parameters: [String: Any]? { get }
}

// Implémentations spécifiques
struct FetchIndividualsRequest: DataRequest {
    typealias Response = [SupaIndivElement]
    
    var endpoint: String { "individual" }
    var parameters: [String: Any]? { nil }
}

struct FetchPointsRequest: DataRequest {
    typealias Response = [PointGeoJSON]
    
    var endpoint: String { "point_geojson" }
    var parameters: [String: Any]? { nil }
}
