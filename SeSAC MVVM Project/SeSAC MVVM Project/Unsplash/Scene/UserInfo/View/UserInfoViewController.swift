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
    
    let viewModel = UserInfoViewModel()
    
    private var disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUserData()
    }
    
    // MARK: - OverrideFunction
    
    
    // MARK: - CustomFunction
    
    private func bindUserData() {
        print(#function)
        
        viewModel.userData
            .withUnretained(self)
            .bind { (vc, item) in
                vc.mainView.setupData(item)
            }
            .disposed(by: disposeBag)
    }
}
