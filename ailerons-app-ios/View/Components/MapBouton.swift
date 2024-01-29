//
//  MapBtn.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/01/2024.
//

import SwiftUI

struct MapBouton: View {
    
    var systemIcon: String
    var action: () -> Void

    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemIcon)
                .padding(10)
                .frame(maxWidth: 50)
                .background(
                    .thinMaterial,
                    in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                )
            
        }
        .padding(.trailing, 10)
        .clipShape(Rectangle(), style: FillStyle())
    }
}
