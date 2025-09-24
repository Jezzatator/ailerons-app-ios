//
//  AileronsMapViewController.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 23/01/2024.
//

import Foundation
import MapKit

class AileronsMapViewController: UIViewController, @preconcurrency AileronsMap {
    var displayedOverlays: [MKOverlay] = []
    var displayedAnnotations: [MKAnnotation] = []
    var mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        setupMap()
    }

    func setupMap() {
        mapView.frame = view.bounds
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    func addAnnotations(_ annotations: [MKAnnotation]) {
        mapView.addAnnotations(annotations)
        displayedAnnotations.append(contentsOf: annotations)
    }

    func removeAnnotations(_ annotations: [MKAnnotation]) {
        mapView.removeAnnotations(annotations)
        displayedAnnotations.removeAll { annotation in annotations.contains(where: { $0.isEqual(annotation) }) }
    }

    func addOverlays(_ overlays: [MKOverlay]) {
        mapView.addOverlays(overlays)
        displayedOverlays.append(contentsOf: overlays)
    }

    func removeOverlays(_ overlays: [MKOverlay]) {
        mapView.removeOverlays(overlays)
        displayedOverlays.removeAll { overlay in overlays.contains(where: { $0.isEqual(overlay) }) }
    }

    func setMapType(_ type: MKMapType) {
        mapView.mapType = type
    }

    func setRegion(_ region: MKCoordinateRegion, animated: Bool) {
        mapView.setRegion(region, animated: animated)
    }
}
