//
//  MapAnnotation.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 21/09/2025.
//

import Foundation
import MapKit
import SwiftUI

// Wrapper pour rendre MKPointAnnotation compatible avec ForEach
struct MapAnnotation: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(from annotation: MKPointAnnotation) {
        self.title = annotation.title ?? "Point"
        self.subtitle = annotation.subtitle
        self.coordinate = annotation.coordinate
    }
    
    init(title: String, subtitle: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
    // Conformité Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MapAnnotation, rhs: MapAnnotation) -> Bool {
        lhs.id == rhs.id
    }
}

// Wrapper pour MapPolyline avec Identifiable
struct IdentifiableMapPolyline: Identifiable, Hashable {
    let id = UUID()
    let coordinates: [CLLocationCoordinate2D]
    
    init(coordinates: [CLLocationCoordinate2D]) {
        self.coordinates = coordinates
    }
    
    // Conformité Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: IdentifiableMapPolyline, rhs: IdentifiableMapPolyline) -> Bool {
        lhs.id == rhs.id
    }
}
