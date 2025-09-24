//
//  HTTPClient.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 21/09/2025.
//

import Foundation

protocol HTTPClient: Sendable {
    func perform<T: DataRequest>(_ request: T, configuration: BackendConfiguration) async throws -> T.Response
}

final class URLSessionHTTPClient: HTTPClient, @unchecked Sendable {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func perform<T: DataRequest>(_ request: T, configuration: BackendConfiguration) async throws -> T.Response {
        let url = configuration.baseURL.appendingPathComponent(request.endpoint)
        var urlRequest = URLRequest(url: url)
        
        // Configuration des headers de base
        configuration.headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        // Configuration de l'authentification
        switch configuration.authenticationMethod {
        case .bearer(let token):
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
        case .apiKey(let key, let header):
            urlRequest.setValue(key, forHTTPHeaderField: header)
            urlRequest.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
            
        case .basic(let username, let password):
            let credentials = "\(username):\(password)".data(using: .utf8)?.base64EncodedString() ?? ""
            urlRequest.setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
            
        case .none:
            break
        }
        
        // Ajout des paramètres de requête pour GET
        if let parameters = request.parameters, !parameters.isEmpty {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
            
            guard let urlWithParams = components.url else {
                throw APIError.invalidURL
            }
            
            urlRequest.url = urlWithParams
        }
        
        urlRequest.httpMethod = "GET" // Par défaut GET, configurable plus tard
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            // Vérification du code de statut HTTP
            guard 200...299 ~= httpResponse.statusCode else {
                throw APIError.httpError(statusCode: httpResponse.statusCode,  data: data)
            }
            
            // Décodage de la réponse
            do {
                let decoder = JSONDecoder()
                // Configuration du decoder pour les dates si nécessaire
                decoder.dateDecodingStrategy = .iso8601
                
                return try decoder.decode(T.Response.self, from: data)
            } catch {
                throw APIError.decodingError(error)
            }
            
        } catch let error as APIError {
            // Re-throw APIError tel quel
            throw error
        } catch {
            // Wrap autres erreurs dans networkError
            throw APIError.networkError(error)
        }
    }
}
