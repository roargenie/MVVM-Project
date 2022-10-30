//
//  UsersPhotoView.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/27.
//

import UIKit


final class UsersPhotoView: BaseView {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setLayout())
//        view.keyboardDismissMode = .onDragWithAccessory
//        view.backgroundColor = .black
        return view
    }()
    
    let cancelButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.tintColor = .black
        return view
    }()
    
    let usernameLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 25, weight: .heavy)
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [collectionView, cancelButton, usernameLabel]
            .forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
//            make.centerX.equalTo(self.snp.centerX)
//            make.centerY.equalTo(self.snp.centerY).multipliedBy(0.8)
            make.center.equalTo(self.snp.center)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(self.safeAreaLayoutGuide).inset(4)
            make.width.height.equalTo(50)
        }
        usernameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(collectionView.snp.top).offset(-40)
            make.height.equalTo(32)
        }
//        descriptionLabelStackView.snp.makeConstraints { make in
//            make.top.equalTo(collectionView.snp.bottom).offset(12)
//            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
//            make.centerX.equalTo(self.snp.centerX)
//            make.width.equalTo(self.snp.width).multipliedBy(0.7)
//        }
    }
    
    private func setLayout() -> UICollectionViewCompositionalLayout {
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (section, layoutEnvironment) -> NSCollectionLayoutSection in
            
//            let spacing = CGFloat(4)
            //            let fraction: CGFloat = 1.0 / 3.0
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                                   heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
//            group.interItemSpacing = .fixed(spacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 0
            section.orthogonalScrollingBehavior = .groupPagingCentered
            //            section.contentInsets = NSDirectionalEdgeInsets(top: 0,
            //                                                            leading: 0,
            //                                                            bottom: 0,
            //                                                            trailing: 0)
            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 0.9
                    let maxScale: CGFloat = 1.0
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
            return section
        }, configuration: config)
        
        return layout
        
    }
        
//        { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
//
//            let spacing = CGFloat(4)
////            let fraction: CGFloat = 1.0 / 3.0
//
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                  heightDimension: .fractionalHeight(1.0))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
//                                                   heightDimension: .fractionalHeight(1.0))
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
//                                                           subitems: [item])
//
//            group.interItemSpacing = .fixed(spacing)
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.interGroupSpacing = 0
//            section.orthogonalScrollingBehavior = .groupPagingCentered
////            section.contentInsets = NSDirectionalEdgeInsets(top: 0,
////                                                            leading: 0,
////                                                            bottom: 0,
////                                                            trailing: 0)
//            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
//                items.forEach { item in
//                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
//                    let minScale: CGFloat = 0.9
//                    let maxScale: CGFloat = 1.0
//                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
//                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
//                }
//            }
//
//            return section
//        }
//
//        return layout
//    }
}

