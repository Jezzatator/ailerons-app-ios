//
//  ViewController.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/12/2023.
//


import UIKit

class ViewController: UIViewController {
    
    private lazy var formContentBuilder = FormContentBuilderImpl()
    private lazy var formCompLayout = FormCompositionalLayout()
    private lazy var dataSource = makeDataSource()
    
    private lazy var collectionVw: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: formCompLayout.layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.cellId)
        cv.register(FormButtonCollectionViewCell.self, forCellWithReuseIdentifier: FormButtonCollectionViewCell.cellId)
        cv.register(FormTextCollectionViewCell.self, forCellWithReuseIdentifier: FormTextCollectionViewCell.cellId)
        cv.register(FormDateCollectionViewCell.self, forCellWithReuseIdentifier: FormDateCollectionViewCell.cellId)
        return cv
    }()
    
    override func viewDidLoad() {
        super.loadView()
        setup()
        updateDataSource()
    }
    
}


private extension ViewController {
    
    func setup() {

        view.backgroundColor = .white
        
        collectionVw.dataSource = dataSource
        
        // Layout
        
        view.addSubview(collectionVw)
        
        NSLayoutConstraint.activate([
            collectionVw.topAnchor.constraint(equalTo: view.topAnchor),
            collectionVw.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionVw.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionVw.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<FormSectionComponent, FormComponent> {
        
        return UICollectionViewDiffableDataSource(collectionView: collectionVw) { collectionVw, indexPath, item in
            
            switch item {
            case is TextFormComponent:
                let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: FormTextCollectionViewCell.cellId, for: indexPath) as! FormTextCollectionViewCell
                cell.bind(item)
                return cell
            case is DateFormComponent:
                let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: FormDateCollectionViewCell.cellId, for: indexPath) as! FormDateCollectionViewCell
                cell.bind(item)
                return cell
            case is ButtonFormComponent:
                let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: FormButtonCollectionViewCell.cellId, for: indexPath) as! FormButtonCollectionViewCell
                cell.bind(item)
                return cell
            default:
                let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.cellId, for: indexPath)
                return cell
            }
            
        }
        
    }
    
    func updateDataSource(animated: Bool = false) {
        
        DispatchQueue.main.async { [weak self] in
        
            guard let self = self else { return }
            
            var snapshot = NSDiffableDataSourceSnapshot<FormSectionComponent, FormComponent>()
            
            let formSections = self.formContentBuilder.content
            snapshot.appendSections(formSections)
            formSections.forEach { snapshot.appendItems($0.items, toSection: $0) }
            
            self.dataSource.apply(snapshot, animatingDifferences: animated)
        }
    }
    
    
}
