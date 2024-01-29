//
//  DetailMapViewController.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 24/01/2024.
//

import Foundation
import MapKit

class DetailMapViewController: UIViewController, AileronsMap, MKMapViewDelegate {
    
    var displayedOverlays: [MKPolygon]
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .mutedStandard
        map.delegate = self
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private let vmSupaApi: SupbaseAPIClientProtocol
    
    init(diplayedOverlays: [MKPolygon] = [MKPolygon](), vmSupaApi: SupbaseAPIClientProtocol = SupabaseAPIClient()) {
        self.displayedOverlays = diplayedOverlays
        self.vmSupaApi = vmSupaApi
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
    
    func loadMapData() {
        
        //Refacto pour 1 check si testIndiv != empty 2/ testIndiv contien l'indiv de la fiche detaillé 3/ fetch l'info ou outilisé la donnée
//        Task {
//            await vmSupaApi.fetch{ [weak self] in
//            print("Detailled Map")
//                self?.makeMarker(data: self!.vmSupaApi.testIndiv)
//            }
//        }
    }
    
    func setupMap() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
    }
    
    public func setMapType(type: MKMapType) {
        mapView.mapType = type
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

    // Creation des annotations et lignes
    func makeMarker(data: [SupaIndiv]) {
        print("Data : \(data.count)")
        
            DispatchQueue.global().async { [weak self] in
                
                // Réinitialisez les overlays pour éviter les doublons
                self?.displayedOverlays.removeAll()
                
                
                // Boucle for each
                for  individual in data {
                    
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
