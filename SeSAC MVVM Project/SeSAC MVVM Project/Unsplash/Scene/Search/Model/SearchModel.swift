//
//  UnsplashModel.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/20.
//

import Foundation

// MARK: - SearchPhoto
struct SearchPhoto: Codable, Hashable {
    let total, totalPages: Int
    let results: [SearchResult]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct SearchResult: Codable, Hashable {
    let id: String
    let urls: Urls

    enum CodingKeys: String, CodingKey {
        case id
        case urls
    }
}

struct Urls: Codable, Hashable {
    
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
