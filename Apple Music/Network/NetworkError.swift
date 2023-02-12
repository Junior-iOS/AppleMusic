//
//  NetworkError.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 08/02/23.
//

import Foundation

enum NetworkError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError:
            return "Failed to fetch data"
        case .invalidEndpoint:
            return "Invalid Endpoint"
        case .invalidResponse:
            return "Invalid Response"
        case .noData:
            return "No Data"
        case .serializationError:
            return "Failed to Decode data"
        }
    }
}
