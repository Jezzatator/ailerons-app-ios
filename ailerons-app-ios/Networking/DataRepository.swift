//
//  DataRepository.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 21/09/2025.
//

import Foundation

protocol DataRepository: Sendable {
    associatedtype Model: Codable & Sendable
    
    func fetch<T: DataRequest>(_ request: T) async throws -> T.Response where T.Response == [Model]
    func create<T: DataRequest>(_ request: T, model: Model) async throws where T.Response == Model
    func update<T: DataRequest>(_ request: T, model: Model) async throws where T.Response == Model
//    func delete<T: DataRequest>(_ request: T, id: String) async throws where T.Response == Void
}
