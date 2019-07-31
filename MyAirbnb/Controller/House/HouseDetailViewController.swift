//
//  HouseDetailViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 17/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import Kingfisher
import NVActivityIndicatorView

class HouseDetailViewController: UIViewController {
    
    // MARK: - UIProperties
    let tableView = UITableView()
    let placeholderView = UIView()
    let bottomView = HouseBottomView()
    let indicator = NVActivityIndicatorView(frame: .zero)
    
    // MARK: - Properties
    let notiCenter = NotificationCenter.default
    let jsonDecoder = JSONDecoder()
    let kingfisher = ImageDownloader.default
    let netWork = NetworkCommunicator()
    
    var houseDetailData: HouseDetailData?
    var imageArray = [UIImage]()
    var cellCountAfterDataRoad = 0
    var roomID = 0
    var isDateSelected = false
    
    var typeLablePlaceholder = ""
    var nameLabelPlaceholder = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAutoLayout()
        self.configureViewsOptions()
        self.addNotificationObserver()
        
        self.setPlaceholderView()
        self.showIdicator()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.getServerData {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.setBottomViewData()
                    UIView.animate(withDuration: 0.5, animations: {
                        self.view.bringSubviewToFront(self.tableView)
                        self.view.bringSubviewToFront(self.bottomView)
                        self.tableView.alpha = 1
                        self.bottomView.alpha = 1
                    })
                    self.stopIndicator()
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func setAutoLayout() {
        
        let height = UIScreen.main.bounds.height * 0.10
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(height)
        }
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
    }
    
    private func configureViewsOptions() {
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HouseDetailPicturesTableCell.self, forCellReuseIdentifier: HouseDetailPicturesTableCell.identifier)
        tableView.register(HouseDetailBasicInfoTableCell.self, forCellReuseIdentifier: HouseDetailBasicInfoTableCell.identifier)
        tableView.register(HouseDetailIntroductionTableCell.self, forCellReuseIdentifier: HouseDetailIntroductionTableCell.identifier)
        tableView.register(HouseDetailBedroomsTableCell.self, forCellReuseIdentifier: HouseDetailBedroomsTableCell.identifier)
        tableView.register(HouseDetailStayingDaysTableCell.self, forCellReuseIdentifier: HouseDetailStayingDaysTableCell.identifier)
        tableView.register(HouseDetailFacilityTableCell.self, forCellReuseIdentifier: HouseDetailFacilityTableCell.identifier)
        tableView.register(HouseDetailLocationTableCell.self, forCellReuseIdentifier: HouseDetailLocationTableCell.identifier)
        tableView.register(HouseDetailCheckInTableCell.self, forCellReuseIdentifier: HouseDetailCheckInTableCell.identifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: StandardUIValue.shared.mainViewSideMargin, bottom: 0, right: StandardUIValue.shared.mainViewSideMargin)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.allowsSelection = false
        
        tableView.alpha = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        bottomView.isDateSelected = isDateSelected
        bottomView.reserveBtn.addTarget(self, action: #selector(reserveBtnDidTap(_:)), for: .touchUpInside)
        bottomView.alpha = 0
    }
    
    private func setBottomViewData() {
        guard let data = houseDetailData else { return }
        bottomView.price = data.price
        bottomView.rate = data.drawStarsWithHouseRate()
        bottomView.rateCount = data.reservations.count
    }
    
    @objc private func reserveBtnDidTap(_ sender: UIButton) {
        switch isDateSelected {
        case true:
            let reserveInfoVC = HouseDetailReserveInfoViewController()
            navigationController?.pushViewController(reserveInfoVC, animated: true)
        case false:
            let calendarVC = HouseDetailCalendarViewController()
            present(calendarVC, animated: true)
        }
        
    }
    
    private func addNotificationObserver() {
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .mapViewDidTapInHouseDetailView, object: nil)
    }
    
    @objc func receiveNotification(_ sender: Notification) {
        print("mapView Did Tap Notification")
        guard let userInfo = sender.userInfo as? [String: CLLocationCoordinate2D]
            , let coordinate = userInfo["coordinate"]
            else { print("‼️‼️‼️ noti userInfo convert error");return }
        
        let mapVC = MapViewController()
        mapVC.defaultLocation = coordinate
        mapVC.circleColor = StandardUIValue.shared.colorBlueGreen
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func getServerData(completion: @escaping () -> ()) {
        let urlString = netWork.basicUrlString + "/rooms/\(roomID)/"
        
        netWork.getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json, success) in
            guard success else {
                print("get serverData failed")
                return
            }
            guard let data = try? JSONSerialization.data(withJSONObject: json) else {
                print("‼️ moveToHouseDetail noti data convert error")
                return
            }
            guard let result = try? self.jsonDecoder.decode(HouseDetailData.self, from: data) else {
                print("‼️ moveToHouseDetail noti result decoding convert error")
                return
            }
            self.houseDetailData = result
            self.cellCountAfterDataRoad = 8
            let imageStringArray = [result.image, result.image1, result.image2, result.image3, result.image4]


            for i in 0..<imageStringArray.count{
                guard let url = URL(string: imageStringArray[i]) else { print("houseDetail getServerData imageUrl convert failed"); return }
                self.kingfisher.downloadImage(with: url, options: [], progressBlock: nil, completionHandler: { (result) in
                    switch result {
                    case .success(let value) :
                        self.imageArray.append(value.image)
                    case .failure(let error):
                        print("kingfisher image download failed: ", error.localizedDescription)
                    }
                    if (i == imageStringArray.count - 1) {
                        completion()
                    }

                })
            }
        }
        
        
    }
    
    private func setPlaceholderView() {
        let placeholderColor = #colorLiteral(red: 0.6902005672, green: 0.6860997081, blue: 0.6933541894, alpha: 0.3706389127)
        
        placeholderView.backgroundColor = .white
        view.addSubview(placeholderView)
        placeholderView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(view)
        }
        
        let imageView = UIImageView()
        placeholderView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        imageView.backgroundColor = placeholderColor
        
        let typeLabel = UILabel()
        placeholderView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(25)
            make.leading.equalTo(20)
        }
        
        let nameLabel = UILabel()
        placeholderView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(typeLabel.snp.bottom).offset(5)
            make.leading.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        let hostView = UIView()
        placeholderView.addSubview(hostView)
        hostView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.trailing.equalTo(-20)
            make.width.height.equalTo(80)
        }
        
        hostView.layer.cornerRadius = 40
        hostView.clipsToBounds = true
        hostView.backgroundColor = placeholderColor
        
        typeLabel.text = typeLablePlaceholder
        typeLabel.font = .systemFont(ofSize: 12, weight: .bold)
        typeLabel.textColor = StandardUIValue.shared.colorBrown
        
        nameLabel.text = nameLabelPlaceholder
        nameLabel.configureMainTableViewCellsTitle()
    }
    
    private func showIdicator() {
        let centerX = UIScreen.main.bounds.width/2
        let centerY = UIScreen.main.bounds.height/2
        placeholderView.addSubview(indicator)
        indicator.frame = CGRect(x: centerX-15, y: centerY, width: 30, height: 30)
        indicator.type = .ballBeat
        indicator.color = StandardUIValue.shared.colorBlueGreen
        startIndicator()
    }
    
    private func startIndicator() {
        view.bringSubviewToFront(placeholderView)
        indicator.startAnimating()
    }
    private func stopIndicator() {
        view.sendSubviewToBack(placeholderView)
        indicator.stopAnimating()
    }

}

extension HouseDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCountAfterDataRoad
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = houseDetailData else { print("‼️ HouseDetailVC tableView error"); return UITableViewCell()}
        
        switch indexPath.row {
        case 0:
            let houseDetailPicturesTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailPicturesTableCell.identifier, for: indexPath) as! HouseDetailPicturesTableCell
            houseDetailPicturesTableCell.images = imageArray
            
            return houseDetailPicturesTableCell
        case 1:
            let houseDetailBasicInfoTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailBasicInfoTableCell.identifier, for: indexPath) as! HouseDetailBasicInfoTableCell
            houseDetailBasicInfoTableCell.setData(type: data.roomType, name: data.title, state: data.state, hostName: data.host[0] ?? "", hostImage: nil, capacity: data.capacity, bedroom: data.bedroom, bathroom: data.bathroom)
            
            return houseDetailBasicInfoTableCell
        case 2:
            let houseDetailIntroductionTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailIntroductionTableCell.identifier, for: indexPath) as! HouseDetailIntroductionTableCell
            houseDetailIntroductionTableCell.setData(description: data.houseDescription)
            
            return houseDetailIntroductionTableCell
        case 3:
            let houseDetailBedroomsTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailBedroomsTableCell.identifier, for: indexPath) as! HouseDetailBedroomsTableCell
            houseDetailBedroomsTableCell.bedRoomCount = data.bedroom
            
            return houseDetailBedroomsTableCell
            
        case 4:
            let houseDetailStayingDaysTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailStayingDaysTableCell.identifier, for: indexPath) as! HouseDetailStayingDaysTableCell
            
            houseDetailStayingDaysTableCell.setData(minStayingDay: data.minStay)
            
            return houseDetailStayingDaysTableCell
        case 5:
            let houseDetailFacilityTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailFacilityTableCell.identifier, for: indexPath) as! HouseDetailFacilityTableCell
            houseDetailFacilityTableCell.facilitiesArray = data.facilities
            return houseDetailFacilityTableCell
            
        case 6:
            let houseDetailLocationTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailLocationTableCell.identifier, for: indexPath) as! HouseDetailLocationTableCell
            houseDetailLocationTableCell.setData(state: data.state, LocationDescription: data.locationalDescription, address: data.address)
            return houseDetailLocationTableCell
            
        case 7:
            let houseDetailCheckInTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailCheckInTableCell.identifier, for: indexPath) as! HouseDetailCheckInTableCell
            houseDetailCheckInTableCell.setData(checkIn: "", checkOut: "")
            return houseDetailCheckInTableCell
            
        default : break
        }
        return UITableViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
        let contentY = scrollView.contentOffset.y
//        print(contentY)
        
        if contentY < 0 {     //
            let scaleValue = ( -(contentY)/300 ) + 1
//            print(scaleValue)
            
            let houseDetailPictureCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! HouseDetailPicturesTableCell
            houseDetailPictureCell.scrollView.transform = CGAffineTransform(scaleX: scaleValue, y: scaleValue)
    
//            houseDetailPictureCell.scrollView.transform = CGAffineTransform(scaleX: 0, y: contentY)
            
//            houseDetailPictureCell.pictureViews.first?.transform = CGAffineTransform(scaleX: 0, y: contentY)
//            houseDetailPictureCell.pictureViews.first?.transform = CGAffineTransform(scaleX: scaleValue, y: scaleValue)
        }
    }
}
