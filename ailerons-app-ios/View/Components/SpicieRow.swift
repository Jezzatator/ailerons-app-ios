//
//  SpicieRow.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import SwiftUI

struct SpicieRow: View {
    var name: String
    var sex: String
    
    var body: some View {
        HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.title3)
                    
                    HStack {
                        Text(sex)
                            .font(.subheadline)
                            .tint(.gray.opacity(0.5))
                        
                        Spacer()
                        
                        Text("PIPOU")
                            .font(.subheadline)
                            .tint(.gray.opacity(0.5))
                    }
                }
        }
    }
}

#Preview {
    SpicieRow(name: "Requinou", sex: "non-binaire")
}
