//
//  CaptionText.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 06/09/2024.
//

import SwiftUI

struct CaptionText: View {
    var text: String
    var isItalic: Bool = false
    
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .medium))
            .kerning(0.24)
            .italic(isItalic)
    }
}

#Preview {
    CaptionText(text: /*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/, isItalic: true)
}
