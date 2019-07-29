//
//  VideosDetailViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 15/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit

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
        
        tableView.register(VideosDetailTableCell.self, forCellReuseIdentifier: VideosDetailTableCell.identifier)
        tableView.register(ProgramDescriptionTableCell.self, forCellReuseIdentifier: ProgramDescriptionTableCell.identifier)
        tableView.register(ItemsProvidingTableCell.self, forCellReuseIdentifier: ItemsProvidingTableCell.identifier)
        tableView.register(ImagesCollectionTableCell.self, forCellReuseIdentifier: ImagesCollectionTableCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TripScheduleTableCell.self, forCellReuseIdentifier: TripScheduleTableCell.identifier)
        tableView.register(VideoHostInfoTableCell.self, forCellReuseIdentifier: VideoHostInfoTableCell.identifier)
        tableView.register(VisitingPlaceTableCell.self, forCellReuseIdentifier: VisitingPlaceTableCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let topView = TableviewTopView()
    let bottomView = BottomInfoView()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "₩40,000 /인"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 17)
        label.textColor = .white
        return label
    }()
    
    let starImageLabel: UILabel = {
        let label = UILabel()
        label.text = String(repeating: "★", count: 5)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 13)
        label.textColor = .white
        return label
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "201"
        label.textColor = .white
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 12)
        return label
    }()
    
    let seeDateBtn: UIButton = {
        let button = UIButton()
        button.setTitle("날짜 보기", for: .normal)
        button.titleLabel?.font = UIFont(name: "AirbnbCerealApp-Bold", size: 14.5)
        button.layer.cornerRadius = 5
        button.setTitleColor(#colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1), for: .normal)
        button.backgroundColor = .white
        return button
    }()

    
    let scheduleImages = ["schedule1", "schedule2", "schedule3"]
    let contentsArray = [("Lake Crescent & the Pacific Coast", "Ferry across the Puget Sound. Walk Marymere Falls & Ruby Beach. Coastal campfire & dinner!"), ("Hoh Rainforest & Vanishing Silence", "Hike along the pristine Hoh River. Discover silence in the giant trees of Hoh Rainforest!"), ("Hike Hurricane Ridge", "Climb to Hurricane Ridge and explore new heights in the panoramic Olympic Mountain range.")]
    
    let imageCollectionArray = ["videoDetailImage1", "videoDetailImage2", "videoDetailImage3", "videoDetailImage4", "videoDetailImage5", "videoDetailImage6", "videoDetailImage7"]
    
    
    let notiCenter = NotificationCenter.default
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
        
        addNotificationObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimate()
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
        view.addSubview(tableView)
        
        topView.delegate = self
        view.addSubview(topView)
        
        view.addSubview(bottomView)
        bottomView.addSubview(priceLabel)
        bottomView.addSubview(starImageLabel)
        bottomView.addSubview(rateLabel)
        bottomView.addSubview(seeDateBtn)
    }
    
    private func setAutolayout() {
        let guide = view.safeAreaLayoutGuide
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
        let height = UIScreen.main.bounds.height * 0.12
        
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.leading.top.equalTo(20)
        }
        
        starImageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.leading.equalTo(20)
        }
        
        rateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(starImageLabel.snp.centerY)
            make.leading.equalTo(starImageLabel.snp.trailing).offset(3)
        }
        
        seeDateBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-20)
            make.height.equalToSuperview().multipliedBy(0.64)
            make.width.equalTo(150)
        }
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
    
    
    private func addNotificationObserver() {
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .mapViewDidTapInHouseDetailView, object: nil)
    }
    
    @objc func receiveNotification(_ sender: Notification) {
        print("mapView Did Tap Notification")
        guard let userInfo = sender.userInfo as? [String: CLLocationCoordinate2D]
            , let coordinate = userInfo["coordinate"]
            else { print("‼️‼️‼️ noti userInfo convert error"); return }
        
        let mapVC = MapViewController()
        mapVC.defaultLocation = coordinate
        mapVC.circleColor = StandardUIValue.shared.colorBlueGreen
        navigationController?.pushViewController(mapVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension VideosDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7 + scheduleImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let videoCell = tableView.dequeueReusableCell(withIdentifier: VideosDetailTableCell.identifier, for: indexPath) as! VideosDetailTableCell
            return videoCell
            
        case 1:
            let programDescCell = tableView.dequeueReusableCell(withIdentifier: ProgramDescriptionTableCell.identifier, for: indexPath) as! ProgramDescriptionTableCell
            return programDescCell
            
        case 2:
            let imageCollectionCell = tableView.dequeueReusableCell(withIdentifier: ImagesCollectionTableCell.identifier, for: indexPath) as! ImagesCollectionTableCell
            
            imageCollectionCell.firstImage.image = UIImage(named: imageCollectionArray[indexPath.row - 2])
            imageCollectionCell.secondImage.image = UIImage(named: imageCollectionArray[indexPath.row - 1])
            imageCollectionCell.thirdImage.image = UIImage(named: imageCollectionArray[indexPath.row])
            imageCollectionCell.fourthImage.image = UIImage(named: imageCollectionArray[indexPath.row + 1])
            imageCollectionCell.fifthImage.image = UIImage(named: imageCollectionArray[indexPath.row + 2])
            imageCollectionCell.sixthImage.image = UIImage(named: imageCollectionArray[indexPath.row + 3])
            imageCollectionCell.seventhImage.image = UIImage(named: imageCollectionArray[indexPath.row + 4])
            
            return imageCollectionCell
            
        case 3:
            let itemsCell = tableView.dequeueReusableCell(withIdentifier: ItemsProvidingTableCell.identifier, for: indexPath) as! ItemsProvidingTableCell
            return itemsCell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "여행 일정표"
            cell.textLabel?.font = UIFont(name: "AirbnbCerealApp-Bold", size: 25)
            cell.textLabel?.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            cell.selectionStyle = .none
            return cell
            
        case 5...(scheduleImages.count + 4):
            let tripScheduleCell = tableView.dequeueReusableCell(withIdentifier: TripScheduleTableCell.identifier, for: indexPath) as! TripScheduleTableCell
            tripScheduleCell.dayLabel.text = "\(indexPath.row - 4)일차"
            tripScheduleCell.programImage.image = UIImage(named: scheduleImages[indexPath.row - 5])
            tripScheduleCell.titleLabel.text = contentsArray[indexPath.row - 5].0
            tripScheduleCell.descLabel.text = contentsArray[indexPath.row - 5].1
            tripScheduleCell.tripTotalDays = contentsArray.count
            tripScheduleCell.currentIndex = indexPath.row
            
            return tripScheduleCell
        
        case (scheduleImages.count + 5):
            let hostCell = tableView.dequeueReusableCell(withIdentifier: VideoHostInfoTableCell.identifier, for: indexPath) as! VideoHostInfoTableCell
            
            return hostCell
            
        case (scheduleImages.count + 6):
            let visitingPlaceCell = tableView.dequeueReusableCell(withIdentifier: VisitingPlaceTableCell.identifier, for: indexPath) as! VisitingPlaceTableCell
            
            return visitingPlaceCell
            
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension VideosDetailViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) else { return }
        
        let cellHeight = cell.frame.height
        let currentY = scrollView.contentOffset.y
        let bottomViewHeight = bottomView.frame.height
        
        if currentY >= cellHeight - bottomViewHeight {
            UIView.animate(withDuration: 0.3) {
                self.bottomView.backColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.priceLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                self.starImageLabel.textColor = StandardUIValue.shared.colorBlueGreen
                self.rateLabel.textColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
                self.seeDateBtn.backgroundColor = StandardUIValue.shared.colorPink
                self.seeDateBtn.setTitleColor(.white, for: .normal)
            }
            
        } else {
            self.bottomView.backColor = .black
            self.priceLabel.textColor = .white
            self.starImageLabel.textColor = .white
            self.rateLabel.textColor = .white
            self.seeDateBtn.backgroundColor = .white
            self.seeDateBtn.setTitleColor(#colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1), for: .normal)
        }
    }
}

// MARK: - TableviewTopViewDelegate

extension VideosDetailViewController: TableviewTopViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}

