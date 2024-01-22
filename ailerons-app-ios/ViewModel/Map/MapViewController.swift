//
//  MapViewController.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 12/01/2024.
//

import Combine
import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate {

    let mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .mutedStandard
        return map
    }()
    
    private var diplayedOverlays = [MKPolygon]()
    
//    private var cancellables: Set<AnyCancellable> = []
//    private let movebankFetch = MovebankFetch()
     let vmSupaApi = SupabaseAPI()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup initial
        mapView.delegate = self
        setMapConstraints()
        
        // Lance la récupération des données
        // récupération lancé on Appear de l'app
//        movebankFetch.fetchData { [weak self] in
//            self?.makeMarker(data: self?.movebankFetch.individual ?? [])
//        }

        Task {
            await vmSupaApi.fetch { [weak self] in
                print("la closure s'est échapée!")
                self?.makeMarker(data: self?.vmSupaApi.testIndiv ?? [])
            }
        }
        
        // Abonnement aux changements des données
//        vmSupaApi.$testIndiv
//            .sink { [weak self] individuals in
//                self?.makeMarker(data: individuals)
//            }
//            .store(in: &cancellables)
        
        mapView.addOverlays(diplayedOverlays)
    }
    

    private func setMapConstraints() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }
    
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

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        // Custom des annoations
        if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(circle: circle)
            renderer.strokeColor = .blue
            renderer.fillColor = UIColor.blue.withAlphaComponent(0.2)
            renderer.lineWidth = 5.0
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

    // Creation des annotations et lignes
    func makeMarker(data: [SupaIndiv]) {
        print("Data : \(data.count)")
        
            DispatchQueue.global().async { [weak self] in
                
                // Réinitialisez les overlays pour éviter les doublons
                self?.diplayedOverlays.removeAll()
                
                var locationFormatted = [LocationFormatted]()
                
                // Boucle for each
                for  individual in data {
                    
                    // utilisation de map pour créer un tableau locationFormatted
                    locationFormatted = (individual.pointsGeoJSON?.first!.geojson.features.map { Location in
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
                    
                }
                DispatchQueue.main.async {
                    self?.mapView.addOverlays(self?.diplayedOverlays ?? [])
                    self?.mapView.addAnnotations(locationFormatted)
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
            self.diplayedOverlays.append(newRouteOverlay)
            
            DispatchQueue.main.async { [weak self] in
                
                let customEdgePadding: UIEdgeInsets = UIEdgeInsets(
                    top: 50,
                    left: 50,
                    bottom: 50,
                    right: 50
                )
                
                    self?.mapView.setVisibleMapRect(newRouteOverlay.boundingMapRect, edgePadding: customEdgePadding, animated: true)
        }
    }
}
