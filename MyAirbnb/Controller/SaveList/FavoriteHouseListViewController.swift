//
//  FavoriteHouseListViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class FavoriteHouseListViewController: UIViewController {

    let mainTableView = FavoriteHouseListView()
    var favoriteDataArray = [FavoriteData]()
    
    let notiCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupConfigure()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setupLayout() {
        
        let guide = view.safeAreaLayoutGuide
        
        view.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupConfigure() {
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .moveToFavoriteHouseDetailVC, object: nil)
    }
    
    @objc func receiveNotification(_ sender: Notification) {
        print("receive Noti")
        let favoriteDetailVC = FavoriteHouseDetailViewController()
        navigationController?.pushViewController(favoriteDetailVC, animated: true)
    }
}
