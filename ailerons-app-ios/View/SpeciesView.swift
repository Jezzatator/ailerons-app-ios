//
//  SpeciesView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import SwiftUI

struct SpeciesView: View {
    @StateObject var supabaseVM = SupabaseAPI()
    
    var body: some View {
            
                List {
                    ForEach(supabaseVM.testIndiv, id: \.self) { indiv in
                        
                        HStack {
                            Text(indiv.binomial_name)
                            Spacer()
                            Text(indiv.common_name)
                        }
                    }
                }
                .onAppear() {
                    Task {
                        await supabaseVM.fetch()
                        print("Number of items fetched: \(supabaseVM.testIndiv.count)")
                    }
                }
            }
    }

#Preview {
    SpeciesView()
}
