//
//  UserInfoViewModel.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/27.
//

import Foundation
import RxCocoa
import RxSwift


final class UserInfoViewModel {
    
    var userData = PublishRelay<User>()
    
}
