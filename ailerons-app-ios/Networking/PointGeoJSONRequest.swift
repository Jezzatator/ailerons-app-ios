//
//  PointGeoJSONRequest.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 29/01/2024.
//

import Foundation

struct PointGeoJSONRequest: SupabaseAPIRequestProtocol {
    typealias Response = [PointGeoJSON]
    
    var tableName: String {
        return "point_geojson"
    }
}
// Créez une structure représentant la requête pour récupérer les pointsGeoJSON de Supabase
