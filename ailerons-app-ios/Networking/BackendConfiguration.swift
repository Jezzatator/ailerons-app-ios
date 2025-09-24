//
//  BackendConfiguration.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 21/09/2025.
//

import Foundation

protocol BackendConfiguration: Sendable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var authenticationMethod: AuthenticationMethod { get }
}

enum AuthenticationMethod: Sendable {
    case bearer(String)
    case apiKey(String, header: String)
    case basic(username: String, password: String)
    case none
}

// MARK: - Configuration Supabase
struct SupabaseConfiguration: BackendConfiguration {
    let baseURL: URL
    let headers: [String: String]
    let authenticationMethod: AuthenticationMethod
    
    init() {
        guard let urlString = ProcessInfo.processInfo.environment["SUPABASE_URL"],
              let url = URL(string: urlString),
              let apiKey = ProcessInfo.processInfo.environment["SUPABASE_KEY"] else {
            fatalError("Missing Supabase environment variables: SUPABASE_URL and SUPABASE_KEY")
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.path = "/rest/v1"
        
        guard let restURL = components.url else {
            fatalError("Invalid Supabase URL configuration")
        }
        
        self.baseURL = restURL
        
        self.headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Prefer": "return=representation"
        ]
        
        self.authenticationMethod = .apiKey(apiKey, header: "apikey")
    }
}

