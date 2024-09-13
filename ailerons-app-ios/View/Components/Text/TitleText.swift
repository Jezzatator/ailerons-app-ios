//
//  TitleText.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 06/09/2024.
//

import SwiftUI

struct TitleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(
                .system(size: 32, weight: .medium)
            )
    }
}

#Preview {
    TitleText(text: "Hello, World")
}
