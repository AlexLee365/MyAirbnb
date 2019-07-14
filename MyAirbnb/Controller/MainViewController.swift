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
    let mainView = MainView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setAutoLayout()
        configureViewsOptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setAutoLayout() {
        let safeGuide = view.safeAreaLayoutGuide
        
        view.addSubview(searchBarView)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 0).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        searchBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 5).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func configureViewsOptions() {
        view.backgroundColor = .white
        
    }
    
    var setLayout = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if setLayout == false {
            let tabbarHeight = self.tabBarController!.tabBar.frame.height
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabbarHeight).isActive = true
            
            guard let mainTableCell = mainView.mainTableView.cellForRow(at: IndexPath(row: 0, section: 0))
                as? MainCategoryTableCell else { return }
            mainTableCell.delegate = self

            setLayout = true
        }
    }
}


extension MainViewController: MainCategoryTableCellDelegate {
    func pushView() {
        let houseVC = HouseViewController()
        navigationController?.pushViewController(houseVC, animated: false)
    }
}


