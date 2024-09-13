//
//  SupabaseAPIService.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 30/01/2024.
//

import Foundation
import MapKit

class SupabaseAPIService: SupbaseAPIClientProtocol {
    
    func fetch<T>(_ request: T, router: SupabaseAPIRouter, completion: @escaping ResultCallback<T.Response>) async throws where T : SupabaseAPIRequestProtocol {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        
        guard let url = components.url else { return }
        
        var urlRequest: URLRequest {
            let accessToken = ProcessInfo.processInfo.environment["SUPABASE_KEY"]!
            var request = URLRequest(url: url)
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            request.addValue(accessToken, forHTTPHeaderField: "apikey")
            request.httpMethod = "GET"
            return request
        }
        
        let session = URLSession(configuration: .default)
        
        do {
            let (data, _) = try await session.data(for: urlRequest)
            
            let responseObject = try JSONDecoder().decode(T.Response.self, from: data)
            DispatchQueue.main.async {
                completion(.success(responseObject))
            }
            
        } catch {
            completion(.failure(error))
            print("Error during data task: \(error)")
        }
    }
}
