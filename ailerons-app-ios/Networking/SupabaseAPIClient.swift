//
//  SupabaseAPIClient.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import Foundation
import Supabase
import MapKit

// Final moment de la compilation dit a Xcode quelle sera pas subcatégo et va plus vite - bon reflexe a avoir
final class SupabaseAPIClient: SupbaseAPIClientProtocol {
    
    let supabase = SupabaseClient(
        supabaseURL: URL(string: ProcessInfo.processInfo.environment["SUPABASE_URL"]!)!,
        supabaseKey: ProcessInfo.processInfo.environment["SUPABASE_KEY"]!
    )
    
    func fetch<T>(_ request: T, completion: @escaping ResultCallback<T.Response>) async throws where T : SupabaseAPIRequestProtocol {
        
        do {
            let result: T.Response = try await self.supabase.database
                .from(request.tableName)
                .select()
                .execute()
                .value
            
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }
    
    
    
    
    //@Published var testIndiv: [SupaIndiv] = []
    // ca dans le VM
    
    
    //
    //    func fetch(completion: @escaping () -> Void) async {
    //        do {
    //            let individualData: [SupaIndiv] = try await supabase.database
    //                            .from("individual")
    //                            .select()
    //                            .execute()
    //                            .value
    //
    //            //print("Indiv: \(individualData)")
    //            let pointsGeoJSONData: [PointGeoJSON] = try await supabase.database
    //                            .from("point_geojson")
    //                            .select()
    //                            .execute()
    //                            .value
    //
    //            //print("GeoJSON: \(pointsGeoJSONData)")
    //                        // Perform a manual join based on the foreign key relationship
    //            let joinedData = individualData.map { indiv in
    //                            SupaIndiv(
    //                                id: indiv.id,
    //                                individualName: indiv.individualName,
    //                                commonName: indiv.commonName,
    //                                binomialName: indiv.binomialName,
    //                                age: indiv.age,
    //                                size: indiv.size,
    //                                weight: indiv.weight,
    //                                sex: indiv.sex,
    //                                totalDistance: indiv.totalDistance,
    //                                description: indiv.description,
    //                                icon: indiv.icon,
    //                                picture: indiv.picture,
    //                                pointsGeoJSON: pointsGeoJSONData.filter { $0.individualID == indiv.id },
    //                                linesGeoJSON: [] // You may need to fetch and filter linesGeoJSON similarly
    //                            )
    //                        }
    //
    //            DispatchQueue.main.async {
    //                self.testIndiv = joinedData
    //                completion()
    //            }
    //        } catch {
    //            print("Error while fetching supabase : \(error.localizedDescription)")
    //        }
    //    }
}
