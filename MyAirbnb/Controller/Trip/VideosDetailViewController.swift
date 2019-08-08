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
import Kingfisher

class VideosDetailViewController: UIViewController {
    
//    let videoData: [[String: String]] = [
//        ["image": "adventure",
//         "videoUrl": "http://tetris.dicemono.xyz/test.mp4"
//        ]
//    ]
    
    let tempView = UIView()
    let videoImageView = UIImageView()
    let videoView = UIView()
    
    var player: AVPlayer?
    
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
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 17)
        label.textColor = .white
        return label
    }()
    
    let starImageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 13)
        label.textColor = .white
        return label
    }()
    
    let noOfReviewLabel: UILabel = {
        let label = UILabel()
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
    
    let newTripLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 12)
        return label
    }()

    
//    let scheduleImages = ["schedule1", "schedule2", "schedule3"]
//    let contentsArray = [("Lake Crescent & the Pacific Coast", "Ferry across the Puget Sound. Walk Marymere Falls & Ruby Beach. Coastal campfire & dinner!"), ("Hoh Rainforest & Vanishing Silence", "Hike along the pristine Hoh River. Discover silence in the giant trees of Hoh Rainforest!"), ("Hike Hurricane Ridge", "Climb to Hurricane Ridge and explore new heights in the panoramic Olympic Mountain range.")]
//    
//    let imageCollectionArray = ["videoDetailImage1", "videoDetailImage2", "videoDetailImage3", "videoDetailImage4", "videoDetailImage5", "videoDetailImage6", "videoDetailImage7"]
    
    
    let notiCenter = NotificationCenter.default
    let kingfisher = ImageDownloader.default
    
    var adventureDetailUrl = ""
    var adventureAdditionalArray = [AdventureAdditional]()
    
    let netWork = NetworkCommunicator()
    let jsonDecoder = JSONDecoder()
    
    var tripDetailData: TripDetailData?
    var additionalData: Additional?
    var scheduleDataArray = [AdditionalSchedule]()
    
    var numberOfCell = 0
    var imageArray = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
        
        addNotificationObserver()
        getServerData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .blackTranslucent
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
        
//        setting(data: videoData[0])
        
        if !adventureAdditionalArray.isEmpty {
            setting(data: adventureAdditionalArray[0])
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        topView.delegate = self
        view.addSubview(topView)
        
        view.addSubview(bottomView)
        bottomView.addSubview(priceLabel)
        bottomView.addSubview(starImageLabel)
        bottomView.addSubview(noOfReviewLabel)
        bottomView.addSubview(newTripLabel)
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
        
        noOfReviewLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(starImageLabel.snp.centerY)
            make.leading.equalTo(starImageLabel.snp.trailing).offset(3)
        }
        
        newTripLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.leading.equalTo(20)
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
            self.player?.play()
            self.view.layoutIfNeeded()
        })
    }
    
    
//    func setting(data: [String: String]) {
//        let url = URL(string: data["videoUrl"]!)
//        let playerItem = AVPlayerItem(url: url!)
//        player = AVPlayer(playerItem: playerItem)
//
//        let playerLayer = AVPlayerLayer(player: player)
//
//        let tempSize = CGSize(width: view.frame.width, height: 500)
//
//        playerLayer.frame = CGRect(origin: .zero, size: tempSize)
//        playerLayer.videoGravity = .resizeAspectFill
//        videoView.layer.addSublayer(playerLayer)
//
//        videoImageView.image = UIImage(named: data["image"]!)
//        videoImageView.frame = CGRect(origin: .zero, size: tempSize)
//    }
    
//    func setting(data: [String: String]) {
    func setting(data: AdventureAdditional) {
//        let url = URL(string: data["videoUrl"]!)
        let url = URL(string: data.media)
        let playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
        
        let tempSize = CGSize(width: view.frame.width, height: 500)
        
        playerLayer.frame = CGRect(origin: .zero, size: tempSize)
        playerLayer.videoGravity = .resizeAspectFill
        videoView.layer.addSublayer(playerLayer)
        
//        videoImageView.image = UIImage(named: data["image"]!)
        let imageUrl = URL(string: data.image1 ?? "")
        videoImageView.kf.setImage(with: imageUrl)
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
    
    func getServerData(completion: @escaping () -> ()) {
        let urlString = adventureDetailUrl
        
        netWork.getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json, success) in
            
            guard success else {
                print("get serverData failed")
                return
            }
            
            guard let data = try? JSONSerialization.data(withJSONObject: json) else {
                print("‼️ moveToHouseDetail noti data convert error")
                return
            }
            
            guard let result = try? self.jsonDecoder.decode(TripDetailData.self, from: data) else {
                print("‼️ TripSearchMainViewController noti result decoding convert error")
                return
            }
            
            self.tripDetailData = result
//            self.numberOfCell = 7 + self.scheduleImages.count

            if !(result.tripDetail.additional[0]?.additionalSchedule.isEmpty ?? true) {
                self.numberOfCell = 7 + (result.tripDetail.additional[0]?.additionalSchedule.count ?? 0)
            } else {
                self.numberOfCell = 7
            }
            
            self.additionalData = result.tripDetail.additional[0]
            self.scheduleDataArray = result.tripDetail.additional.compactMap{$0}[0].additionalSchedule.compactMap{$0}
            
            
            
            self.scheduleDataArray.reverse()
            
            let imageStringArray = [self.additionalData?.image1, self.additionalData?.image2, self.additionalData?.image3, self.additionalData?.image4, self.additionalData?.image5, self.additionalData?.image6, self.additionalData?.image7]
            
            
            
            let priceString = String(result.tripDetail.price).limitFractionDigits()
            
            DispatchQueue.main.async {
                
                if result.tripDetail.tripReviews.isEmpty {
                    self.starImageLabel.isHidden = true
                    self.noOfReviewLabel.isHidden = true
                    self.newTripLabel.isHidden = false
                    self.newTripLabel.text = "신규 트립"
                } else {
                    self.starImageLabel.isHidden = false
                    self.noOfReviewLabel.isHidden = false
                    self.newTripLabel.isHidden = true
                }
                
                self.priceLabel.text = "₩\(priceString)/인"
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension VideosDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tripDetails = tripDetailData?.tripDetail else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            let videoCell = tableView.dequeueReusableCell(withIdentifier: VideosDetailTableCell.identifier, for: indexPath) as! VideosDetailTableCell
            
            videoCell.setData(tripDetail: tripDetails)
            
            return videoCell
            
        case 1:
            let programDescCell = tableView.dequeueReusableCell(withIdentifier: ProgramDescriptionTableCell.identifier, for: indexPath) as! ProgramDescriptionTableCell
            
            programDescCell.setData(tripData: tripDetails)
            
            return programDescCell
            
        case 2:
            let imageCollectionCell = tableView.dequeueReusableCell(withIdentifier: ImagesCollectionTableCell.identifier, for: indexPath) as! ImagesCollectionTableCell

            if let data = additionalData {
                imageCollectionCell.setData(tripAdditionalData: data)
            }
            
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
            
//        case 5...(scheduleImages.count + 4):
        case 5..<((scheduleDataArray.count) + 5):
            let tripScheduleCell = tableView.dequeueReusableCell(withIdentifier: TripScheduleTableCell.identifier, for: indexPath) as! TripScheduleTableCell
            tripScheduleCell.currentIndex = indexPath.row
            tripScheduleCell.setData(additionalScheduleData: scheduleDataArray[indexPath.row - 5])
            
            if indexPath.row == 5 {
                tripScheduleCell.lineTopView.isHidden = true
            } else if  indexPath.row == scheduleDataArray.count + 4 {
                tripScheduleCell.lineView.isHidden = true
            } else {
                tripScheduleCell.lineTopView.isHidden = false
                tripScheduleCell.lineView.isHidden = false
            }
        
            
            return tripScheduleCell
        
        case (scheduleDataArray.count + 5):
            let hostCell = tableView.dequeueReusableCell(withIdentifier: VideoHostInfoTableCell.identifier, for: indexPath) as! VideoHostInfoTableCell
            
            hostCell.setData(tripData: tripDetails)
            
            return hostCell
            
        case (scheduleDataArray.count + 6):
            let visitingPlaceCell = tableView.dequeueReusableCell(withIdentifier: VisitingPlaceTableCell.identifier, for: indexPath) as! VisitingPlaceTableCell
            
            visitingPlaceCell.setData(tripData: tripDetails)
            
            return visitingPlaceCell
            
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension VideosDetailViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0:
//        case 1:
//        case 2:
//        case 3:
//        case 4:
//        case 5:
//            
//        default:
//            <#code#>
//        }
//    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) else { return }
        
        let becomeWhiteEndPoint = cell.frame.height - topView.frame.height
        
        if scrollView.contentOffset.y >= cell.frame.height {
            self.navigationController?.self.navigationBar.barStyle = .default
            topView.backgroundColor = .white
            topView.backButton.setImage(UIImage(named: "backBlack"), for: .normal)
            topView.heartButton.setImage(UIImage(named: "heartBlack"), for: .normal)
            topView.shareButton.setImage(UIImage(named: "shareBlack"), for: .normal)
            
        } else {
            self.navigationController?.self.navigationBar.barStyle = .blackTranslucent
            topView.backgroundColor = .clear
            topView.backButton.setImage(UIImage(named: "backWhite"), for: .normal)
            topView.heartButton.setImage(UIImage(named: "heartWhite"), for: .normal)
            topView.shareButton.setImage(UIImage(named: "shareWhite"), for: .normal)
        }
        
        let cellHeight = cell.frame.height
        let currentY = scrollView.contentOffset.y
        let bottomViewHeight = bottomView.frame.height
        
        if currentY >= cellHeight - bottomViewHeight {
            UIView.animate(withDuration: 0.3) {
                self.bottomView.backColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.priceLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                self.starImageLabel.textColor = StandardUIValue.shared.colorBlueGreen
                self.noOfReviewLabel.textColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
                self.newTripLabel.textColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
                self.seeDateBtn.backgroundColor = StandardUIValue.shared.colorPink
                self.seeDateBtn.setTitleColor(.white, for: .normal)
            }
            
        } else {
            self.bottomView.backColor = .black
            self.priceLabel.textColor = .white
            self.starImageLabel.textColor = .white
            self.noOfReviewLabel.textColor = .white
            self.newTripLabel.textColor = .white
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

