//
//  UnsplashView.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/20.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setLayout())
        view.keyboardDismissMode = .onDragWithAccessory
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [searchBar, collectionView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    private func setLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            
            let spacing = CGFloat(4)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(0.5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
            group.interItemSpacing = .fixed(spacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: spacing,
                                                            leading: spacing,
                                                            bottom: spacing,
                                                            trailing: spacing)
            return section
        }
            
        return layout
    }
}
