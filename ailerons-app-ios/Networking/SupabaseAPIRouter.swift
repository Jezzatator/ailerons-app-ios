//
//  SupabaseAPIRouter.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 30/01/2024.
//

import Foundation

enum SupabaseAPIRouter {
    case individual
    
    var scheme: String {
        switch self {
        case .individual:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .individual :
            return ProcessInfo.processInfo.environment["SUPABASE_URL"]!
        }
    }
    
    var path: String {
        switch self {
        case .individual:
            return "/rest/v1/individual"
        }
    }
}
