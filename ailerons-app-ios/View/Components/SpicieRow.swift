//
//  SpicieRow.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import SwiftUI

struct SpicieRow: View {
    var binomialName: String
    var commonName: String
    var individualName: String
    
    var body: some View {
        HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(individualName)
                        .font(.title3)
                    
                    HStack {
                        Text(binomialName)
                            .font(.subheadline)
                            .tint(.gray.opacity(0.5))
                        
                        Spacer()
                        
                        Text(commonName)
                            .font(.subheadline)
                            .tint(.gray.opacity(0.5))
                    }
                }
        }
    }
}

#Preview {
    SpicieRow(binomialName: "NTM", commonName: "Requin", individualName: "Lol")
}
