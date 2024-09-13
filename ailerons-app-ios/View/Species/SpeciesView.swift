//
//  SpeciesView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import SwiftUI

struct SpeciesView: View {
    @EnvironmentObject var speciesViewModel: SpeciesViewModel

    var body: some View {
        NavigationStack {
            ListView(individuals: speciesViewModel.individuals, listType: .all)
        }
    }
}


#Preview {
    SpeciesView()
}
