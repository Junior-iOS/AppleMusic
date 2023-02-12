//
//  AppleMusicTableViewCell.swift
//  Apple Music
//
//  Created by Junior Silva on 12/02/23.
//

import UIKit
import SDWebImage
import AVFoundation

class AppleMusicTableViewCell: UITableViewCell {

    private let imgTrackCover: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trackPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var btnPlay: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapPlaySongButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [trackNameLabel, trackPriceLabel, releaseDateLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    let player = AVQueuePlayer()
    private var songPreview = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgTrackCover.image = nil
        trackNameLabel.text = nil
        trackPriceLabel.text = nil
        releaseDateLabel.text = nil
    }
    
    private func setupCell() {
        contentView.addSubviews(imgTrackCover, vStack, btnPlay)
        
        NSLayoutConstraint.activate([
            imgTrackCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imgTrackCover.trailingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: -20),
            imgTrackCover.centerYAnchor.constraint(equalTo: vStack.centerYAnchor),
            imgTrackCover.heightAnchor.constraint(equalToConstant: 50),
            imgTrackCover.widthAnchor.constraint(equalToConstant: 50),
            
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            vStack.leadingAnchor.constraint(equalTo: imgTrackCover.trailingAnchor),
            vStack.trailingAnchor.constraint(equalTo: btnPlay.leadingAnchor, constant: 10),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            trackPriceLabel.heightAnchor.constraint(equalToConstant: 20),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            btnPlay.centerYAnchor.constraint(equalTo: vStack.centerYAnchor),
            btnPlay.leadingAnchor.constraint(equalTo: vStack.trailingAnchor),
            btnPlay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            btnPlay.heightAnchor.constraint(equalToConstant: 40),
            btnPlay.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        setupLabels()
    }
    
    private func setupLabels() {
        trackNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        trackNameLabel.numberOfLines = 0

        trackPriceLabel.font = .systemFont(ofSize: 15, weight: .medium)
        trackPriceLabel.textColor = UIColor.darkGray

        releaseDateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        releaseDateLabel.textColor = UIColor.darkGray
    }
    
    func configure(track: Track?) {
        guard let track = track,
              let artwork = track.artworkUrl,
              let currency = track.currency,
              let price = track.trackPrice,
              let releaseDate = track.releaseDate,
              let trackPreview = track.previewUrl
        else { return }
        
        self.songPreview = trackPreview
        
        DispatchQueue.main.async {
            self.imgTrackCover.sd_setImage(with: URL(string: artwork))
            self.trackNameLabel.text = track.trackName
            self.trackPriceLabel.text = "\(String(describing: currency)) \(String(describing: price))"
            self.releaseDateLabel.text = "Lançado em \(String(describing: releaseDate))"
        }
    }
    
    @objc private func didTapPlaySongButton() {
        if let url = URL(string: songPreview) {
            UIApplication.shared.open(url)
        }
    }
}
