//
//  APIManager.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/20.
//

import Foundation
import Alamofire


final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    typealias searchPhotoCompletionHandler = (SearchPhoto?, Int?, Error?) -> Void
    typealias usersPhotoCompletionHandler = ([UsersPhoto]?, Int?, Error?) -> Void
    
    func requestSearchPhoto(query: String, completion: @escaping searchPhotoCompletionHandler) {
        
        let url = "\(APIKey.searchURL)\(query)"
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: SearchPhoto.self) { response in
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let value):
                completion(value, statusCode, nil)
            case .failure(let error):
                completion(nil, statusCode, error)
            }
        }
    }
    
    func requestUsersPhoto(username: String, completion: @escaping usersPhotoCompletionHandler) {
        
        let url = "\(APIKey.usersPhotoURL)\(username)/photos"
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
//        let parameter: Parameters = ["username": username]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: [UsersPhoto].self) { response in
            
            let statusCode = response.response?.statusCode
            print(url)
            print(response.result)
            switch response.result {
            case .success(let value):
                completion(value, statusCode, nil)
            case .failure(let error):
                completion(nil, statusCode, error)
            }
        }
    }
    
}
