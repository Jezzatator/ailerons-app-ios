//
//  FormButtonCollectionViewCell.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/12/2023.
//

import UIKit

class FormButtonCollectionViewCell: UICollectionViewCell {
    
    private lazy var actionBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return btn
    }()
    
    func bind(_ item: FormComponent) {
        
        guard let item = item as? ButtonFormComponent else { return }
        setup(item: item)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
    }
    
}

private extension FormButtonCollectionViewCell {
    func setup(item: ButtonFormComponent) {
        
        actionBtn.setTitle(item.title, for: .normal)
        
        contentView.addSubview(actionBtn)
        
        NSLayoutConstraint.activate([
            actionBtn.heightAnchor.constraint(equalToConstant: 44),
            actionBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actionBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            actionBtn.topAnchor.constraint(equalTo: contentView.topAnchor),
            actionBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
}
