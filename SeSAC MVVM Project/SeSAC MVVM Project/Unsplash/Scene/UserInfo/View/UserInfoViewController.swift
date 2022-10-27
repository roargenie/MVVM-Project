//
//  UserInfoViewController.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/27.
//

import UIKit
import RxCocoa
import RxSwift


final class UserInfoViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mainView = UserInfoView()
    private let viewModel = UserInfoViewModel()
    
    private var disposeBag = DisposeBag()
    
    var userData: User?
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUserData()
    }
    
    // MARK: - OverrideFunction
    
    override func configureUI() {
        guard let safeData = userData else { return }
        DispatchQueue.global().async {
            let url = URL(string: safeData.profileImage.large)!
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.mainView.profileImageView.image = UIImage(data: data!)
                self.mainView.profileImageView.makeToCircle()
            }
        }
        mainView.nameLabel.text = safeData.username
        mainView.totalPhotoLabel.text = "Total Photos : \(safeData.totalPhotos.numberFormatter())"
        mainView.totalLikeLabel.text = "Total Like : \(safeData.totalLikes.numberFormatter())"
    }
    
    
    // MARK: - CustomFunction
    
    private func bindUserData() {
        
    }
    
}


// MARK: - Extension

