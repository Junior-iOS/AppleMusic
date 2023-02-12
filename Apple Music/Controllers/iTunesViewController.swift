//
//  iTunesViewController.swift
//  Apple Music
//
//  Created by Junior Silva on 12/02/23.
//

import UIKit
import WebKit

class iTunesViewController: UIViewController {
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    public var songPreview: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
        loadWebView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupConstraints() {
        view.addSubview(webView)
    
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadWebView() {
        guard let url = songPreview else { return }
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: url))
        }
    }
}
