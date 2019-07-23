//
//  HouseDetailViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 17/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import MapKit

class HouseDetailViewController: UIViewController {
    
    let tableView = UITableView()
    
    let notiCenter = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()

        setAutoLayout()
        configureViewsOptions()
        addNotificationObserver()
    }
    
    private func setAutoLayout() {
        let safeGuide = view.safeAreaLayoutGuide
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
    }
    
    private func configureViewsOptions() {
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
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: StandardUIValue.shared.mainViewSideMargin, bottom: 0, right: StandardUIValue.shared.mainViewSideMargin)
        
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
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
        navigationController?.pushViewController(mapVC, animated: true)
    }


}

extension HouseDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let houseDetailPicturesTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailPicturesTableCell.identifier, for: indexPath) as! HouseDetailPicturesTableCell
            
            return houseDetailPicturesTableCell
        case 1:
            let houseDetailBasicInfoTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailBasicInfoTableCell.identifier, for: indexPath) as! HouseDetailBasicInfoTableCell
            
            return houseDetailBasicInfoTableCell
        case 2:
            let houseDetailIntroductionTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailIntroductionTableCell.identifier, for: indexPath) as! HouseDetailIntroductionTableCell
            
            return houseDetailIntroductionTableCell
        case 3:
            let houseDetailBedroomsTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailBedroomsTableCell.identifier, for: indexPath) as! HouseDetailBedroomsTableCell
            
            return houseDetailBedroomsTableCell
            
        case 4:
            let houseDetailStayingDaysTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailStayingDaysTableCell.identifier, for: indexPath) as! HouseDetailStayingDaysTableCell
            
            return houseDetailStayingDaysTableCell
        case 5:
            let houseDetailFacilityTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailFacilityTableCell.identifier, for: indexPath) as! HouseDetailFacilityTableCell
            
            return houseDetailFacilityTableCell
        case 6:
            let houseDetailLocationTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailLocationTableCell.identifier, for: indexPath) as! HouseDetailLocationTableCell
            
            return houseDetailLocationTableCell
        case 7:
            let houseDetailCheckInTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailCheckInTableCell.identifier, for: indexPath) as! HouseDetailCheckInTableCell
            
            return houseDetailCheckInTableCell
        default : break
        }
        
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 1 {
//            return 800
//        }
//        return UITableView.automaticDimension
//    }
    
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
