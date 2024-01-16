//
//  SupabaseAPI.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import Foundation
import Supabase

class SupabaseAPI: ObservableObject {
    
    @Published var testIndiv: [SupaIndiv] = []
    
    let supabase = SupabaseClient(supabaseURL: URL(string: ProcessInfo.processInfo.environment["SUPABASE_URL"]!)!, supabaseKey: ProcessInfo.processInfo.environment["SUPABASE_KEY"]!)
    
    func fetch() async {
        do {
        let data: [SupaIndiv] = try await supabase.database
                .from("individual")
                .select()
                .execute()
                .value
            
            DispatchQueue.main.async {
                self.testIndiv = data
            }
        } catch {
            print("Error while fetching supabase : \(error.localizedDescription)")
        }
    }
    
}
