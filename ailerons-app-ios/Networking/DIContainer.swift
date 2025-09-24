//
//  DIContainer.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 21/09/2025.
//

import Foundation

final class DIContainer: @unchecked Sendable {
    static let shared = DIContainer()
    
    private let configuration: BackendConfiguration
    private let httpClient: HTTPClient
    
    @MainActor
    private lazy var dataService: DataService = {
        return DataService(
            configuration: configuration,
            httpClient: httpClient
        )
    }()
    
    private init() {
        self.configuration = SupabaseConfiguration()
        self.httpClient = URLSessionHTTPClient()
    }
    
    @MainActor
    func makeSpeciesViewModel() -> SpeciesViewModel {
        return SpeciesViewModel(dataService: dataService)
    }
}
