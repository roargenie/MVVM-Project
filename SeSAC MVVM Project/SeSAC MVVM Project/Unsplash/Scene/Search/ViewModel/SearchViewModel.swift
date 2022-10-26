//
//  UnsplashViewModel.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/20.
//

import Foundation
import RxCocoa
import RxSwift


final class SearchViewModel {
    
//    var photoList: CObservable<SearchPhoto> = CObservable(SearchPhoto(total: 0, totalPages: 0, results: []))
    var photoList = PublishSubject<SearchPhoto>()
    
    func requestPhoto(query: String) {
        APIManager.shared.requestSearchPhoto(query: query) { [weak self] photo, statusCode, error in
            
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
//            self.photoList.value = photo
            self?.photoList.onNext(photo)
        }
    }
    
}
