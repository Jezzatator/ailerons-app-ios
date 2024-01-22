//
//  IndividualsFormatted.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 12/01/2024.
//

import MapKit
import Foundation

class IndividualFormatted: NSObject {
    var individualTaxonCanonicalName: String?
    let locations: [LocationFormatted]
    
    init(individualTaxonCanonicalName: String? = nil, locations: [LocationFormatted]) {
        self.individualTaxonCanonicalName = individualTaxonCanonicalName
        self.locations = locations
    }

}

class LocationFormatted: NSObject, MKAnnotation {
    let individualID: Int
    let timestamp: Int
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    
    init(individualID: Int, timestamp: Int, coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.individualID = individualID
        self.timestamp = timestamp
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
