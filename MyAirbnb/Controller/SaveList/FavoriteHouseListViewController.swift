//
//  FavoriteHouseListViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class FavoriteHouseListViewController: UIViewController {
    
    //    let mainTableView = FavoriteHouseListView()
    let favoriteTableView = UITableView()
    
    let notiCenter = NotificationCenter.default
    let netWork = NetworkCommunicator()
    
    var wishListArray = [WishList]()
    var cellNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureViewsOptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let urlString = netWork.basicUrlString + "/wishlists/"
        netWork.getServerDataWithToken(urlString: urlString) { (result) in
            switch result {
            case .success(let value):
                guard let wishlist = try? JSONDecoder().decode([WishList].self, from: value) else{ print("‼️ WishList JSON decoding error "); return }
                print("🔵🔵🔵 WishList Data: ", wishlist)
                self.wishListArray = wishlist
                self.cellNumber = wishlist.count + 1
                
                DispatchQueue.main.async {
                    self.favoriteTableView.reloadData()
                }
            case .failure(let error):
                print("‼️ FavoriteHouseListVC WishList get Method Failed: ", error.localizedDescription)
            }
        }
    }
    
    private func setupLayout() {
        let guide = view.safeAreaLayoutGuide
        
        view.addSubview(favoriteTableView)
        favoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        favoriteTableView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
        favoriteTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0).isActive = true
        favoriteTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0).isActive = true
        favoriteTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0).isActive = true
        favoriteTableView.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
    }
    
    private func configureViewsOptions() {
        navigationController?.navigationBar.isHidden = true
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
        favoriteTableView.register(OnePhotoCell.self, forCellReuseIdentifier: OnePhotoCell.identifier)
        favoriteTableView.register(ThreePhotoCell.self, forCellReuseIdentifier: ThreePhotoCell.identifier)
        favoriteTableView.contentInsetAdjustmentBehavior = .never
        favoriteTableView.rowHeight = UITableView.automaticDimension
    }
}

extension FavoriteHouseListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let titleTextCell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: indexPath) as! TitleCell
            return titleTextCell
            
        case 1...:
            let onePhotoCell = tableView.dequeueReusableCell(withIdentifier: OnePhotoCell.identifier, for: indexPath) as! OnePhotoCell
            onePhotoCell.setData(wishlist: wishListArray[indexPath.row - 1])
            
            return onePhotoCell
        default : break
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteDetailVC = FavoriteHouseDetailViewController()
        favoriteDetailVC.wishListID = wishListArray[indexPath.row - 1].id
        navigationController?.pushViewController(favoriteDetailVC, animated: true)
    }
    
    
}
