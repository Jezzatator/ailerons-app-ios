//
//  MapViewWrapper.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/01/2024.
//

import SwiftUI
import MapKit

struct MapViewWrapper: View {
    
    // State pour la présentation de differents popovers et menus
    @State private var isPresented: Bool = false
    @State private var presentPopupFish: Bool = false
    @State private var presentPopupClock: Bool = false
    
    // State pour le choix de fond de carte
    @State var mapStyle: MKMapType
    
    // Initialisateur de MapViewWrapper
    init(isPresented: Bool = false, presentPopupFish: Bool = false, presentPopupClock: Bool = false, mapStyle: MKMapType? = nil) {
        self._isPresented = State(initialValue: isPresented)
        self._presentPopupFish = State(initialValue: presentPopupFish)
        self._presentPopupClock = State(initialValue: presentPopupClock)
        self._mapStyle = State(initialValue: mapStyle ?? .mutedStandard)
    }
    
    var body: some View {
        
        ZStack{
            // Carte générale
            MapViewControllerRepresentable(mapStyle: $mapStyle)
                .ignoresSafeArea()
            
            // Stacke des réglages et boutons
            HStack() {
                
                VStack{
                    
                    // Bouton régalges
                    MapBtn(systemIcon: "gear") {
                        isPresented.toggle()
                    }
                        .padding(.leading, 7)
                        .padding(.top, 3)
                    Spacer()
                }
                Spacer()
                VStack{
                    
                    // Menu choix fond de carte
                    Menu {
                        Button("Standard atténué") { mapStyle = .mutedStandard }
                        Button("Standard") { mapStyle = .standard }
                        Button("Satellite") { mapStyle = .satellite }
                        Button("Hybrid") { mapStyle = .hybrid }
                                            .presentationCompactAdaptation(.popover)
                                            .scrollContentBackground(.hidden)
                                            .presentationBackground(.thinMaterial)
                                    } label: {
                                        MapBtn(systemIcon: "square.3.layers.3d") { }
                                    }
                        
                    
                    // Bouton reglages du cadre des timestamps a afficher
                    MapBtn(systemIcon: "clock.arrow.circlepath"){ self.presentPopupClock = true }
                        .popover(isPresented: $presentPopupClock) {
                            PopoverView(popoverType: .clock)
                                .frame(width: 300, height: 100)
                                .presentationCompactAdaptation(.popover)
                                .scrollContentBackground(.hidden)
                                .presentationBackground(.thinMaterial)
                            }

                    
                    // Bouton choix des animaux a afficher
                    MapBtn(systemIcon: "fish"){ self.presentPopupFish = true }
                        .popover(isPresented: $presentPopupFish) {
                            PopoverView(popoverType: .fish)
                                .presentationCompactAdaptation(.popover)
                                .scrollContentBackground(.hidden)
                                .presentationBackground(.thinMaterial)
                            }

                    
                    Spacer()
                }
                .padding(.top, 55)
            }
        }
        
        // Appel du sheet de préferences/reglages généraux
        .sheet(isPresented: $isPresented) {
            PreferencesView()
                .presentationBackground(.ultraThinMaterial)
        }
    }
}
