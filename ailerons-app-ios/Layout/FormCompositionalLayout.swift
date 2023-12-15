//
//  FormCompositionalLayout.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/12/2023.
//

import UIKit

final class FormCompositionalLayout {
    
    var layout: UICollectionViewCompositionalLayout {
        
        // Setting up our item
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(44))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil,
                                                               top: .fixed(16),
                                                               trailing: nil,
                                                               bottom: .fixed(16))
        
        // Setting up our group
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .estimated(44))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                  subitem: layoutItem,
                                                  count: 1)
        
        layoutGroup.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        // Setting up our section
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = .init(top: 150, leading: 0, bottom: 0, trailing: 0)
        
        let compLayout = UICollectionViewCompositionalLayout(section: layoutSection)
        
        return compLayout
        
    }
}
