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
    func reloadTable()
    func didClearView()
    func didSelectSongFrom(_ url: URL)
    func didPlaySongWith(_ url: URL)
    func didSelectArtistFrom(_ artistView: String)
}

final class AppleMusicViewModel: NSObject {
    
    private let service: NetworkProviderProtocol
    public weak var delegate: AppleMusicViewModelDelegate?
    private var bandResponse: Band.Response?
    private var tracks: [Track]? {
        didSet {
            delegate?.reloadTable()
        }
    }
    
    init(service: NetworkProviderProtocol = NetworkProvider.shared) {
        self.service = service
    }
    
    public func fetchBand(_ band: String) {
        service.fetchData(.searchList(for: band)) { [weak self] results in
            guard let self = self else { return }
            
            switch results {
            case .success(let response):
                self.bandResponse = response
                self.tracks = self.bandResponse?.tracks ?? []

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
        guard let collectionViewUrl = response?[indexPath.row].collectionViewUrl,
              let url = URL(string: collectionViewUrl)
        else { return }
        
        DispatchQueue.main.async {
            self.delegate?.didSelectSongFrom(url)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(of: AppleMusicTableViewCell.self, for: indexPath) { [weak self] cell in
            guard let self = self, let tracks = self.tracks else { return }
            cell.configure(track: tracks[indexPath.row])
            cell.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "??? Music") { [weak self] _, _, _ in
            guard let self = self else { return }
            
            if let artistView = self.tracks?[indexPath.row].artistViewUrl {
                DispatchQueue.main.async {
                    self.delegate?.didSelectArtistFrom(artistView)
                }
            }
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [action])
        return swipeAction
    }
}

extension AppleMusicViewModel: AppleMusicTableViewCellDelegate {
    func didPlaySong(with url: URL) {
        delegate?.didPlaySongWith(url)
    }
}
