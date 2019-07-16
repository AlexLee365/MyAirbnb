//
//  VideoCollectionViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 16/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import AVFoundation

class VideoCollectionViewCell: UICollectionViewCell {
    static let identifier = "VideoCollectionViewCell"

    private struct Standard {
        static let space: CGFloat = 50
        static let subViewHeight: CGFloat = 200
    }

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let hostLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var index = 0
    var player: AVPlayer!
    
    private let videoView = UIView()
    private let descLabel = UILabel()
    private let seeDetailButton = UIButton()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        configure()
        autoLayout()
        
    }
    
    func startAnimate() {
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.imageView.alpha = 0
            self.player.play()
            self.layoutIfNeeded()
        })
    }
    
    func endAnimate() {
        imageView.alpha = 1
        player.pause()
    }
    
    func setting(data: [String: String]) {
        let url = URL(string: data["videoUrl"]!)
        let playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
        
        let tempSize = CGSize(width: contentView.frame.width, height: contentView.frame.height - Standard.subViewHeight)
        
        playerLayer.frame = CGRect(origin: .zero, size: tempSize)
        playerLayer.videoGravity = .resizeAspectFill
        videoView.layer.addSublayer(playerLayer)
        
        imageView.image = UIImage(named: data["image"]!)
        imageView.frame = CGRect(origin: .zero, size: tempSize)
        
        descLabel.text = data["desc"]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //    player.play()
    }
    
    private func configure() {
        contentView.backgroundColor = .black
        
        contentView.addSubview(videoView)
        
        descLabel.numberOfLines = 0
        descLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        descLabel.textColor = .white
        descLabel.textAlignment = .center
        contentView.addSubview(descLabel)
        
        seeDetailButton.setTitle("자세히 알아보기", for: .normal)
        seeDetailButton.setTitleColor(.white, for: .normal)
        seeDetailButton.titleLabel?.textAlignment = .center
        seeDetailButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        seeDetailButton.layer.cornerRadius = 9
        seeDetailButton.layer.borderColor = UIColor.white.cgColor
        seeDetailButton.layer.borderWidth = 0.9
        contentView.addSubview(seeDetailButton)
        
        contentView.addSubview(imageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(hostLabel)
    }
    
    private func autoLayout() {
        
        categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 50).isActive = true
        
        hostLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -50).isActive = true
        hostLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: hostLabel.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: hostLabel.topAnchor, constant: -30).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        
        seeDetailButton.translatesAutoresizingMaskIntoConstraints = false
        seeDetailButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        seeDetailButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Standard.space).isActive = true
        seeDetailButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35).isActive = true
        seeDetailButton.heightAnchor.constraint(equalToConstant: 35).isActive = true

        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.centerXAnchor.constraint(equalTo: seeDetailButton.centerXAnchor).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: seeDetailButton.topAnchor, constant: -20).isActive
            = true
        descLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
    }
}
