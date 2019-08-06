//
//  SeoulRecommendedDetailViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 08/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import MapKit
import Kingfisher

class SeoulRecommendedDetailViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(SeoulRecommendTableViewCell.self, forCellReuseIdentifier: SeoulRecommendTableViewCell.identifier)
        tableView.register(HostIntroTableViewCell.self, forCellReuseIdentifier: HostIntroTableViewCell.identifier)
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.identifier)
        tableView.register(TripContentsTableCell.self, forCellReuseIdentifier: TripContentsTableCell.identifier)
        tableView.register(ItemsProvidedTableCell.self, forCellReuseIdentifier: ItemsProvidedTableCell.identifier)
        tableView.register(MemoTableCell.self, forCellReuseIdentifier: MemoTableCell.identifier)
        tableView.register(TripDetailReviewTableCell.self, forCellReuseIdentifier: TripDetailReviewTableCell.identifier)
        tableView.register(MaxGuestTableCell.self, forCellReuseIdentifier: MaxGuestTableCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    let topView = TableviewTopView()
    
    let bottomView = BottomInfoView()

    let priceLabel: UILabel = {
        let label = UILabel()
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
    
    let notiCenter = NotificationCenter.default
    
    var tripDetailUrl = ""
    var scrollImageArray = [UIImage]()
    
    let netWork = NetworkCommunicator()
    let jsonDecoder = JSONDecoder()
    var tripDetailData: TripDetailData?
    var numberOfCell = 0
    var tripAdditionalDetail = [(String, String)]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
        addNotificationObserver()
        getServerData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    var isStatusBarWhite = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isStatusBarWhite {
            return .lightContent
        } else {
            return .default
        }
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        topView.delegate = self
        view.addSubview(topView)
        
        view.addSubview(bottomView)
        bottomView.addSubview(priceLabel)
        bottomView.addSubview(starImageLabel)
        bottomView.addSubview(noOfReviewLabel)
        bottomView.addSubview(seeDateBtn)
    }
    
    @objc func popnav() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // change font size in a single label
    func attributedText(first: String, second: String) -> NSAttributedString{
        let string = first + second as NSString
        let result = NSMutableAttributedString(string: string as String)
        let attributesForFirstWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Bold", size: 17)
        ]
        
        let attributesForSecondWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Book", size: 17)
        ]
        
        // Find the 1st string in the whole string and set its attribute
        result.setAttributes(attributesForFirstWord as [NSAttributedString.Key : Any],
                             range: string.range(of: first))
        
        // Do the same thing for the 2nd string
        result.setAttributes(attributesForSecondWord as [NSAttributedString.Key : Any],
                             range: string.range(of: second))
        
        return NSAttributedString(attributedString: result)
    }
    
    // add notification observer for mapView tapped
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
    
    
    private func setAutolayout() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
        let height = UIScreen.main.bounds.height * 0.12
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.heightAnchor.constraint(equalToConstant: height).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
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
        
        seeDateBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-20)
            make.height.equalToSuperview().multipliedBy(0.64)
            make.width.equalTo(150)
        }
    }
    
    func getServerData() {
        let urlString = tripDetailUrl
        
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
            
            self.tripAdditionalDetail = [("수용 인원: 최대 게스트 \(result.tripDetail.maxGuest)명", ""), ("게스트 필수조건", ""), ("호스트에게 연락하기", ""), ("트립 환불 정책", "모든 트립은 예약 후 24시간 이내에 취소 및 전액 환불이 가능합니다.")]
 
            self.numberOfCell = 7 + 4
            
            DispatchQueue.main.async {
                let priceString = String(self.tripDetailData?.tripDetail.price ?? 0).limitFractionDigits()
                self.priceLabel.attributedText = self.attributedText(first: "₩" + "\(priceString) ", second: "/인")
                self.noOfReviewLabel.text = "(\(self.tripDetailData?.tripDetail.tripReviews.count ?? 0))"
                self.tableView.reloadData()
            }
        }
    }
}


// MARK: - UITableViewDataSource

extension SeoulRecommendedDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let seoulRecommendCell = tableView.dequeueReusableCell(withIdentifier: SeoulRecommendTableViewCell.identifier, for: indexPath) as! SeoulRecommendTableViewCell
            
            guard let tripDetailData = tripDetailData?.tripDetail else { return UITableViewCell() }
            seoulRecommendCell.setData(tripDetailData: tripDetailData)
            
            return seoulRecommendCell
            
        case 1:
            let hostIntroCell = tableView.dequeueReusableCell(withIdentifier: HostIntroTableViewCell.identifier, for: indexPath) as! HostIntroTableViewCell
            
            guard let hostDetailData = tripDetailData?.tripDetail else { return UITableViewCell() }
            hostIntroCell.setData(hostDetailData: hostDetailData)
            
            return hostIntroCell
            
        case 2:
            let tripContentsCell = tableView.dequeueReusableCell(withIdentifier: TripContentsTableCell.identifier, for: indexPath) as! TripContentsTableCell
            
            guard let tripContentsData = tripDetailData?.tripDetail else { return UITableViewCell() }
            tripContentsCell.setData(tripContentsData: tripContentsData)
            
            return tripContentsCell
            
        case 3:
            let itemsProvidedCell = tableView.dequeueReusableCell(withIdentifier: ItemsProvidedTableCell.identifier, for: indexPath) as! ItemsProvidedTableCell
            
            guard let itemsProvidedData = tripDetailData?.tripDetail else { return UITableViewCell() }
            guard !itemsProvidedData.provides.isEmpty else { return UITableViewCell() }
            
            itemsProvidedCell.setData(itemProvidedData: itemsProvidedData)
            
            itemsProvidedCell.providesCount = itemsProvidedData.provides.count
            print("itemsProvidedCell.providesCount: ", itemsProvidedCell.providesCount)
            
            return itemsProvidedCell
            
        case 4:
            let memoCell = tableView.dequeueReusableCell(withIdentifier: MemoTableCell.identifier, for: indexPath) as! MemoTableCell
            
            guard let memoData = tripDetailData?.tripDetail else { return UITableViewCell() }
            memoCell.setData(memoData: memoData)
            
            return memoCell
            
        case 5:
            let placeCell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as! PlaceTableViewCell
            
            guard let placeInfoData = tripDetailData?.tripDetail else { return UITableViewCell() }
            placeCell.setData(placeInfoData: placeInfoData)
            
            return placeCell
     
        case 6:
            let reviewCell = tableView.dequeueReusableCell(withIdentifier: TripDetailReviewTableCell.identifier, for: indexPath) as! TripDetailReviewTableCell
            
            guard let tripDetail = tripDetailData?.tripDetail else { return UITableViewCell() }
            guard let tripReviewData = tripDetailData?.tripDetail.tripReviews else {return UITableViewCell()}
            guard !tripReviewData.isEmpty else { return UITableViewCell() }
            
            reviewCell.setData(tripReviewData: tripReviewData[indexPath.row - 6], tripData: tripDetail)
            reviewCell.delegate = self
            
            return reviewCell
            
        case 7...10:
            let maxGuestCell = tableView.dequeueReusableCell(withIdentifier: MaxGuestTableCell.identifier, for: indexPath) as! MaxGuestTableCell
            
            maxGuestCell.titleLabel.text = tripAdditionalDetail[indexPath.row - 7].0
            maxGuestCell.subLabel.text = tripAdditionalDetail[indexPath.row - 7].1
            
            return maxGuestCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension SeoulRecommendedDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 3:
            if tripDetailData?.tripDetail.provides.count == 0 {
                return 0
            } else {
                return UITableView.automaticDimension
            }
        case 6:
            if tripDetailData?.tripDetail.tripReviews.count == 0 {
                return 0
            } else {
                return UITableView.automaticDimension
            }
        default:
            return UITableView.automaticDimension
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) else { return }

        let becomeWhiteEndPoint = cell.frame.height - topView.frame.height
        let becomeWhiteStartPoint = becomeWhiteEndPoint - 70

        let opacity = ( scrollView.contentOffset.y - becomeWhiteStartPoint ) / (becomeWhiteEndPoint - becomeWhiteStartPoint)
        

        if scrollView.contentOffset.y > becomeWhiteStartPoint {
            navigationController?.view.backgroundColor = UIColor.white.withAlphaComponent(opacity)
            topView.backgroundColor = UIColor.white.withAlphaComponent(opacity)
            topView.backButton.setImage(UIImage(named: "backBlack"), for: .normal)
            topView.heartButton.setImage(UIImage(named: "heartBlack"), for: .normal)
            topView.shareButton.setImage(UIImage(named: "shareBlack"), for: .normal)
            
            isStatusBarWhite = false
        } else {
            navigationController?.view.backgroundColor = UIColor.white.withAlphaComponent(opacity)
            topView.backgroundColor = UIColor.white.withAlphaComponent(opacity)
            topView.backButton.setImage(UIImage(named: "backWhite"), for: .normal)
            topView.heartButton.setImage(UIImage(named: "heartWhite"), for: .normal)
            topView.shareButton.setImage(UIImage(named: "shareWhite"), for: .normal)
            isStatusBarWhite = true
        }

        let cellHeight = cell.frame.height
        let currentY = scrollView.contentOffset.y
        let deviceHeight = UIScreen.main.bounds.height
        let bottomViewHeight = bottomView.frame.height

        let priceString = String(self.tripDetailData?.tripDetail.price ?? 0).limitFractionDigits()
        
        if (cellHeight - currentY) <= (deviceHeight - bottomViewHeight) {
            UIView.animate(withDuration: 0.3) {
                
                func attributedText(first: String, second: String) -> NSAttributedString{
                    let string = first + second as NSString
                    let result = NSMutableAttributedString(string: string as String)
                    let attributesForFirstWord = [
                        NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Bold", size: 17) ?? "",
                        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                        ] as [NSAttributedString.Key : Any]
                    
                    let attributesForSecondWord = [
                        NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Book", size: 17) ?? "",
                        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
                        ] as [NSAttributedString.Key : Any]

                    result.setAttributes(attributesForFirstWord, range: string.range(of: first))
                    result.setAttributes(attributesForSecondWord, range: string.range(of: second))
                    
                    return NSAttributedString(attributedString: result)
                }
                
                self.bottomView.backColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.priceLabel.attributedText = attributedText(first: "₩" + "\(priceString) ", second: "/인")
                self.starImageLabel.textColor = StandardUIValue.shared.colorBlueGreen
                self.noOfReviewLabel.textColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
                self.seeDateBtn.backgroundColor = StandardUIValue.shared.colorPink
                self.seeDateBtn.setTitleColor(.white, for: .normal)
            }
            
        } else {
            self.priceLabel.attributedText = self.attributedText(first: "₩" + "\(priceString) ", second: "/인")
            self.bottomView.backColor = .black
            self.priceLabel.textColor = .white
            self.starImageLabel.textColor = .white
            self.noOfReviewLabel.textColor = .white
            self.seeDateBtn.backgroundColor = .white
            self.seeDateBtn.setTitleColor(#colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1), for: .normal)
        }

        setNeedsStatusBarAppearanceUpdate()
    }
}

extension SeoulRecommendedDetailViewController: TableviewTopViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}

extension SeoulRecommendedDetailViewController: TripDetailReviewTableCellDelegate {
    func presentTripDetailReviewVC() {
        let reviewVC = TripDetailReviewViewController()
        reviewVC.reviewCount = tripDetailData?.tripDetail.tripReviews.count ?? 0
        reviewVC.reviewArray = tripDetailData?.tripDetail.tripReviews ?? []
        present(reviewVC, animated: true)
    }
}
