//
//  AppleMusicViewController.swift
//  Apple Music
//
//  Created by Junior Silva on 11/02/23.
//

import UIKit

class AppleMusicViewController: UIViewController {
    
    private let appleMusicView = AppleMusicView()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "Search your content"
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigation()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = Bundle.main.appName
        appleMusicView.delegate = self
    }
    
    private func setupNavigation() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .systemCyan
    }
    
    private func setupConstraints() {
        view.addSubview(appleMusicView)
        appleMusicView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appleMusicView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appleMusicView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            appleMusicView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            appleMusicView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func presentItunesViewController(with url: URL) {
        let vc = iTunesViewController()
        vc.songPreview = url
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension AppleMusicViewController: AppleMusicViewDelegate {
    func didSelect(from appleMusicView: AppleMusicView, didSelectURL url: URL) {
        presentItunesViewController(with: url)
    }
    
    func didSelectArtist(from appleMusicView: AppleMusicView, didSelectArtist url: String) {
        guard let url = URL(string: url) else { return }
        presentItunesViewController(with: url)
    }
}

// MARK: - SEARCH RESULTS UPDATING
extension AppleMusicViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            appleMusicView.viewModel.clearView()
            return
        }
        appleMusicView.band = query
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        appleMusicView.viewModel.fetchBand(searchBarText)
        searchBar.resignFirstResponder()
    }
    
    func didTapItem() {
        //        DispatchQueue.main.async { [weak self] in
        //            let vc = PreviewViewController()
        //            vc.configure(with: viewModel)
        //            self?.navigationController?.present(vc, animated: true)
        //        }
    }
}
