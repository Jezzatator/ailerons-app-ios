//
//  DataService.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 21/09/2025.
//

import Foundation

@MainActor
final class DataService: @unchecked Sendable {
    private let individualRepository: GenericRepository<SupaIndivElement>
    private let pointRepository: GenericRepository<PointGeoJSON>
    
    init(configuration: BackendConfiguration, httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.individualRepository = GenericRepository<SupaIndivElement>(
            httpClient: httpClient,
            configuration: configuration
        )
        self.pointRepository = GenericRepository<PointGeoJSON>(
            httpClient: httpClient,
            configuration: configuration
        )
    }
    
    func fetchIndividuals() async throws -> [SupaIndivElement] {
        let request = FetchIndividualsRequest()
        return try await individualRepository.fetch(request)
    }
    
    func fetchPoints() async throws -> [PointGeoJSON] {
        let request = FetchPointsRequest()
        return try await pointRepository.fetch(request)
    }
}
