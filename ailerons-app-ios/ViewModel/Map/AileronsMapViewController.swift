//
//  AileronsMapViewController.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 23/01/2024.
//

import Foundation
import MapKit

class AileronsMapViewController: UIViewController, AileronsMap, MKMapViewDelegate {
    
    internal var displayedOverlays = [MKPolygon]()
    private let speciesViewModel: SpeciesViewModel //subBaceAPIClient
    // Eviter les abreviation
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .mutedStandard
        map.delegate = self
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    // Initialisateur d'AileronsMapViewController
    init(speciesViewModel: SpeciesViewModel = SpeciesViewModel()) {
        self.speciesViewModel = speciesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        loadMapData()
        mapView.addOverlays(displayedOverlays)
    }
    
    // Charge les données depuis la BD Supabase -> besoin de refecto pour verifieir si les données sont deja DL
    internal func loadMapData() {
        print("loadMapData")
        if speciesViewModel.individuals.isEmpty {
            Task {
                await speciesViewModel.fetchFullDataIndividualsPointsGeoJSON()
                self.makeMarker(data: speciesViewModel.individuals)
            }
        } else {
            self.makeMarker(data: speciesViewModel.individuals)
        }
    }
    
    internal func setupMap() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // Change le fond de carte
    func setMapType(type: MKMapType) {
        mapView.mapType = type
        
    }
    
    // Fonction pour créer les annotations
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let locationAnnotation = annotation as? LocationFormatted else { return nil }
        
        let identifier = "LocationFormatted"
        
        var annotationView: MKAnnotationView?
        
        // Creation des annotations
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = dequeuedView
            annotationView?.annotation = locationAnnotation
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView = MKAnnotationView(annotation: locationAnnotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        // Creation des formes en points des annoations
        if let circleView = annotationView {
            let circle = MKCircle(center: locationAnnotation.coordinate, radius: 50)
            mapView.addOverlay(circle)
        }
        
        return annotationView
    }
    
    // Fonction pour custom les annotations
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        // Custom des annoations
        if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(circle: circle)
            renderer.strokeColor = .blue
            renderer.fillColor = UIColor.blue.withAlphaComponent(0.2)
            renderer.lineWidth = 6.0
            return renderer
            
            // Custom des lignes
        } else if let polyline = overlay as? MKPolygon {
            let renderer = MKGradientPolylineRenderer(overlay: polyline)
            renderer.setColors([
                UIColor(red: (CGFloat(arc4random()) / CGFloat(UInt32.max)),
                        green: (CGFloat(arc4random()) / CGFloat(UInt32.max)),
                        blue: (CGFloat(arc4random()) / CGFloat(UInt32.max)),
                        alpha: 1.0)], locations: [])
            renderer.lineCap = .butt
            renderer.lineWidth = 2.0
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let locationAnnotation = view.annotation as? LocationFormatted else { return }
        let infivTime = String(locationAnnotation.timestamp)
    }
    
    
    /// Creation des annotations et lignes selon les données de la DB
    /// - Parameter data: tableau des données
    func makeMarker(data: [SupaIndiv]) {
        print("Data : \(data.count)")
        
        DispatchQueue.global().async { [weak self] in
            
            // Réinitialisez les overlays pour éviter les doublons
            self?.displayedOverlays.removeAll()
            
            
            // Boucle for each
            for  individual in data {
                print("makeMarker")
                // utilisation de map pour créer un tableau locationFormatted
                let locationFormatted = (individual.pointsGeoJSON?.first!.geojson.features.map { Location in
                    let timeStamp = Location.properties.timestamp.toInt()
                    return LocationFormatted(individualID: individual.id, timestamp: timeStamp,
                                             coordinate:
                                                CLLocationCoordinate2D(
                                                    latitude: Location.geometry.coordinates.last!,
                                                    longitude: Location.geometry.coordinates.first!),
                                             title:  individual.individualName,
                                             subtitle: ("\(individual.commonName) - \(timeStamp)")
                    )
                    
                })!
                print(locationFormatted.count)
                self?.drawRoute(routeData: locationFormatted )
                
                DispatchQueue.main.async {
                    self?.mapView.addAnnotations(locationFormatted)
                    self?.mapView.addOverlays(self?.displayedOverlays ?? [])
                    self?.setVisibleMap(overlays: self?.displayedOverlays ?? [])
                }
            }
            
            
        }
    }
    
    
    func drawRoute(routeData: [LocationFormatted]) {
        
        if routeData.isEmpty {
            print("routeData is empty, no coordinates to draw")
            return
        }
        
        let coordinates = routeData.map { location -> CLLocationCoordinate2D in
            return location.coordinate
        }
        
        let newRouteOverlay = MKPolygon(coordinates: coordinates, count: coordinates.count)
        self.displayedOverlays.append(newRouteOverlay)
    }
    
    private func setVisibleMap(overlays: [MKPolygon]) {
        let mapRect = overlays.reduce(MKMapRect.null) { $0.union($1.boundingMapRect) }
        let edgePadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        mapView.setVisibleMapRect(mapRect, edgePadding: edgePadding, animated: true)
        
        
    }
}