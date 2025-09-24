//
//  ListView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 26/01/2024.
//

import SwiftUI

struct ListView: View {
    
    var individuals: [SupaIndivElement]
    var listType: ListType
    
    var body: some View {
        List {
            
            // Liste des individus
            ForEach(individuals, id: \.id) { indiv in
                
                NavigationLink {
                    SpecieDetailView(individual: indiv)
                } label: {
                    SpicieRow(name: indiv.individualName, sex: indiv.sex)
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
    ListView(individuals: [], listType: .all)
}
