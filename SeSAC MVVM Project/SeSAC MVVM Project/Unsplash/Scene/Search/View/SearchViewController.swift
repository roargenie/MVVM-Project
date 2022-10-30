//
//  UnsplashViewController.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/20.
//

import UIKit
import RxSwift
import RxCocoa


final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = SearchView()
    private let viewModel = SearchViewModel()
    
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
        
        mainView.searchBar.rx.text
            .orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .subscribe { (vc, value) in
                vc.viewModel.requestPhoto(query: value)
            } 
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx.itemSelected
            .withUnretained(self)
            .bind { (vc, item) in
                vc.presentUserInfoVC(item)
            }
            .disposed(by: disposeBag)
    }
    
    private func presentUserInfoVC(_ indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let vc = UserInfoViewController()
        vc.viewModel.bindData(item.user)
        transition(vc, transitionStyle: .present)
    }
}

// MARK: - Extension

extension SearchViewController {
    
    private func configureDataSource() {
        let cellregistration = UICollectionView.CellRegistration<SearchCollectionViewCell, SearchResult> { cell, indexPath, itemIdentifier in
            
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.regular)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data!)
                }
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellregistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}

