//
//  MapBtn.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/01/2024.
//

import SwiftUI

// A faire rendre les bouton bien carré
struct MapBtn: View {
    
    //var function?: Any
    var systemIcon: String
    
    var body: some View {
        Button {
            //function
        } label: {
            Image(systemName: systemIcon)
                .padding(10)
                .frame(maxWidth: 50)
                .background(
                    .regularMaterial,
                    in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                )
            
        }
        .padding(.trailing, 10)
        .clipShape(Rectangle(), style: FillStyle())
    }
}
