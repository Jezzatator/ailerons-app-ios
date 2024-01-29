//
//  SupbaseAPIClientProtocol.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 29/01/2024.
//

import Foundation
import Supabase

protocol SupbaseAPIClientProtocol {
    
    var supabase: SupabaseClient { get }
    
    func fetch<T: SupabaseAPIRequestProtocol>(
        _ request: T,
        completion: @escaping ResultCallback<T.Response>
    ) async throws
    
}
