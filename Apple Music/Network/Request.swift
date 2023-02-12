//
//  Endpoint.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 08/02/23.
//

import Foundation

enum Endpoint: String {
    case search
    case lookup
    
    func getValue() -> String {
        return self.rawValue
    }
}

struct Request {
    let path: String
    let queryItems: [URLQueryItem]
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Bundle.main.scheme
        urlComponents.host = Bundle.main.host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    static func searchList(with endpoint: Endpoint = .search, for band: String) -> Request {
        return Request(
            path: "/\(endpoint.getValue())",
            queryItems: [
                URLQueryItem(name: "term", value: band)
            ]
        )
    }
    
    static func lookUpSong(with endpoint: Endpoint = .lookup, for trackId: Int) -> Request {
        return Request(
            path: "/\(endpoint.getValue())",
            queryItems: [
                URLQueryItem(name: "id", value: "\(trackId)")
            ]
        )
    }
}
