//
//  UnsplashViewModel.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/20.
//

import Foundation



final class UnsplashViewModel {
    
    var photoList: CObservable<SearchPhoto> = CObservable(SearchPhoto(total: 0, totalPages: 0, results: []))
    
    func requestPhoto(query: String) {
        APIManager.shared.requestSearchPhoto(query: query) { photo, statusCode, error in
            guard let photo = photo else { return }
            self.photoList.value = photo
        }
    }
    
}
