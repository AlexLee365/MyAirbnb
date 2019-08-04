//
//  VideoView.swift
//  MyAirbnb
//
//  Created by Solji Kim on 16/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import AVFoundation

protocol VideoViewDelegate: class {
    func pushView()
}

class VideoView: UIView {
    
    weak var delegate: VideoViewDelegate?
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
    
    let videoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seeDetailButton: UIButton = {
        let button = UIButton()
        button.setTitle("자세히 알아보기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.clipsToBounds = true
        button.layer.cornerRadius = 9
        button.layer.borderWidth = 0.9
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var player: AVPlayer = {
//        let url = URL(string: "http://tetris.dicemono.xyz/test.mp4")!
        let url = URL(string: "https://a0.muscache.com/v/c9/10/c910f424-fd69-5640-bbe4-38eae799716c/c910f424fd695640bbe438eae799716c_1500k_1.mp4")!
 
        let playerItem = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: playerItem)
        return player
    }()
    
//    var url: URL = URL(string: "http://tetris.dicemono.xyz/test.mp4")! {
    var url: URL =
        URL(string: "https://a0.muscache.com/v/c9/10/c910f424-fd69-5640-bbe4-38eae799716c/c910f424fd695640bbe438eae799716c_1500k_1.mp4")! {
        didSet {
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            player.play()
        }
    }
    
    let blackView = UIView()
    
    var playerLayer: AVPlayerLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        configure()
        setAutolayout()
//        setAnimation()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(imageView)
        self.addSubview(categoryLabel)
        self.addSubview(titleLabel)
        self.addSubview(hostLabel)
        
        blackView.alpha = 0
        
        self.addSubview(videoView)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        playerLayer?.needsDisplayOnBoundsChange = true
        videoView.layer.addSublayer(playerLayer!)
        
        self.addSubview(descLabel)
        
        seeDetailButton.addTarget(self, action: #selector(seeDetailButtonDidTap(_:)), for: .touchUpInside)
        self.addSubview(seeDetailButton)
        
        self.addSubview(blackView)
    }
    
    @objc func seeDetailButtonDidTap(_ sender: UIButton) {
        
        delegate?.pushView()
    }
    
    private func setAutolayout() {
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.78).isActive = true
        
        categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 50).isActive = true
        
        hostLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -50).isActive = true
        hostLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: hostLabel.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: hostLabel.topAnchor, constant: -30).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
  
        videoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        videoView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        videoView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        videoView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.78).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 20).isActive = true
        descLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        seeDetailButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 20).isActive = true
        seeDetailButton.centerXAnchor.constraint(equalTo: descLabel.centerXAnchor).isActive = true
        seeDetailButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
        seeDetailButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        blackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        blackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        blackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        blackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.78).isActive = true
        self.bringSubviewToFront(blackView)
    }
}
