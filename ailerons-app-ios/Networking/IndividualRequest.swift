//
//  IndividualRequest.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 29/01/2024.
//

import Foundation

struct IndividualRequest: SupabaseAPIRequestProtocol {
    typealias Response = [SupaIndiv]
    
    var tableName: String {
        return "individual"
    }
}
// Créez une structure représentant la requête pour récupérer les individus de Supabase
