//
//  APIError.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 21/09/2025.
//

import Foundation

enum APIError: Error, LocalizedError, Sendable {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError(Error)
    case encodingError(Error)
    case httpError(statusCode: Int, data: Data?)
    case missingAuthToken
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .invalidResponse:
            return "Invalid response received from server"
        case .noData:
            return "No data received from server"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .encodingError(let error):
            return "Failed to encode request: \(error.localizedDescription)"
        case .httpError(let statusCode, _):
            return "HTTP error with status code: \(statusCode)"
        case .missingAuthToken:
            return "Missing authentication token"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .invalidURL:
            return "Check the URL configuration"
        case .invalidResponse, .noData:
            return "Try again later or contact support"
        case .decodingError:
            return "The server response format may have changed"
        case .encodingError:
            return "Check the request data format"
        case .httpError(let statusCode, _):
            return HTTPStatusCode.recoverySuggestion(for: statusCode)
        case .missingAuthToken:
            return "Please log in again"
        case .networkError:
            return "Check your internet connection"
        }
    }
}

// Extension pour les codes de statut HTTP
extension APIError {
    enum HTTPStatusCode {
        static func recoverySuggestion(for statusCode: Int) -> String {
            switch statusCode {
            case 400:
                return "Check your request parameters"
            case 401:
                return "Please authenticate again"
            case 403:
                return "You don't have permission to access this resource"
            case 404:
                return "The requested resource was not found"
            case 429:
                return "Too many requests. Please wait and try again"
            case 500...599:
                return "Server error. Please try again later"
            default:
                return "Please try again or contact support"
            }
        }
    }
}
