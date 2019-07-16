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
    
    let houseView = AccommodationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        view.addSubview(searchBarView)
        
        view.addSubview(houseView)
    }
    
    private func setAutolayout() {
        let safeGuide = view.safeAreaLayoutGuide
        
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 0).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        searchBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        houseView.translatesAutoresizingMaskIntoConstraints = false
        houseView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 5).isActive = true
        houseView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        houseView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    var setLayout = false
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if setLayout == false {
            let tabbarHeight = self.tabBarController!.tabBar.frame.height
            houseView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabbarHeight).isActive = true
            
            setLayout = true
        }
    }
}
