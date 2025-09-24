//
// SpeciesViewModel.swift
// ailerons-app-ios
//
// Created by Jérémie - Ada on 29/01/2024.
//

import Foundation
import Combine
import MapKit
import SwiftUI

@MainActor
final class SpeciesViewModel: ObservableObject, @unchecked Sendable {
    @Published var individuals: [SupaIndivElement] = []
    @Published var annotations: [MKPointAnnotation] = []
    @Published var polylines: [CustomPolyline] = []  // ← Même changement ici
    @Published var isLoading = false
    @Published var error: Error?
    
    private let dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func fetchFullDataIndividuals() async {
        isLoading = true
        error = nil
        
        do {
            let fetchedIndividuals = try await dataService.fetchIndividuals()
            await updateUI(with: fetchedIndividuals)
        } catch {
            await handleError(error)
        }
        
        isLoading = false
    }
    
    private func updateUI(with individuals: [SupaIndivElement]) async {
        self.individuals = individuals
        self.annotations = extractGeoJSONFeatures(from: individuals)
        // Vous pouvez ajouter la logique pour créer des polylines ici si nécessaire
    }
    
    private func handleError(_ error: Error) async {
        self.error = error
        print("Error fetching individuals: \(error)")
    }
    
    public func extractGeoJSONFeatures(from individuals: [SupaIndivElement]) -> [MKPointAnnotation] {
        var annotations: [MKPointAnnotation] = []
        print("extractGeoJSONFeatures called")
        print("Individuals count: \(individuals.count)")
        
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

// Extension pour les wrappers Map
extension SpeciesViewModel {
    // Convertit les MKPointAnnotation en MapAnnotation pour ForEach
    var annotationsForMap: [MapAnnotation] {
        return annotations.map { annotation in
            MapAnnotation(from: annotation)
        }
    }
    
    // Convertit les polylines pour ForEach avec Identifiable
    var polylinesForMap: [IdentifiableMapPolyline] {
        return polylines.map { polyline in
            IdentifiableMapPolyline(coordinates: polyline.coordinates)
        }
    }
}
