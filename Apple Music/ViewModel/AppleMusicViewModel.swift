//
//  AppleMusicViewModel.swift
//  Apple Music
//
//  Created by Junior Silva on 12/02/23.
//

import Foundation
import UIKit

protocol AppleMusicViewModelDelegate: AnyObject {
    func didLoadList()
//    func didNotLoadList(_ error: NetworkError)
    func didClearView()
}

final class AppleMusicViewModel: NSObject {
    
    private let service: NetworkProviderProtocol
    public weak var delegate: AppleMusicViewModelDelegate?
    public var bandResponse: Band.Response?
    
    
    init(service: NetworkProviderProtocol = NetworkProvider.shared) {
        self.service = service
    }
    
    public func fetchBand(_ band: String) {
        service.fetchData(.searchList(for: band)) { [weak self] results in
            guard let self = self else { return }
            
            switch results {
            case .success(let response):
                self.bandResponse = response
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadList()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func clearView() {
        DispatchQueue.main.async {
            self.delegate?.didClearView()
        }
    }
}

extension AppleMusicViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let response = self.bandResponse?.tracks?.compactMap({ return $0 })
        guard let artistViewUrl = response?[indexPath.row].artistViewUrl else { return }
        
        if let url = URL(string: artistViewUrl) {
            UIApplication.shared.open(url)
        }
        
//        service.fetchData(.lookUpSong(for: trackId), completion: <#T##(Result<Band.Response, NetworkError>) -> Void#>)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bandResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(of: AppleMusicTableViewCell.self, for: indexPath) { [weak self] cell in
            guard let self = self else { return }
            
            let response = self.bandResponse?.tracks?.compactMap({ return $0 })
            guard let track = response?[indexPath.row] else { return }
            cell.configure(track: track)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
