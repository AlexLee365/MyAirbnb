//
//  PlusViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 25/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import NVActivityIndicatorView

class PlusViewController: UIViewController {

    // MARK: - UI Properties
    let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "roomSample3")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let topView: TableviewTopView = {
        let view = TableviewTopView()
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(PlusIntroTableCell.self, forCellReuseIdentifier: PlusIntroTableCell.identifier)
        tableView.register(BrowsePhotosTableCell.self, forCellReuseIdentifier: BrowsePhotosTableCell.identifier)
        tableView.register(FacilityTableCell.self, forCellReuseIdentifier: FacilityTableCell.identifier)
        tableView.register(HandicappedFacilityTableCell.self, forCellReuseIdentifier: HandicappedFacilityTableCell.identifier)
        tableView.register(MapTableCell.self, forCellReuseIdentifier: MapTableCell.identifier)
        return tableView
    }()
    
    let bottomView: HouseBottomView = {
        let view = HouseBottomView()
        return view
    }()
    let placeholderView = UIView()
    let indicator = NVActivityIndicatorView(frame: .zero)
    
    
    // MARK: - Properties
    let notiCenter = NotificationCenter.default
    let netWork = NetworkCommunicator()
    
    var plusData: HouseDetailData?
    var roomTitle = ""
    var roomID = 0
    var cellCountAfterDataRoad = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutolayout()
        addNotiObserver()
        setPlaceholderView()
        
        showIdicator()
        getPlusHouseServerData {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.tableView.reloadData()
//                self.setBottomViewData()
                UIView.animate(withDuration: 0.5, animations: {
                    self.placeholderView.alpha = 0
                    self.view.bringSubviewToFront(self.tableView)
                    self.view.bringSubviewToFront(self.bottomView)
                    self.tableView.alpha = 1
                    self.bottomView.alpha = 1
                })
                self.stopIndicator()
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
//        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    
    private func addNotiObserver() {
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .mapViewDidTapInHouseDetailView, object: nil)
    }
    
    @objc private func receiveNotification(_ sender: Notification) {
        guard let userInfo = sender.userInfo as? [String: CLLocationCoordinate2D],
            let coordinate = userInfo["coordinate"] else { return }
        
        let mapVC = MapViewController()
        
        mapVC.defaultLocation = coordinate
        mapVC.circleColor = StandardUIValue.shared.colorWine
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    private func configure() {
        view.backgroundColor = .white
        setHeaderView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerImageView
        view.addSubview(tableView)
        
        topView.delegate = self
        view.addSubview(topView)
        
        bottomView.reserveBtn.backgroundColor = StandardUIValue.shared.colorWine
        bottomView.starImageLabel.textColor = StandardUIValue.shared.colorWine
        view.addSubview(bottomView)
        
        tableView.alpha = 0
        bottomView.alpha = 0
    }
    
    private func setAutolayout() {
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.snp.height).multipliedBy(0.1)
        }
    }
    
    private func setHeaderView() {
        let headerWidth = UIScreen.main.bounds.width
        let headerHeight = UIScreen.main.bounds.height * 0.7
        headerImageView.frame = CGRect(x: 0, y: 0, width: headerWidth, height: headerHeight)
        if let url = URL(string: plusData?.image ?? "") {
            headerImageView.kf.setImage(with: url)
        }
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        button.setTitle("둘러보기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.titleLabel?.font = UIFont(name: StandardUIValue.shared.airbnbBoldFontString, size: 12)
        button.setTitleColor(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        headerImageView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.trailing.equalTo(-25)
            make.bottom.equalTo(-20)
            make.width.equalTo(120)
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
            make.top.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        let imageView = UIImageView()
        placeholderView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.7)
        }
        imageView.backgroundColor = placeholderColor
        
        let logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "plusLogo2")
        placeholderView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(StandardUIValue.shared.mainViewSideMargin)
            make.width.equalTo(90)
            make.height.equalTo(70)
        }
        
        let titleLabel = UILabel()
        let locationLabelHeight: CGFloat = "가".size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .semibold)]).height
        placeholderView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(StandardUIValue.shared.mainViewSideMargin)
            make.trailing.equalTo(-35)
            make.top.equalTo(logoImageView.snp.bottom).offset(15 + locationLabelHeight)
        }
        
        titleLabel.text = roomTitle
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
    }
    
    private func getPlusHouseServerData(completion: @escaping () -> () ) {
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
            
            self.plusData = result
            self.cellCountAfterDataRoad = 5
         
            DispatchQueue.main.async {
                if let url = URL(string: self.plusData?.image ?? "") {
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
        indicator.color = StandardUIValue.shared.colorWine
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

// MARK: - UITableViewDataSource

extension PlusViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCountAfterDataRoad
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let plusHouseData = plusData else { print("‼️ plusHouseData convert "); return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            let introCell = tableView.dequeueReusableCell(withIdentifier: PlusIntroTableCell.identifier, for: indexPath) as! PlusIntroTableCell
            introCell.setData(plusData: plusHouseData)
            return introCell
        case 1:
            let browsePhotosCell = tableView.dequeueReusableCell(withIdentifier: BrowsePhotosTableCell.identifier, for: indexPath) as! BrowsePhotosTableCell
            return browsePhotosCell
        case 2:
            let facilityCell = tableView.dequeueReusableCell(withIdentifier: FacilityTableCell.identifier, for: indexPath) as! FacilityTableCell
            return facilityCell
        case 3:
            let handicappedFacilityCell = tableView.dequeueReusableCell(withIdentifier: HandicappedFacilityTableCell.identifier, for: indexPath) as! HandicappedFacilityTableCell
            return handicappedFacilityCell
        case 4:
            let mapCell = tableView.dequeueReusableCell(withIdentifier: MapTableCell.identifier, for: indexPath) as! MapTableCell
            mapCell.hideSeparator()
            mapCell.setData(plusData: plusHouseData)
            return mapCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension PlusViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let becomeWhiteEndPoint = tableView.tableHeaderView!.frame.height - topView.frame.height
        let becomeWhiteStartPoint = becomeWhiteEndPoint - 70
        
        let opacity = ( scrollView.contentOffset.y - becomeWhiteStartPoint ) / (becomeWhiteEndPoint - becomeWhiteStartPoint)
        
        if scrollView.contentOffset.y > becomeWhiteStartPoint {
            navigationController?.view.backgroundColor = UIColor.white.withAlphaComponent(opacity)
            topView.backgroundColor = UIColor.white.withAlphaComponent(opacity)
            topView.backButton.setImage(UIImage(named: "backBlack"), for: .normal)
            topView.heartButton.setImage(UIImage(named: "heartBlack"), for: .normal)
            topView.shareButton.setImage(UIImage(named: "shareBlack"), for: .normal)
            
            navigationController?.navigationBar.barStyle = .default
            
        } else {
            navigationController?.view.backgroundColor = UIColor.white.withAlphaComponent(opacity)
            topView.backgroundColor = UIColor.white.withAlphaComponent(opacity)
            topView.backButton.setImage(UIImage(named: "backWhite"), for: .normal)
            topView.heartButton.setImage(UIImage(named: "heartWhite"), for: .normal)
            topView.shareButton.setImage(UIImage(named: "shareWhite"), for: .normal)
            
            navigationController?.navigationBar.barStyle = .blackTranslucent
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }
}

// MARK: - TableviewTopViewDelegate

extension PlusViewController: TableviewTopViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
