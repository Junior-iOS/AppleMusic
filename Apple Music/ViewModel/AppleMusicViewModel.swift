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
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bandResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let response = bandResponse?.tracks?.compactMap({ return $0 })
        
        guard let tracks = response else { return UITableViewCell() }
        
        DispatchQueue.main.async {
            cell.textLabel?.text = tracks[indexPath.row].trackName
            cell.detailTextLabel?.text = "\(String(describing: tracks[indexPath.row].trackId))"
        }
        return cell
    }
}
