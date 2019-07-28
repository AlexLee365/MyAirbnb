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
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let topView = TableviewTopView()
    
    let scheduleImages = ["schedule1", "schedule2", "schedule3"]
    let contentsArray = [("Lake Crescent & the Pacific Coast", "Ferry across the Puget Sound. Walk Marymere Falls & Ruby Beach. Coastal campfire & dinner!"), ("Hoh Rainforest & Vanishing Silence", "Hike along the pristine Hoh River. Discover silence in the giant trees of Hoh Rainforest!"), ("Hike Hurricane Ridge", "Climb to Hurricane Ridge and explore new heights in the panoramic Olympic Mountain range.")]

    let lineImages = ["line1", "line2", "line3"]
    
    var linearViewArray = [UIView]()
    
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
        view.backgroundColor = .white
        
        tempView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 500)
        tableView.tableHeaderView = tempView
        
        tempView.addSubview(videoView)
        tempView.addSubview(videoImageView)
        
        setting(data: videoData[0])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VideosDetailTableCell.self, forCellReuseIdentifier: VideosDetailTableCell.identifier)
        tableView.register(TripScheduleTableCell.self, forCellReuseIdentifier: TripScheduleTableCell.identifier)
        view.addSubview(tableView)
        
        topView.delegate = self
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
        return 1 + scheduleImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let videoCell = tableView.dequeueReusableCell(withIdentifier: VideosDetailTableCell.identifier, for: indexPath) as! VideosDetailTableCell
            return videoCell
            
        case 1...scheduleImages.count:
            let tripScheduleCell = tableView.dequeueReusableCell(withIdentifier: TripScheduleTableCell.identifier, for: indexPath) as! TripScheduleTableCell
            
            tripScheduleCell.dayLabel.text = "\(indexPath.row)일차"
            tripScheduleCell.programImage.image = UIImage(named: scheduleImages[indexPath.row - 1])
            tripScheduleCell.titleLabel.text = contentsArray[indexPath.row - 1].0
            tripScheduleCell.descLabel.text = contentsArray[indexPath.row - 1].1
            
            for i in 0..<scheduleImages.count {
                let linearView: UIView = {
                    let view = UIView()
                    view.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
                    return view
                }()
                
                linearViewArray.append(linearView)
            }
            
            for i in 0..<linearViewArray.count {
                tripScheduleCell.contentView.addSubview(linearViewArray[i])
                
                linearViewArray[i].snp.makeConstraints { (make) in
                    make.leading.equalTo(tripScheduleCell.contentView.snp.leading).offset(20)
                    make.width.equalTo(0.5)
                }
                
                switch indexPath.row {
                case 1:
                    linearViewArray[i].snp.makeConstraints { (make) in
                        make.top.equalTo(tripScheduleCell.dayLabel.snp.top)
//                        make.height.equalTo(tripScheduleCell.contentView.snp.height).multipliedBy(0.9)
                        make.bottom.equalTo(tripScheduleCell.contentView)
                    }
                case scheduleImages.count:
                    linearViewArray[i].snp.makeConstraints { (make) in
                        make.top.equalTo(tripScheduleCell.contentView)
                        make.bottom.equalTo(tripScheduleCell.dayLabel.snp.centerY)
                    }
//                    tripScheduleCell.descLabel.snp.makeConstraints { (make) in
//                        make.bottom.equalTo(-20)
//                    }
//                    fallthrough
                default:
                    linearViewArray[i].snp.makeConstraints { (make) in
                        make.top.equalTo(tripScheduleCell.contentView)
                        make.height.equalTo(tripScheduleCell.contentView.snp.height)
                        make.bottom.equalTo(tripScheduleCell.contentView)
                    }
                }
            }
            
            return tripScheduleCell
        
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension VideosDetailViewController: UITableViewDelegate {
}

// MARK: - TableviewTopViewDelegate

extension VideosDetailViewController: TableviewTopViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}

