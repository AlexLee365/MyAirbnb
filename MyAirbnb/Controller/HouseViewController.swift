//
//  HouseViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 14/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseViewController: UIViewController {
    
    let searchBarView: SearchBarView = {
        let searchBarView = SearchBarView()
        searchBarView.searchImageBtn.setImage(UIImage(named: "back32"), for: .normal)
        return searchBarView
    }()
    
    let houseView = HouseView()
    
    let notiCenter = NotificationCenter.default
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configure()
        setAutolayout()
        addNotificationObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        if setLayout == false {
//            let tabbarHeight = self.tabBarController!.tabBar.frame.height
//            houseView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabbarHeight).isActive = true
//
//            setLayout = true
//        }
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        view.addSubview(searchBarView)
        
        view.addSubview(houseView)
        
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    var setLayout = false
    private func setAutolayout() {
        let safeGuide = view.safeAreaLayoutGuide
        
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 0).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        
        houseView.translatesAutoresizingMaskIntoConstraints = false
        houseView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 5).isActive = true
        houseView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        houseView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        houseView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
    }
    
    private func addNotificationObserver() {
//        notiCenter.addObserver(self, selector: #selector(receiveNotificationMoveToHouseDetailVC(_:)), name: .moveToHouseDetailView, object: nil)
    }
    
    
    
    @objc func receiveNotificationMoveToHouseDetailVC(_ sender: Notification) {
        let houseDetailVC = HouseDetailViewController()
        navigationController?.pushViewController(houseDetailVC, animated: true)
    }
    
    
    
   
}
