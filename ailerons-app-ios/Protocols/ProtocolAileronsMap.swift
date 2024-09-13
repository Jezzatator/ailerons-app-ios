//
//  ProtocolAileronsMap.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 23/01/2024.
//

import Foundation
import MapKit

protocol AileronsMap {
    var displayedOverlays: [MKOverlay] { get set }
    var displayedAnnotations: [MKAnnotation] { get set }

    // Configuration initiale de la carte
    func setupMap()

    // Gestion des annotations
    func addAnnotations(_ annotations: [MKAnnotation])
    func removeAnnotations(_ annotations: [MKAnnotation])

    // Gestion des routes ou polygones
    func addOverlays(_ overlays: [MKOverlay])
    func removeOverlays(_ overlays: [MKOverlay])

    // Ajuste le type de carte
    func setMapType(_ type: MKMapType)
    
    // Ajuste la région visible sur la carte
    func setRegion(_ region: MKCoordinateRegion, animated: Bool)
}
