//
//  GenericRepository.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 21/09/2025.
//

import Foundation

final class GenericRepository<Model: Codable & Sendable>: DataRepository, @unchecked Sendable {
    private let httpClient: HTTPClient
    private let configuration: BackendConfiguration
    
    init(httpClient: HTTPClient, configuration: BackendConfiguration) {
        self.httpClient = httpClient
        self.configuration = configuration
    }
    
    func fetch<T: DataRequest>(_ request: T) async throws -> T.Response where T.Response == [Model] {
        return try await httpClient.perform(request, configuration: configuration)
    }
    
    func create<T: DataRequest>(_ request: T, model: Model) async throws where T.Response == Model {
        // Implémentation pour POST
        fatalError("Create not implemented yet")
    }
    
    func update<T: DataRequest>(_ request: T, model: Model) async throws where T.Response == Model {
        // Implémentation pour PUT/PATCH
        fatalError("Update not implemented yet")
    }
    
//    func delete<T: DataRequest>(_ request: T, id: String) async throws where T.Response == Void {
//        // Implémentation pour DELETE
//        fatalError("Delete not implemented yet")
//    }
}
