//
//  UsersPhotoCollectionViewCell.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/27.
//

import UIKit



final class UsersPhotoCollectionViewCell: BaseCollectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let widthLabel: UILabel = {
        let view = UILabel()
        view.textColor = LabelColor.usersPhotoLabelColor
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.textAlignment = .left
        return view
    }()
    
    let heightLabel: UILabel = {
        let view = UILabel()
        view.textColor = LabelColor.usersPhotoLabelColor
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.textAlignment = .left
        return view
    }()
    
    let likesLabel: UILabel = {
        let view = UILabel()
        view.textColor = LabelColor.usersPhotoLabelColor
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.textAlignment = .left
        return view
    }()
    
    lazy var descriptionLabelStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [widthLabel, heightLabel, likesLabel])
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [imageView, descriptionLabelStackView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        descriptionLabelStackView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(self.safeAreaLayoutGuide).inset(12)
//            make.height.equalTo(imageView.snp.height).multipliedBy(0.3)
            
        }
    }
    
}


