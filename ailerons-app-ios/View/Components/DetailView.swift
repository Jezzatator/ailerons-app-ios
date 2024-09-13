//
//  DetailView.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 23/08/2024.
//

import SwiftUI

enum DetailType {
    case sex
    case wingspan
    case groupSituation
}

struct DetailView: View {
    let detailType: DetailType
    let text: String
    let imageName: String
    let rotationDegrees: Double?
    
    public init(detailType: DetailType, text: String, imageName: String, rotationDegrees: Double? = nil) {
        self.detailType = detailType
        self.text = text
        self.imageName = imageName
        self.rotationDegrees = rotationDegrees
    }

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(title)
                .fontWeight(.thin)
            
            HStack(spacing: 0) {
                
                if detailType == .sex {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                } else {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .rotationEffect(.degrees(rotationDegrees ?? 0))
                }
                
                Text(text)
                    .fontWeight(.regular)
            }
        }
    }

    private var title: String {
        switch detailType {
        case .sex:
            return "Sexe"
        case .wingspan:
            return "Envergure*"
        case .groupSituation:
            return "Situation de groupe*"
        }
    }
}
