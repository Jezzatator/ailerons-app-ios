//
//  UICollectionViewCell+CleanUp.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/12/2023.
//

import UIKit

extension UICollectionViewCell {
    
    func removeViews() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
}
