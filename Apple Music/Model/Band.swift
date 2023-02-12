//
//  Band.swift
//  Apple Music
//
//  Created by Junior Silva on 12/02/23.
//

import Foundation

enum Band {
    struct Response: Codable {
        let count: Int?
        let tracks: [Track]?
        
        enum CodingKeys: String, CodingKey {
            case count = "resultCount"
            case tracks = "results"
        }
    }
}

struct Track: Codable {
    let trackId: Int?
    let trackName: String?
    let artistViewUrl: String?
    let previewUrl: String?
    let collectionViewUrl: String?
    let artworkUrl: String?
    let trackPrice: Double?
    let releaseDate: String?
    let currency: String?
    
    enum CodingKeys: String, CodingKey {
        case trackId
        case trackName
        case artistViewUrl
        case collectionViewUrl
        case previewUrl
        case artworkUrl = "artworkUrl100"
        case trackPrice
        case releaseDate
        case currency
    }
}
