//
//  MapBtn.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/01/2024.
//

import SwiftUI

struct MapButton: View {
    let systemIcon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemIcon)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.primary)
                .frame(width: 44, height: 44)
                .background(.thinMaterial, in: Circle())
                .overlay(
                    Circle()
                        .stroke(.quaternary, lineWidth: 0.5)
                )
        }
        .buttonStyle(.plain)
    }
}

#if DEBUG
// MARK: - Previews
#Preview("Boutons carte") {
    VStack(spacing: 20) {
        MapButton(systemIcon: "gear") {
            print("Settings tapped")
        }
        
        MapButton(systemIcon: "fish") {
            print("Fish tapped")
        }
        
        MapButton(systemIcon: "clock.arrow.circlepath") {
            print("Clock tapped")
        }
        
        MapButton(systemIcon: "square.3.layers.3d") {
            print("Layers tapped")
        }
    }
    .padding()
    .background(.ultraThinMaterial)
}

#Preview("Bouton sombre") {
    MapButton(systemIcon: "location.fill") {
        print("Location tapped")
    }
    .padding()
    .background(.black)
    .preferredColorScheme(.dark)
}

#endif
