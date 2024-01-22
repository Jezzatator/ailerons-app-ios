//
//  PopoverView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 22/01/2024.
//

import SwiftUI

enum PopoverType {
    case clock
    case fish
}

struct PopoverView: View {
    let popoverType: PopoverType
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150, maximum: 200))
    ]
    
    @State private var time = 50.0
    @State private var isEditing = false
    
    var body: some View {
        
        switch popoverType {
        case .clock:
            VStack {
            Slider(
                    value: $time,
                    in: 0...100,
                    step: 5
                ) {
                    Text("Temps")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("100")
                } onEditingChanged: { editing in
                    isEditing = editing
                }
                Text("\(time)")
                    .foregroundColor(isEditing ? .red : .blue)
            }
            .frame(width: 280, height: 100)

        case .fish:
            Text("Hello, Fish!")
            LazyVGrid(columns: columns) {
                ForEach(0..<10, id: \.self) { i in
                    Button(action: {
                        print("I am being tapped: \(i)")
                    }) {
                        Text("\(i)")
                    }
                }
            }
            .frame(width: 300, height: 400)
        }
    }
}

#Preview {
    PopoverView(popoverType: .clock)
}
