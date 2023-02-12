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
    let artworkUrl: String?
    let trackPrice: Double?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case trackId
        case trackName
        case artistViewUrl
        case previewUrl
        case artworkUrl = "artworkUrl100"
        case trackPrice
        case releaseDate
    }
}

/*
{
  "wrapperType": "track",
  "kind": "song",
  "artistId": 349736311,
  "collectionId": 349736310,
  "trackId": 349736334,
  "artistName": "twenty one pilots",
  "collectionName": "twenty one pilots",
  "trackName": "Addict With a Pen",
  "collectionCensoredName": "twenty one pilots",
  "trackCensoredName": "Addict With a Pen",
  "artistViewUrl": "https://music.apple.com/us/artist/twenty-one-pilots/349736311?uo=4",
  "collectionViewUrl": "https://music.apple.com/us/album/addict-with-a-pen/349736310?i=349736334&uo=4",
  "trackViewUrl": "https://music.apple.com/us/album/addict-with-a-pen/349736310?i=349736334&uo=4",
  "previewUrl": "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/73/47/20/73472058-be8f-602f-9a0f-84a0b5f889c2/mzaf_3360519390589570005.plus.aac.p.m4a",
  "artworkUrl30": "https://is4-ssl.mzstatic.com/image/thumb/Music115/v4/d2/47/c9/d247c9b5-aafd-a476-a739-741f847d75f8/mzi.phbndqax.jpg/30x30bb.jpg",
  "artworkUrl60": "https://is4-ssl.mzstatic.com/image/thumb/Music115/v4/d2/47/c9/d247c9b5-aafd-a476-a739-741f847d75f8/mzi.phbndqax.jpg/60x60bb.jpg",
  "artworkUrl100": "https://is4-ssl.mzstatic.com/image/thumb/Music115/v4/d2/47/c9/d247c9b5-aafd-a476-a739-741f847d75f8/mzi.phbndqax.jpg/100x100bb.jpg",
  "collectionPrice": 9.99,
  "trackPrice": 0.99,
  "releaseDate": "2009-12-29T08:00:00Z",
  "collectionExplicitness": "notExplicit",
  "trackExplicitness": "notExplicit",
  "discCount": 1,
  "discNumber": 1,
  "trackCount": 14,
  "trackNumber": 4,
  "trackTimeMillis": 286479,
  "country": "USA",
  "currency": "USD",
  "primaryGenreName": "Rock",
  "isStreamable": true
}

*/
