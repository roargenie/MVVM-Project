//
//  UnsplashViewController.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/20.
//

import UIKit


final class UnsplashViewController: BaseViewController {
    
    
    private let mainView = UnsplashView()
    private let viewModel = UnsplashViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        bindPhotoList()
    }
    
    override func configureUI() {
        mainView.searchBar.delegate = self
    }
    
    func bindPhotoList() {
        viewModel.photoList.bind { photo in
            var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
            snapshot.appendSections([0])
            snapshot.appendItems(photo.results)
            self.dataSource.apply(snapshot)
        }
    }
    
}

extension UnsplashViewController {
    
    private func configureDataSource() {
        let cellresistration = UICollectionView.CellRegistration<UnsplashCollectionViewCell, SearchResult> { cell, indexPath, itemIdentifier in
            
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.regular)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data!)
                }
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellresistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}

extension UnsplashViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel.requestPhoto(query: text)
    }
    
}
