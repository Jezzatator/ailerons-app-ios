//
//  SpeciesViewModel.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 29/01/2024.
//

import Foundation
import Combine
import MapKit

class SpeciesViewModel: ObservableObject {
    @Published var individuals: SupaIndiv = []
    let supabaseAPIClient = SupabaseAPIService()
    private var cancellables = Set<AnyCancellable>()

    func fetchFullDataIndividuals() async {
        do {
            try await fetchIndividuals()
            print("Individuals fetched: \(self.individuals)")
            await MainActor.run {
                // Utilisez updateMapWithGeoJSON uniquement si nécessaire
                // self.updateMapWithGeoJSON() // Cette ligne est à supprimer si non utilisée
            }
        } catch {
            print("Error fetching individuals: \(error)")
        }
    }
    
    func fetchIndividuals() async throws {
        let individualRequest = IndividualRequest()
        let routerType = SupabaseAPIRouter.individual
        
        try await supabaseAPIClient.fetch(individualRequest, router: routerType) { [weak self] result in
            switch result {
            case .success(let fetchedIndividuals):
                print("Fetched individuals: \(fetchedIndividuals)")
                self?.individuals = fetchedIndividuals
            case .failure(let error):
                print("Erreur lors de la récupération des individus : \(error)")
            }
        }
    }
    
    func extractGeoJSONFeatures() -> [MKPointAnnotation] {
        var annotations: [MKPointAnnotation] = []
        print("extractGeoJSONFeatures called")
        print("Individuals count: \(individuals.count)") // Vérifier le nombre d'individus
        
        if individuals.isEmpty {
            print("Individuals is empty")
            return annotations
        }
        
        for individual in individuals {
            print("Processing individual: \(individual)")
            
            if let features = individual.featureCollection?.features {
                
                for feature in features {
                    print("Processing feature: \(feature)")
                    
                    guard feature.geometry.coordinates.count == 2 else {
                        print("Invalid coordinates count for feature: \(feature)")
                        continue
                    }
                    
                    let lat = feature.geometry.coordinates[1]
                    let lon = feature.geometry.coordinates[0]
                    
                    if lat.isFinite && lon.isFinite {
                        print("Creating annotation with lat: \(lat), lon: \(lon)")
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        annotation.title = individual.commonName
                        annotations.append(annotation)
                        
                        print("Annotation created: \(annotation)")
                    } else {
                        print("Invalid latitude or longitude for feature: \(feature)")
                    }
                }
            } else {
                print("No features in individual.featureCollection?.features")
            }
        }
        
        print("Annotations created: \(annotations)")
        return annotations
    }
}
