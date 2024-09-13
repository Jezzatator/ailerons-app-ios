//
//  MapViewControllerRepresentable.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 12/01/2024.
//

import SwiftUI
import MapKit
import Combine

struct MapViewControllerRepresentable: UIViewRepresentable {
    @ObservedObject var viewModel: SpeciesViewModel
    private var cancellables = Set<AnyCancellable>()
    
    public init(viewModel: SpeciesViewModel, cancellables: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.viewModel = viewModel
        self.cancellables = cancellables
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
        
        let annotations = viewModel.extractGeoJSONFeatures()
        uiView.addAnnotations(annotations)
        
        addPolylines(to: uiView, from: viewModel.individuals)
        
        if !annotations.isEmpty {
            adjustMapRegion(for: annotations, in: uiView)
        }
    }

    private func addPolylines(to mapView: MKMapView, from individuals: SupaIndiv) {
        for individual in individuals {
            
            guard let featureCollection = individual.featureCollection else {return}
            
            let coordinates = featureCollection.features.compactMap { feature -> CLLocationCoordinate2D? in
                guard feature.geometry.coordinates.count == 2 else {
                    print("Invalid coordinates count for feature: \(feature)")
                    return nil
                }
                let lat = feature.geometry.coordinates[1]
                let lon = feature.geometry.coordinates[0]
                if lat.isFinite && lon.isFinite {
                    return CLLocationCoordinate2D(latitude: lat, longitude: lon)
                } else {
                    print("Invalid latitude or longitude for feature: \(feature)")
                    return nil
                }
            }
            
            if coordinates.count > 1 {
                let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
                mapView.addOverlay(polyline)
                print("Added polyline with coordinates: \(coordinates)")
            } else {
                print("Not enough coordinates to create a polyline for individual: \(individual)")
            }
        }
    }

    private func adjustMapRegion(for annotations: [MKPointAnnotation], in mapView: MKMapView) {
        let coordinates = annotations.map { $0.coordinate }
        let latitudes = coordinates.map { $0.latitude }
        let longitudes = coordinates.map { $0.longitude }
        
        let minLat = latitudes.min() ?? 0
        let maxLat = latitudes.max() ?? 0
        let minLon = longitudes.min() ?? 0
        let maxLon = longitudes.max() ?? 0
        
        var region = MKCoordinateRegion()
        region.center.latitude = (minLat + maxLat) / 2
        region.center.longitude = (minLon + maxLon) / 2
        region.span.latitudeDelta = maxLat - minLat
        region.span.longitudeDelta = maxLon - minLon
        
        mapView.setRegion(region, animated: true)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewControllerRepresentable

        init(parent: MapViewControllerRepresentable) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = UIColor.randomColor() // Utiliser une couleur aléatoire ou spécifique
                renderer.lineWidth = 3.0
                return renderer
            }
            return MKOverlayRenderer()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}
