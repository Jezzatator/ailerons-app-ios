//
//  MapViewController.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 12/01/2024.
//

import MapKit
import UIKit
import SwiftUI
import Combine

class MapViewController: UIViewController, MKMapViewDelegate {
    private let mapView: MKMapView
    private var viewModel: SpeciesViewModel
    private var cancellables = Set<AnyCancellable>()

    init(mapView: MKMapView, viewModel: SpeciesViewModel) {
        self.mapView = mapView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.mapView.delegate = self // Assurez-vous que le délégué est configuré
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configuration de MKMapView
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Observer les changements dans les individus
        viewModel.$individuals
            .sink { [weak self] individuals in
                print("Individuals updated in MapViewController: \(individuals)")
                if !individuals.isEmpty {
                    self?.updateMapWithGeoJSON()
                }
            }
            .store(in: &cancellables)
        
        // Déclenchement de la récupération des données
        Task {
            await viewModel.fetchFullDataIndividuals()
        }
    }

    private func updateMapWithGeoJSON() {
        print("Updating map with GeoJSON data...")
        let annotations = viewModel.extractGeoJSONFeatures()
        print("Annotations count before adding: \(annotations.count)")
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
        
        // Ajouter les lignes reliant les annotations avec différentes couleurs
        addPolylines(to: mapView, from: viewModel.individuals)
        
        if !annotations.isEmpty {
            var region = MKCoordinateRegion()
            let coordinates = annotations.map { $0.coordinate }
            let latitudes = coordinates.map { $0.latitude }
            let longitudes = coordinates.map { $0.longitude }

            let minLat = latitudes.min() ?? 0
            let maxLat = latitudes.max() ?? 0
            let minLon = longitudes.min() ?? 0
            let maxLon = longitudes.max() ?? 0

            region.center.latitude = (minLat + maxLat) / 2
            region.center.longitude = (minLon + maxLon) / 2
            region.span.latitudeDelta = maxLat - minLat
            region.span.longitudeDelta = maxLon - minLon

            mapView.setRegion(region, animated: true)
        }
    }

    private func addPolylines(to mapView: MKMapView, from individuals: SupaIndiv) {
        for individual in individuals {
            let coordinates = individual.featureCollection?.features.compactMap { feature -> CLLocationCoordinate2D? in
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
            
            guard let coordinates = coordinates else {return}
            
            if coordinates.count > 1 {
                let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
                mapView.addOverlay(polyline)
                print("Added polyline with coordinates: \(coordinates)")
            } else {
                print("Not enough coordinates to create a polyline for individual: \(individual)")
            }
        }
    }


    // Définir le rendu pour les polylines avec couleurs différentes
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.randomColor() // Utiliser une couleur aléatoire ou spécifique
            renderer.lineWidth = 3.0 // Épaisseur de la ligne
            return renderer
        }
        return MKOverlayRenderer()
    }
}

import UIKit

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}
