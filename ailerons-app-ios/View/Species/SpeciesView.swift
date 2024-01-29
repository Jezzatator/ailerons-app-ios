//
//  SpeciesView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import SwiftUI

struct SpeciesView: View {
    @StateObject var speciesViewModel = SpeciesViewModel()
    @State var individuals: [SupaIndiv] = []
    
    var body: some View {
        NavigationStack {
            ListView(individuals: individuals, listType: .all)
        }
        
        .onAppear() {
            // Verifie si les données DL et appel le fetch si besoin
            Task {
                await speciesViewModel.fetchFullDataIndividualsPointsGeoJSON()
                individuals = speciesViewModel.individuals
            }
        }
    }
}

#Preview {
    SpeciesView()
}
