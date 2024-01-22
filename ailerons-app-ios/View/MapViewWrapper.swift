//
//  MapViewWrapper.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/01/2024.
//

import SwiftUI

struct MapViewWrapper: View {
    
    @State private var isPresented = false
    @State private var presentPopupFish = false
    @State private var presentPopupClock = false

    @State private var mapStyle = "Standard atténué"
    
    var body: some View {
        ZStack{
            MapViewControllerWrapper()
                .edgesIgnoringSafeArea(.all)
            HStack() {
                VStack{
                    MapBtn(systemIcon: "gear") {
                        isPresented.toggle()
                    }
                        .padding(.leading, 7)
                        .padding(.top, 3)
                    Spacer()
                }
                Spacer()
                VStack{
                    Menu {
                                        Button("Standard atténué") {  }
                                        Button("Standard") {  }
                                        Button("Satellite") {  }
                                        Button("Hybrid") {  }
                                            .presentationCompactAdaptation(.popover)
                                            .scrollContentBackground(.hidden)
                                            .presentationBackground(.thinMaterial)
                                    } label: {
                                        MapBtn(systemIcon: "square.3.layers.3d") { }
                                    }
                        
                    
                    MapBtn(systemIcon: "clock.arrow.circlepath"){ self.presentPopupClock = true }
                        .popover(isPresented: $presentPopupClock) {
                            PopoverView(popoverType: .clock)
                                .frame(width: 300, height: 100)
                                .presentationCompactAdaptation(.popover)
                                .scrollContentBackground(.hidden)
                                .presentationBackground(.thinMaterial)
                            }

                    
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
        .sheet(isPresented: $isPresented) {
            PreferencesView()
                .presentationBackground(.ultraThinMaterial)
        }
    }
}

#Preview {
    MapViewWrapper()
}
