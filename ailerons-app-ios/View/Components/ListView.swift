//
//  ListView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 26/01/2024.
//

import SwiftUI

struct ListView: View {
    
    var indivs: [SupaIndiv]
    var listType: ListType
    
    var body: some View {
        List {
            
            // Liste des individus
            ForEach(indivs, id: \.id) { indiv in
                
                NavigationLink {
                    SpecieDetailView(individual: indiv)
                } label: {
                    SpicieRow(binomialName: indiv.binomialName, commonName: indiv.commonName, individualName: indiv.individualName)
                }
            }
        }
        .navigationTitle( listType == .all ? "Espèces" : "Espèces suivies")
    }
}

enum ListType {
    case all
    case fav
}

#Preview {
    ListView(indivs: [], listType: .all)
}
