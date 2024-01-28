//
//  MapViewController.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 12/01/2024.
//

import MapKit
import UIKit
import SwiftUI

class MapViewController: UIViewController {

    private let mapViewController: AileronsMap
        
    // Initialisateur de MapViewController avec AileronsMap
        init(mapViewController: AileronsMap) {
            self.mapViewController = mapViewController
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()

        // Ajout d'AileronsMapViewController en tant que contrôleur de vue enfant
        if let aileronsViewController = mapViewController as? UIViewController {
                addChild(aileronsViewController)
                view.addSubview(aileronsViewController.view)
                aileronsViewController.didMove(toParent: self)

            // Définition des contraintes pour remplir la vue parent
                NSLayoutConstraint.activate([
                    aileronsViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
                    aileronsViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    aileronsViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    aileronsViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            }
        }
    
    func updateMapStyle(mapStyle: MKMapType) {
        // Mettre à jour le style de la carte dans AileronsMapViewController
        mapViewController.setMapType(type: mapStyle)
    }
    
    }
