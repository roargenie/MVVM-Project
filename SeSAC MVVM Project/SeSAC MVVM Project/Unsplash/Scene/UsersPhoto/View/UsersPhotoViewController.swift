//
//  UsersPhotoViewController.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/27.
//

import UIKit
import RxSwift
import RxCocoa


final class UsersPhotoViewController: BaseViewController {
    
    
    // MARK: - Properties
    
    private let mainView = UsersPhotoView()
    let viewModel = UsersPhotoViewModel()
    var userName = ""
    private let disposeBag = DisposeBag()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, UsersPhoto>!
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        bindData()
    }
    
    // MARK: - OverrideFunction
    
    
    // MARK: - CustomFunction
    
    private func bindData() {
        
        viewModel.usersPhotoList
            .withUnretained(self)
            .bind { (vc, photo) in
                var snapshot = NSDiffableDataSourceSnapshot<Int, UsersPhoto>()
                snapshot.appendSections([0])
                snapshot.appendItems(photo)
                vc.dataSource.apply(snapshot, animatingDifferences: true)
                vc.mainView.usernameLabel.text = "\(vc.userName)'s Photo"
            }
            .disposed(by: disposeBag)
        
        mainView.cancelButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.requestUsersPhoto(username: userName)
    }
    
}

// MARK: - Extension

extension UsersPhotoViewController {
    
    private func configureDataSource() {
        let cellregistration = UICollectionView.CellRegistration<UsersPhotoCollectionViewCell, UsersPhoto> { cell, indexPath, itemIdentifier in
            
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.regular)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data!)
                    cell.widthLabel.text = " width : \(itemIdentifier.width) "
                    cell.heightLabel.text = " height : \(itemIdentifier.height) "
                    cell.likesLabel.text = " like : \(itemIdentifier.likes) "
                }
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellregistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
}
