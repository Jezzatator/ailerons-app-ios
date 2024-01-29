//
//  MapViewControllerRepresentable.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 12/01/2024.
//

import SwiftUI
import UIKit
import MapKit

struct MapViewControllerRepresentable: UIViewControllerRepresentable {
    // 1. Conform to the UIViewRepresentable protocol
    typealias UIViewControllerType = MapViewController
    
    var mapStyle: Binding<MKMapType>
    
    // MapViewControllerRepresentable crée et met à jour MapViewController
    var mapViewController: MapViewController {
        let aileronsMapViewController = AileronsMapViewController()
        return MapViewController(mapViewController: aileronsMapViewController)
    }
    
    // 2. Implement the required method to create the initial UIView
    func makeUIViewController(context: Context) -> MapViewController {
        mapViewController.updateMapStyle(mapStyle: mapStyle.wrappedValue)
        return mapViewController
    }
    
    // 3. Implement the required method to update the UIView
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        DispatchQueue.main.async {
            mapViewController.updateMapStyle(mapStyle: mapStyle.wrappedValue)
        }
    }
}
