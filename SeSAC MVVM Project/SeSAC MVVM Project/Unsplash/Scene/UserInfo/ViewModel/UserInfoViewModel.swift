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
    
    var userData = BehaviorSubject(value: User(id: "", username: "", name: "", profileImage: ProfileImage(small: "", medium: "", large: ""), totalCollections: 0, totalLikes: 0, totalPhotos: 0))
    
    var user: User?
    
    func bindData(_ item: User) {
        userData.onNext(item)
    }
}
