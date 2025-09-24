//
// MockSpeciesViewModel.swift
// ailerons-app-ios
//
// Created by Jérémie Patot on 21/09/2025.
//

import Foundation
import MapKit
import SwiftUI

#if DEBUG

@available(iOS 17.0, *)
@MainActor
final class MockSpeciesViewModel: ObservableObject {
    @Published var individuals: [SupaIndivElement] = []
    @Published var annotations: [MKPointAnnotation] = []
    @Published var polylines: [CustomPolyline] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    static func withSampleData() -> MockSpeciesViewModel {
        let viewModel = MockSpeciesViewModel()
        
        // Annotations de test
        let toulouseAnnotation = MKPointAnnotation()
        toulouseAnnotation.coordinate = CLLocationCoordinate2D(latitude: 43.6045, longitude: 1.4440)
        toulouseAnnotation.title = "Raie Manta #001"
        toulouseAnnotation.subtitle = "Manta birostris"
        
        let montpellierAnnotation = MKPointAnnotation()
        montpellierAnnotation.coordinate = CLLocationCoordinate2D(latitude: 43.6108, longitude: 3.8767)
        montpellierAnnotation.title = "Requin #007"
        montpellierAnnotation.subtitle = "Carcharodon carcharias"
        
        viewModel.annotations = [toulouseAnnotation, montpellierAnnotation]
        
        // Polylines de test avec wrapper personnalisé
        let coordinates1 = [
            CLLocationCoordinate2D(latitude: 43.6045, longitude: 1.4440),
            CLLocationCoordinate2D(latitude: 43.6108, longitude: 1.4297),
            CLLocationCoordinate2D(latitude: 43.5983, longitude: 1.4437)
        ]
        
        let coordinates2 = [
            CLLocationCoordinate2D(latitude: 43.6108, longitude: 3.8767),
            CLLocationCoordinate2D(latitude: 43.6000, longitude: 3.8800),
            CLLocationCoordinate2D(latitude: 43.5950, longitude: 3.8650)
        ]
        
        viewModel.polylines = [
            CustomPolyline(coordinates: coordinates1),
            CustomPolyline(coordinates: coordinates2)
        ]
        
        return viewModel
    }
    
    static func empty() -> MockSpeciesViewModel {
        return MockSpeciesViewModel()
    }
    
    func fetchFullDataIndividuals() async {
        // Mock implementation pour les tests
        isLoading = true
        
        // Simulation d'un délai réseau
        try? await Task.sleep(for: .seconds(1))
        
        await MainActor.run {
            isLoading = false
        }
    }
}

// Extension pour les wrappers Map (identique à SpeciesViewModel)
extension MockSpeciesViewModel {
    var annotationsForMap: [MapAnnotation] {
        return annotations.map { annotation in
            MapAnnotation(from: annotation)
        }
    }
    
    var polylinesForMap: [IdentifiableMapPolyline] {
        return polylines.map { polyline in
            IdentifiableMapPolyline(coordinates: polyline.coordinates) 
        }
    }
}

// Structure wrapper pour stocker les coordonnées de polyline
struct CustomPolyline: Identifiable, Hashable {
    let id = UUID()
    let coordinates: [CLLocationCoordinate2D]
    
    init(coordinates: [CLLocationCoordinate2D]) {
        self.coordinates = coordinates
    }
    
    // Conformité Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CustomPolyline, rhs: CustomPolyline) -> Bool {
        lhs.id == rhs.id
    }
}

#endif
