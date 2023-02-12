//
//  AppleMusicViewController.swift
//  Apple Music
//
//  Created by Junior Silva on 11/02/23.
//

import UIKit

class AppleMusicViewController: UIViewController {
    
    private let appleMusicView = AppleMusicView()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "Search your content"
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigation()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appleMusicView.frame = view.bounds
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = Bundle.main.appName
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
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
    
}

// MARK: - SEARCH RESULTS UPDATING
extension AppleMusicViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//
//        guard let query = searchBar.text,
//              !query.trimmingCharacters(in: .whitespaces).isEmpty,
//              query.trimmingCharacters(in: .whitespaces).count >= 3,
//              let resultsController = searchController.searchResultsController as? SearchResultsViewController else { return }
//        resultsController.delegate = self
//
//        APICaller.shared.search(with: query) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let titles):
//                    resultsController.titles = titles
//                    resultsController.collectionView.reloadData()
//
//                case .failure(let error):
//                    self.showMessage(withTitle: "Ops!", message: error.localizedDescription)
//                }
//            }
//        }
    }
    
    func didTapItem() {
//        DispatchQueue.main.async { [weak self] in
//            let vc = PreviewViewController()
//            vc.configure(with: viewModel)
//            self?.navigationController?.present(vc, animated: true)
//        }
    }
}
