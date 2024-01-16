//
//  MapViewControllerWrapper.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 12/01/2024.
//

import SwiftUI
import UIKit

struct MapViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = MapViewController

    func makeUIViewController(context: Context) -> MapViewController {
        return MapViewController()
    }

    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        // Update the view controller if needed
    }
}
