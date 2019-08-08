//
//  LuxeHouseViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 27/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import NVActivityIndicatorView

class LuxeHouseViewController: UIViewController {
    
    // MARK: - UI Properties
    let headerImageView = UIImageView()
    let tableView = UITableView()
    
    let placeholderView = UIView()
    let bottomView = HouseBottomView()
    let indicator = NVActivityIndicatorView(frame: .zero)
    
    
    // MARK: - Properties
    let netWork = NetworkCommunicator()
    var roomID = 0
    var roomTitle = ""
    var luxeHouseData: HouseDetailData?
    var cellCountAfterDataRoad = 0
    
    var facilityArrayFirst = [[String]]()
    var facilityArraySecond = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setAutolayout()
        configure()
        setPlaceholderView()
        showIdicator()
        getLuxeServerData {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.tableView.reloadData()
                //                self.setBottomViewData()
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.bringSubviewToFront(self.tableView)
                    self.view.bringSubviewToFront(self.bottomView)
                    self.tableView.alpha = 1
                    self.bottomView.alpha = 1
                })
                self.stopIndicator()
            })
        }
        
        print("🔵🔵🔵  ")
        print(roomID)
        print(roomTitle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        setHeaderView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerImageView
        tableView.register(LuxeDetailIntroTableCell.self, forCellReuseIdentifier: LuxeDetailIntroTableCell.identifier)
        tableView.register(LuxeDetailImagesTableCell.self, forCellReuseIdentifier: LuxeDetailImagesTableCell.identifier)
        tableView.register(LuxeDetailBedRoomsTableCell.self, forCellReuseIdentifier: LuxeDetailBedRoomsTableCell.identifier)
        tableView.register(LuxeDetailMoreInfoTableCell.self, forCellReuseIdentifier: LuxeDetailMoreInfoTableCell.identifier)
        tableView.register(LuxeDetailBasicServiceTableCell.self, forCellReuseIdentifier: "BasicService")
        tableView.register(LuxeDetailBasicServiceTableCell.self, forCellReuseIdentifier: "ChoiceService")
        tableView.register(LuxeDetailInclusionInfoTableCell.self, forCellReuseIdentifier: LuxeDetailInclusionInfoTableCell.identifier)
        tableView.backgroundColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.estimatedRowHeight = 100
        tableView.alpha = 0
    }
    
    private func setAutolayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(0)
        }
    }
    
    private func setHeaderView() {
        let headerWidth = UIScreen.main.bounds.width
        let headerHeight = UIScreen.main.bounds.height * 0.8
        headerImageView.frame = CGRect(x: 0, y: 0, width: headerWidth, height: headerHeight)
        if let url = URL(string: luxeHouseData?.image ?? "") {
            headerImageView.kf.setImage(with: url)
        }
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        button.setTitle("숙소 둘러보기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.titleLabel?.font = UIFont(name: StandardUIValue.shared.airbnbBoldFontString, size: 12)
        button.setTitleColor(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        headerImageView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.trailing.equalTo(-25)
            make.bottom.equalTo(-20)
            make.width.equalTo(140)
            make.height.equalTo(40)
        }
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "listImage")
        button.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(22)
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
            make.height.equalTo(UIScreen.main.bounds.height * 0.8)
        }
        imageView.backgroundColor = placeholderColor
        
        let logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "LuxeDetailLogo")
        placeholderView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalTo(StandardUIValue.shared.mainViewSideMargin)
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        let titleLabel = UILabel()
        placeholderView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(StandardUIValue.shared.mainViewSideMargin)
            make.top.equalTo(logoImageView.snp.bottom).offset(5)
        }
        
        //        let locationLabel = UILabel()
        //        placeholderView.addSubview(locationLabel)
        //        locationLabel.snp.makeConstraints { (make) in
        //            make.leading.equalTo(StandardUIValue.shared.mainViewSideMargin)
        //            make.top.equalTo(roomTitleLabel.snp.bottom).offset(8)
        //        }
        
        titleLabel.text = roomTitle
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 30)
        
        //        locationLabel.text = nameLabelPlaceholder
        //        locationLabel.textColor = .black
        //        locationLabel.font = .systemFont(ofSize: 13, weight: .regular)
    }
    
    private func getLuxeServerData(completion: @escaping () -> () ) {
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
            guard let result = try? JSONDecoder().decode(HouseDetailData.self, from: data) else {
                print("‼️ moveToHouseDetail noti result decoding convert error")
                return
            }
            
            self.luxeHouseData = result
            self.cellCountAfterDataRoad = 7
            
            for index in 0..<result.facilities.count {
                switch index {
                case 0...2:
                    self.facilityArrayFirst.append(result.facilities[index])
                default:
                    self.facilityArraySecond.append(result.facilities[index])
                }
            }
            
            DispatchQueue.main.async {
                if let url = URL(string: self.luxeHouseData?.image ?? "") {
                    self.headerImageView.kf.setImage(with: url)
                }
                completion()
            }
        }
    }
    
    private func showIdicator() {
        //        let centerX = UIScreen.main.bounds.width/2
        //        let centerY = UIScreen.main.bounds.height/2
        placeholderView.addSubview(indicator)
        //        indicator.frame = CGRect(x: centerX-15, y: centerY, width: 30, height: 30)
        indicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.height.equalTo(30)
        }
        indicator.type = .ballBeat
        indicator.color = StandardUIValue.shared.colorPurple
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

extension LuxeHouseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCountAfterDataRoad
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let luxeData = luxeHouseData else { print("‼️ luxeData convert "); return UITableViewCell()}
        switch indexPath.row {
        case 0:
            let introCell = tableView.dequeueReusableCell(withIdentifier: LuxeDetailIntroTableCell.identifier, for: indexPath) as! LuxeDetailIntroTableCell
            introCell.setData(luxeData: luxeData)
            return introCell
            
        case 1:
            let imagesCell = tableView.dequeueReusableCell(withIdentifier: LuxeDetailImagesTableCell.identifier, for: indexPath) as! LuxeDetailImagesTableCell
            imagesCell.setData(luxeData: luxeData)
            return imagesCell
            
        case 2:
            let bedroomsCell = tableView.dequeueReusableCell(withIdentifier: LuxeDetailBedRoomsTableCell.identifier, for: indexPath) as! LuxeDetailBedRoomsTableCell
            bedroomsCell.luxeData = luxeData
            return bedroomsCell
            
        case 3:
            let moreInfoCell = tableView.dequeueReusableCell(withIdentifier: LuxeDetailMoreInfoTableCell.identifier, for: indexPath) as! LuxeDetailMoreInfoTableCell
            return moreInfoCell
            
        case 4:
            let serviceCell = tableView.dequeueReusableCell(withIdentifier: "BasicService", for: indexPath) as! LuxeDetailBasicServiceTableCell
            serviceCell.titleLabel.text = "숙박에 포함된 서비스"
            serviceCell.data = ["버틀러", "셰프", "청소"]
            serviceCell.seeBottomButton = false
            serviceCell.facilitiesArray = facilityArrayFirst
            
            return serviceCell
            
        case 5:
            let serviceCell = tableView.dequeueReusableCell(withIdentifier: "ChoiceService", for: indexPath) as! LuxeDetailBasicServiceTableCell
            serviceCell.titleLabel.text = "추가 선택 서비스"
            serviceCell.subtitleLabel.text = "숙소 예약 후에도 필요하신 모든 추가 서비스의 예약을 여행 디자이너가 도와드립니다."
            serviceCell.data = ["공항 교통편", "차량 대여", "식료품 주문", "아이 돌봄 서비스", "운전사"]
            serviceCell.seeBottomButton = true
            
            serviceCell.facilitiesArray = facilityArraySecond
            
            return serviceCell
            
        case 6:
            let inclusionInfoCell = tableView.dequeueReusableCell(withIdentifier: LuxeDetailInclusionInfoTableCell.identifier, for: indexPath) as! LuxeDetailInclusionInfoTableCell
            return inclusionInfoCell
            
        default: break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 1:
            let spacing: CGFloat = 12
            let smallImageWidth = (UIScreen.main.bounds.width - 40 - spacing) / 2
            let smallImageHeight = smallImageWidth * 0.65
            let bigImageHeight = ( UIScreen.main.bounds.width - 40 ) * 0.65
            
            let totalHeight = bigImageHeight + smallImageHeight * 3 + spacing * 3 + 140
            return totalHeight
            
//        case 4:
//            let cellWidth = (UIScreen.main.bounds.width - 40 - 12) / 2
//            let cellheight = cellWidth * 0.9
//            let lineCount = CGFloat(facilityArrayFirst.count / 2) + ( (facilityArrayFirst.count % 2 == 1) ? 1 : 0 )
//            let collectionViewHeight = cellheight * lineCount + 10 * (lineCount - 1)
//            
//            return collectionViewHeight + 180
            
        default :
            return UITableView.automaticDimension
        }
        
//
//        if indexPath.row == 1 {
//            let spacing: CGFloat = 12
//            let smallImageWidth = (UIScreen.main.bounds.width - 40 - spacing) / 2
//            let smallImageHeight = smallImageWidth * 0.65
//            let bigImageHeight = ( UIScreen.main.bounds.width - 40 ) * 0.65
//
//            let totalHeight = bigImageHeight + smallImageHeight * 3 + spacing * 3 + 140
//            return totalHeight
//        } else {
//            return UITableView.automaticDimension
//        }
    }
    
}
