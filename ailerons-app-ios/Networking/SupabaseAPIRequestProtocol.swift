//
//  SupabaseAPIRequestProtocol.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 29/01/2024.
//

import Foundation

typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

protocol SupabaseAPIRequestProtocol: Encodable {
    associatedtype Response: Decodable
    
    var tableName: String { get } //endpoint individual ou point_geojson
}
