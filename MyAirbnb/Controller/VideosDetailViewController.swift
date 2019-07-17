//
//  VideosDetailViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 15/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import AVFoundation

class VideosDetailViewController: UIViewController {
    
    let videoData: [[String: String]] = [
        ["image": "adventure",
         "videoUrl": "http://tetris.dicemono.xyz/test.mp4"
        ]
    ]
    
    let tempView = UIView()
    let videoImageView = UIImageView()
    let videoView = UIView()
    
    var player: AVPlayer!
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let topView = TableviewTopView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimate()
    }
    
    func startAnimate() {
        UIView.animate(withDuration: 0.7, delay: 0.7, options: [], animations: {
            self.videoImageView.alpha = 0
            self.player.play()
            self.view.layoutIfNeeded()
        })
    }
    
    func setting(data: [String: String]) {
        let url = URL(string: data["videoUrl"]!)
        let playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
        
        let tempSize = CGSize(width: view.frame.width, height: 500)

        playerLayer.frame = CGRect(origin: .zero, size: tempSize)
        playerLayer.videoGravity = .resizeAspectFill
        videoView.layer.addSublayer(playerLayer)
        
        videoImageView.image = UIImage(named: data["image"]!)
        videoImageView.frame = CGRect(origin: .zero, size: tempSize)
    }
    
    private func configure() {
        tempView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 500)
        tableView.tableHeaderView = tempView
        
        tempView.addSubview(videoView)
        tempView.addSubview(videoImageView)
        
        setting(data: videoData[0])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VideosDetailTableCell.self, forCellReuseIdentifier: VideosDetailTableCell.identifier)
        view.addSubview(tableView)
        
        view.addSubview(topView)
    }
    
    private func setAutolayout() {
        let guide = view.safeAreaLayoutGuide
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
}

// MARK: - UITableViewDataSource

extension VideosDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let videoCell = tableView.dequeueReusableCell(withIdentifier: VideosDetailTableCell.identifier, for: indexPath) as! VideosDetailTableCell
            return videoCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension VideosDetailViewController: UITableViewDelegate {
}

