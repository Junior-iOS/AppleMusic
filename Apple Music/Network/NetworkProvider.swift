//
//  NetworkProvider.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 08/02/23.
//

import Foundation

protocol NetworkProviderProtocol: AnyObject {
    func fetchData(_ request: Request, completion: @escaping (Result<Band.Response, NetworkError>) -> Void)
}

final class NetworkProvider: NetworkProviderProtocol {
    private init() {}
    static let shared = NetworkProvider()
    
    func fetchData(_ request: Request, completion: @escaping (Result<Band.Response, NetworkError>) -> Void) {
        guard let url = request.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        loadUrlAndDecode(url, completion: completion)
    }
    
    private func loadUrlAndDecode<T: Decodable>(_ url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.serializationError))
            }
        }.resume()
    }
}
