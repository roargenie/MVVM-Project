//
//  UsersPhotoViewModel.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/27.
//

import Foundation
import RxSwift
import RxCocoa


final class UsersPhotoViewModel {
    
    var usersPhotoList = PublishSubject<[UsersPhoto]>()
    
    func requestUsersPhoto(username: String) {
        APIManager.shared.requestUsersPhoto(username: username) { [weak self] photo, statusCode, error in
            
            guard let statusCode = statusCode, statusCode >= 200 && statusCode < 400 else {
                print("============server")
//                self?.photoList.onError(SearchError.serverError)
                return
            }
            
            guard let photo = photo else {
                print("=============photo")
//                self?.photoList.onError(SearchError.noPhoto)
                return
            }
            
            self?.usersPhotoList.onNext(photo)
        }
    }
    
}

