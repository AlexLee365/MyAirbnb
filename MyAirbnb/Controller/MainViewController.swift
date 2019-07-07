//
//  MainViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 06/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let searchBarView = SearchBarView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAutoLayout()
        configureViewsOptions()
    }
    
    private func setAutoLayout() {
        let safeGuide = view.safeAreaLayoutGuide
     
        
        view.addSubview(searchBarView)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 0).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        searchBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    private func configureViewsOptions() {
        view.backgroundColor = .white

    }
    
  
    
  
}


