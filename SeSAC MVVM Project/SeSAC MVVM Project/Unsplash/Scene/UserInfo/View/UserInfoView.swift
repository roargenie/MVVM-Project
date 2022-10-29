//
//  UserInfoView.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/27.
//

import UIKit

final class UserInfoView: BaseView {
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .systemPink
        return view
    }()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        return view
    }()
    
    let totalPhotoLabel: UILabel = {
        let view = UILabel()
        view.textColor = LabelColor.totalPhotoLabelColor
        view.textAlignment = .center
        return view
    }()
    
    let totalLikeLabel: UILabel = {
        let view = UILabel()
        view.textColor = LabelColor.totalLikeLabelColor
        view.textAlignment = .center
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.layer.borderColor = LineViewColor.lineViewColor.cgColor
        view.layer.borderWidth = 5
        return view
    }()
    
    let showMoreButton: UIButton = {
        let view = UIButton()
        view.setTitle("Show More Photos", for: .normal)
//        view.tintColor = .black
        view.layer.cornerRadius = 10
        view.backgroundColor = .black
        view.setTitleColor(.white, for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [profileImageView,
         nameLabel,
         totalPhotoLabel,
         totalLikeLabel,
         lineView,
         showMoreButton]
            .forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.centerX.equalTo(self.snp.centerX)
            make.width.height.equalTo(self.snp.width).multipliedBy(0.4)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(4)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(4)
            make.height.equalTo(40)
        }
        lineView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.width.equalTo(2)
            make.height.equalTo(50)
        }
        totalPhotoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX).multipliedBy(0.5)
            make.centerY.equalTo(lineView.snp.centerY)
            make.height.equalTo(40)
        }
        totalLikeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX).multipliedBy(1.5)
            make.centerY.equalTo(lineView.snp.centerY)
            make.height.equalTo(40)
        }
        showMoreButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(lineView.snp.bottom).offset(25)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(self.snp.height).multipliedBy(0.18)
        }
    }
    
    func setImage(_ photoURLstr: String?) {
        guard let safeString = photoURLstr else { return }
        DispatchQueue.global().async {
            let url = URL(string: safeString)!
            let data = try? Data(contentsOf: url)
            
            DispatchQueue.main.async {
                self.profileImageView.image = UIImage(data: data!)
                self.profileImageView.makeToCircle()
            }
        }
    }
    
    func setupData(_ userData: User) {
        setImage(userData.profileImage.large)
        nameLabel.text = userData.name
        totalPhotoLabel.text = "Total Photos : \(userData.totalPhotos.numberFormatter())"
        totalLikeLabel.text = "Total Like : \(userData.totalLikes.numberFormatter())"
    }
}
