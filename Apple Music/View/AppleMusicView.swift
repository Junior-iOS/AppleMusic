//
//  AppleMusicView.swift
//  Apple Music
//
//  Created by Junior Silva on 12/02/23.
//

import Foundation
import UIKit

final class AppleMusicView: UIView {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    public var band = ""
    public var viewModel = AppleMusicViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupTable()
        setupConstraints()
        backgroundColor = .systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        viewModel.delegate = self
        backgroundColor = .systemBackground
        addSubview(tableView)
    }
    
    private func setupTable() {
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
    
    private func setupConstraints() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension AppleMusicView: AppleMusicViewModelDelegate {
    func didLoadList() {
        tableView.reloadData()
    }
}
