//
//  FLCRPhotos.swift
//  PhotoGallery
//
//  Created by Pradipta Ghosh on 06/08/21.
//

import UIKit

struct FLCRPhotos: Decodable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    var items: [FLCRPhoto]
    
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case description
        case modified
        case generator
        case items
      }
}

extension FLCRPhotos {
    
    mutating func sortUsingDateTaken() {
        items = items.sorted(by: {
            $0.dateTaken.compare($1.dateTaken) == .orderedDescending
        })
    }
    
    mutating func sortUsingDatePublished() {
        items = items.sorted(by: {
            $0.published.compare($1.published) == .orderedDescending
        })
    }
    
}

struct FLCRPhoto: Decodable {
    let title: String
    let link: String
    let media: FLCRMedia
    let dateTaken: Date
    let description: String
    let published: Date
    let author: String
    let authorID: String
    let tags: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case dateTaken = "date_taken"
        case description
        case published
        case author
        case authorID = "author_id"
        case tags
      }
}

struct FLCRMedia: Decodable {
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case link = "m"
    }
}
