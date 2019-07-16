//
//  VideoView.swift
//  MyAirbnb
//
//  Created by Solji Kim on 16/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import AVFoundation

class VideoView: UIView {
    
    
    
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
        label.text = "Island hop around Galapagos for wild, up-close encounters and local food"
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
    
    let player: AVPlayer = {
        let url = URL(string: "http://tetris.dicemono.xyz/test.mp4")!
        let playerItem = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: playerItem)
        return player
    }()
    
    var playerLayer: AVPlayerLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(videoView)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        playerLayer?.needsDisplayOnBoundsChange = true
        videoView.layer.addSublayer(playerLayer!)
        
        self.addSubview(descLabel)
        self.addSubview(seeDetailButton)
    }
    
    private func setAutolayout() {
        
        videoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        videoView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        videoView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        videoView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.76).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 20).isActive = true
        descLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        seeDetailButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 20).isActive = true
        seeDetailButton.centerXAnchor.constraint(equalTo: descLabel.centerXAnchor).isActive = true
        seeDetailButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
        seeDetailButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
}
