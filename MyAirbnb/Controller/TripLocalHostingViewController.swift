//
//  TripLocalHostingViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 15/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import AVFoundation

class TripLocalHostingViewController: UIViewController {

    let videoView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topView = TableviewTopView()
    
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
    
    var playerLayer = AVPlayerLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setAutolayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        
        player.play()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        playerLayer.frame = videoView.bounds
    }

    
    private func configure() {
        view.backgroundColor = .black
        
        view.addSubview(videoView)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
//            .resizeAspect
        playerLayer.needsDisplayOnBoundsChange = true
        videoView.layer.addSublayer(playerLayer)
        
        topView.backButton.setImage(UIImage(named: "cancel"), for: .normal)
        topView.backButton.addTarget(self, action: #selector(closeButtonDidTap(_:)), for: .touchUpInside)
        
        view.addSubview(topView)
        view.addSubview(descLabel)
        view.addSubview(seeDetailButton)
    }
    
    @objc func closeButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    private func setAutolayout() {
        let guide = view.safeAreaLayoutGuide
        
        videoView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        videoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.76).isActive = true
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        topView.backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        topView.backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 20).isActive = true
        descLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        seeDetailButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 20).isActive = true
        seeDetailButton.centerXAnchor.constraint(equalTo: descLabel.centerXAnchor).isActive = true
        seeDetailButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
        seeDetailButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
}


