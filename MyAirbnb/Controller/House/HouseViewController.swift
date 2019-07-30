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
        searchBarView.searchImageBtn.setImage(UIImage(named: "back33"), for: .normal)
        return searchBarView
    }()
    
    let houseView = HouseView()
    
    let notiCenter = NotificationCenter.default
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewsOptions()
        setAutolayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        searchBarView.useCase = .inHouseVC
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    var setLayout = false
    private func setAutolayout() {
        let safeGuide = view.safeAreaLayoutGuide
        
        view.addSubview(searchBarView)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 0).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        
        view.addSubview(houseView)
        houseView.translatesAutoresizingMaskIntoConstraints = false
        houseView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 5).isActive = true
        houseView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        houseView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        houseView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
    }
    
    private func configureViewsOptions() {
        view.backgroundColor = .white
        
        searchBarView.searchTF.text = "숙소"
        
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        searchBarView.searchImageBtn.addTarget(self, action: #selector(searchImageBtnDidTap), for: .touchUpInside)
    }
    
    @objc func searchImageBtnDidTap() {
        navigationController?.popViewController(animated: false)
    }
    
}
