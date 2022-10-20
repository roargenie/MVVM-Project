//
//  UnsplashViewController.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/20.
//

import UIKit


final class UnsplashViewController: BaseViewController {
    
    
    private let mainView = UnsplashView()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        
    }
    
}

extension UnsplashViewController {
    
    private func configureDataSource() {
        let cellresistration = UICollectionView.CellRegistration<UnsplashCollectionViewCell, String> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = .systemPink
            cell.layer.borderColor = UIColor.green.cgColor
            cell.layer.borderWidth = 2
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellresistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(["1", "2", "3", "4", "5", "6", "7"])
        dataSource.apply(snapshot)
    }
}
