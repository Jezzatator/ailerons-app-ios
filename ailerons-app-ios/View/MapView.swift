//
// ModernMapView.swift
// ailerons-app-ios
//
// Created by Jérémie Patot on 21/09/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var viewModel: SpeciesViewModel
    @State private var isPresented = false
    @State private var mapStyle: MapStyle = .standard(elevation: .automatic, emphasis: .muted)
    @State private var position: MapCameraPosition = .automatic
    
    var body: some View {
        NavigationStack {
            Map(position: $position,
                selection: .constant(nil as MapFeature?)) {
                
                // Correction: utilisation sans binding ($) et accès direct à la computed property
                ForEach(viewModel.annotationsForMap, id: \.id) { annotation in
                    Annotation(
                        annotation.title,  // String direct, pas de binding
                        coordinate: annotation.coordinate,  // CLLocationCoordinate2D direct
                        anchor: .bottom
                    ) {
                        Image(systemName: "fish")
                            .foregroundColor(.blue)
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 30, height: 30)
                            )
                            .scaleEffect(1.2)
                    }
                }
                
                // Correction: utilisation de la computed property
                ForEach(viewModel.polylinesForMap, id: \.id) { polyline in
                    MapPolyline(coordinates: polyline.coordinates)
                        .stroke(.red, lineWidth: 3)
                }
                
                UserAnnotation()
            }
                .mapStyle(mapStyle)
                .navigationTitle("Carte")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // Bouton Réglages
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            isPresented.toggle()
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                    
                    // Menu des styles de carte
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Button("Standard Atténué") {
                                mapStyle = .standard(elevation: .automatic, emphasis: .muted)
                            }
                            Button("Standard") {
                                mapStyle = .standard(elevation: .automatic)
                            }
                            Button("Hybride") {
                                mapStyle = .hybrid(elevation: .automatic)
                            }
                            Button("Imagerie") {
                                mapStyle = .imagery(elevation: .automatic)
                            }
                        } label: {
                            Label("Styles de carte", systemImage: "square.3.layers.3d")
                                .labelStyle(.iconOnly)
                        }
                        .menuStyle(.button)
                    }
                    
                }
                .sheet(isPresented: $isPresented) {
                    PreferencesView()
                        .presentationBackground(.ultraThinMaterial)
                }
        }
    }
}

// MARK: - Previews
@available(iOS 26.0, *)
#Preview("Carte avec accessory iOS 26") {
    @Previewable @StateObject var mockViewModel = MockSpeciesViewModel.withSampleData()
    
    // Ici on applique tabViewBottomAccessory sur le TabView lui-même
    TabView {
        MapView()
            .environmentObject(mockViewModel)
            .tabItem { Label("Carte", systemImage: "map") }
    }
}
