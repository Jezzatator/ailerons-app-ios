//
//  MapViewWrapper.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/01/2024.
//

import SwiftUI

struct MapViewWrapper: View {
    
    var body: some View {
        ZStack{
            MapViewControllerWrapper()
                .edgesIgnoringSafeArea(.top)
            HStack() {
                Spacer()
                VStack{
                    MapBtn(systemIcon: "square.3.layers.3d")
                    MapBtn(systemIcon: "clock.arrow.circlepath")
                    MapBtn(systemIcon: "fish")
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MapViewWrapper()
}
