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

// MARK: - SearchResult

struct SearchResult: Codable, Hashable {
    let id: String
    let user: User
    let urls: Urls

    enum CodingKeys: String, CodingKey {
        case id
        case urls
        case user
    }
}

// MARK: - UsersPhoto

struct UsersPhoto: Codable, Hashable {
    let id: String
    let width, height: Int
    let urls: Urls
    let likes: Int

    enum CodingKeys: String, CodingKey {
        case id
        case width, height
        case urls, likes
    }
}

// MARK: - Urls

struct Urls: Codable, Hashable {
    
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

// MARK: - User

struct User: Codable, Hashable {
    let id: String
    let username, name: String
    let profileImage: ProfileImage
    let totalCollections, totalLikes, totalPhotos: Int

    enum CodingKeys: String, CodingKey {
        case id
        case username, name
        case profileImage = "profile_image"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable, Hashable {
    let small, medium, large: String
}
