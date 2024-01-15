//
//  FormTextCollectionViewCell.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/12/2023.
//

import UIKit

final class FormTextCollectionViewCell: UICollectionViewCell {
    
    private lazy var txtField: UITextField = {
       
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.layer.cornerRadius = 8
        txtField.layer.borderWidth = 1
        txtField.layer.borderColor = UIColor.systemGray5.cgColor
        return txtField
    }()
    
    func bind(_ item: FormComponent) {
        
        guard let item = item as? TextFormComponent else { return }
        setup(item: item)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
    }
    
}

private extension FormTextCollectionViewCell {
    
    func setup(item: TextFormComponent) {
        
        txtField.placeholder = " \(item.placeholder)"
        txtField.keyboardType = item.keyboardType
        
        // Layout
        
        contentView.addSubview(txtField)
        
        NSLayoutConstraint.activate([
            txtField.heightAnchor.constraint(equalToConstant: 44),
            txtField.topAnchor.constraint(equalTo: contentView.topAnchor),
            txtField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            txtField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            txtField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
