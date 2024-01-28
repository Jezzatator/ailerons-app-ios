//
//  SpeciesView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import SwiftUI

struct SpeciesView: View {
    @StateObject var supabaseVM = SupabaseAPI()
    
    @State var indivs: [SupaIndiv] = []

    var body: some View {
        NavigationStack {
            
            ListView(indivs: indivs, listType: .all)

//            List {
//                            
//                // Liste des individus
//                ForEach(supabaseVM.testIndiv, id: \.id) { indiv in
//                    
//                    NavigationLink {
//                        SpecieDetailView(individual: indiv)
//                    } label: {
//                        SpicieRow(binomialName: indiv.binomialName, commonName: indiv.commonName, individualName: indiv.individualName)
//                    }
//                }
//            }
//            .navigationTitle("Espèces")
        }
        
        .onAppear() {
            // Verifie si les données DL et appel le fetch si besoin
            Task {
                if supabaseVM.testIndiv.isEmpty {
                    await supabaseVM.fetch {
                        self.indivs = supabaseVM.testIndiv
                        print("Number of items fetched: \(supabaseVM.testIndiv.count)")
                    }
                }
            }
        }
    }
}

#Preview {
    SpeciesView()
}
