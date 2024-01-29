//
//  ProtocolAileronsMap.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 23/01/2024.
//

import Foundation
import MapKit

protocol AileronsMap {
            
    var displayedOverlays: [MKPolygon] { get set }
    
    func loadMapData()
    func setupMap()
    func makeMarker(data: [SupaIndiv])
    func drawRoute(routeData: [LocationFormatted])
    func setMapType(type: MKMapType)
}
