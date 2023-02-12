//
//  AppleMusicView.swift
//  Apple Music
//
//  Created by Junior Silva on 12/02/23.
//

import Foundation
import UIKit

final class AppleMusicView: UIView {
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "iTunes")
        imageView.backgroundColor = .systemRed
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.text = "Procure por sua banda favorita.\n\n😎 🎧 🎵"
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.alpha = 0
        table.register(cellClass: AppleMusicTableViewCell.self)
        return table
    }()
    
    private let screen = UIScreen.main.bounds
    public var band = ""
    public var viewModel = AppleMusicViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupTable()
        setupConstraints()
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
        addSubview(contentView)
        contentView.addSubviews(imageView, label, tableView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: screen.width - 40),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension AppleMusicView: AppleMusicViewModelDelegate {
    func didLoadList() {
        UIView.animate(withDuration: 0.3) {
            self.tableView.reloadData()
            self.tableView.alpha = 1
        }
    }
    
    func didClearView() {
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = 0
        }
    }
}
