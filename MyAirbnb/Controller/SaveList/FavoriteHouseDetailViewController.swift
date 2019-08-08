//
//  FavoriteHouseDetailViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/08.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class FavoriteHouseDetailViewController: UIViewController {

    let topView: TableviewTopView = {
        let view = TableviewTopView()
        view.backgroundColor = .white
        view.backButton.setImage(UIImage(named: "backBlack"), for: .normal)
        view.shareButton.isHidden = true
        view.heartButton.isHidden = true
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        view.layer.shadowRadius = 0
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(SaveDetailTitleTableCell.self, forCellReuseIdentifier: SaveDetailTitleTableCell.identifier)
        tableView.register(NoOfLikeListTableCell.self, forCellReuseIdentifier: NoOfLikeListTableCell.identifier)
        tableView.register(LikeListTableCell.self, forCellReuseIdentifier: LikeListTableCell.identifier)
        
        return tableView
    }()
    
    let netWork = NetworkCommunicator()
    
    var wishListID = 0
    var cellCount = 0
    var wishListDetailData: WishListDetail?
    var roomsVaildArray = [RoomsValid]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutolayout()
        print("🔴🔴🔴 id: ", wishListID)
        
        let urlString = netWork.basicUrlString + "/wishlists/\(wishListID)/"
        netWork.getServerDataWithToken(urlString: urlString) { (result) in
            switch result {
            case .success(let value):
                guard let wishDetail = try? JSONDecoder().decode(WishListDetail.self, from: value) else{ print("‼️ wishListDetail decoding error "); return }
                self.wishListDetailData = wishDetail
                self.roomsVaildArray = wishDetail.roomsValid
                self.cellCount = 2 + self.roomsVaildArray.count
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print("‼️ wishListDetail Data server failed: ", error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Properties
    
    private func configure() {
        topView.delegate = self
        view.addSubview(topView)
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification(_:)), name: .moveToHouseDetailVCFromFavoriteList, object: nil)
    }
    
    private func setAutolayout() {
        view.backgroundColor = .white
        
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func receiveNotification(_ sender: Notification) {
        guard let userInfo = sender.userInfo as? [String: Any]
            , let roomID = userInfo["roomID"] as? Int
            , let type = userInfo["type"] as? String
            , let name = userInfo["houseName"] as? String
            else { print("moveToHouseDetailViewFromFavoriteList noti error"); return }
        
        let houseDetailVC = HouseDetailViewController()
        houseDetailVC.roomID = roomID
        houseDetailVC.nameLabelPlaceholder = name
        houseDetailVC.typeLablePlaceholder = type
        navigationController?.pushViewController(houseDetailVC, animated: true)
    }
}


// MARK: - TableviewTopViewDelegate
extension FavoriteHouseDetailViewController: TableviewTopViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: - UITableViewDataSource
extension FavoriteHouseDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let titleCell = tableView.dequeueReusableCell(withIdentifier: SaveDetailTitleTableCell.identifier, for: indexPath) as! SaveDetailTitleTableCell
            titleCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            titleCell.setData(state: wishListDetailData?.title ?? "", guestNum: wishListDetailData?.guestNumber ?? 0)
            
            return titleCell
        
        case 1:
            let noOfLikeListCell = tableView.dequeueReusableCell(withIdentifier: NoOfLikeListTableCell.identifier, for: indexPath) as! NoOfLikeListTableCell
            noOfLikeListCell.setData(availableReservationCount: roomsVaildArray.count)
            
            return noOfLikeListCell
            
        default:
            let likeListCell = tableView.dequeueReusableCell(withIdentifier: LikeListTableCell.identifier, for: indexPath) as! LikeListTableCell
            likeListCell.setData(wishListData: roomsVaildArray[indexPath.row - 2])
            likeListCell.wishListDetailData = roomsVaildArray[indexPath.row - 2]
            
            return likeListCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 2 {
            let houseDetailVC = HouseDetailViewController()
            houseDetailVC.roomID = roomsVaildArray[indexPath.row - 2].id
            houseDetailVC.nameLabelPlaceholder = roomsVaildArray[indexPath.row - 2].title
            houseDetailVC.typeLablePlaceholder = roomsVaildArray[indexPath.row - 2].roomType
            navigationController?.pushViewController(houseDetailVC, animated: true)
        }
    }
}
