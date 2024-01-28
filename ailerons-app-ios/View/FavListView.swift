//
//  FavListView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 26/01/2024.
//

import SwiftUI

struct FavListView: View {
    @StateObject var supabaseVM = SupabaseAPI()
    
    @State var indivs: [SupaIndiv] = []
    
    var body: some View {
        NavigationStack {
            
            ListView(indivs: indivs, listType: .fav)
        }
        .onAppear() {
            // Verifie si les données DL et appel le fetch si besoin
            Task {
                if supabaseVM.testIndiv.isEmpty {
                    await supabaseVM.fetch {
                        self.indivs = [supabaseVM.testIndiv.randomElement()!]
                        print("Number of items fetched: \(supabaseVM.testIndiv.count)")
                    }
                }
            }
        }
    }
}

//#Preview {
//    FavListView()
//}
