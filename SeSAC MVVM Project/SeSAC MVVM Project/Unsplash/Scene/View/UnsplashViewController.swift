//
//  UnsplashViewController.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/20.
//

import UIKit
import RxSwift
import RxCocoa


final class UnsplashViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = UnsplashView()
    private let viewModel = UnsplashViewModel()
    
    private var disposeBag = DisposeBag()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        bindPhotoList()
    }
    
    // MARK: - OverrideFunction
    
    override func configureUI() {
//        mainView.searchBar.delegate = self
    }
    
    // MARK: - CustomFunction
    
    private func bindPhotoList() {
        
        viewModel.photoList
            .withUnretained(self)
            .bind(onNext: { (vc, photo) in
                var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
                snapshot.appendSections([0])
                snapshot.appendItems(photo.results)
                vc.dataSource.apply(snapshot, animatingDifferences: true)
            })
            .disposed(by: disposeBag)
        
        mainView.searchBar
            .rx
            .text
            .orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .subscribe { (vc, value) in
                vc.viewModel.requestPhoto(query: value)
            } onError: { error in
                print("error: \(error)")
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)

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

//extension UnsplashViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let text = searchBar.text else { return }
//        viewModel.requestPhoto(query: text)
//    }
//
//}
