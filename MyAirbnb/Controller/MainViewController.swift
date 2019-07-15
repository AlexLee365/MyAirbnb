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
//        searchBarView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 5).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func configureViewsOptions() {
        view.backgroundColor = .white
        
        searchBarView.delegate = self
    }
    
    var setLayout = false
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if setLayout == false {
            print("MainViewController ViewDidLayoutSubviews")
            let tabbarHeight = self.tabBarController!.tabBar.frame.height
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabbarHeight).isActive = true
            
//            if let mainTableCell = mainView.mainTableView.cellForRow(at: IndexPath(row: 0, section: 0))
//                as? MainCategoryTableCell {
//                mainTableCell.delegate = self
//            }
            
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

extension MainViewController: CalendarDelegate {
    func presentCalenderVC() {
        print("presentCalendarVC")
        
        let calendarVC = CalenderViewController()
        calendarVC.modalPresentationStyle = .overCurrentContext
        if searchBarView.selectedDatesArray.count > 0 {
            calendarVC.beginDatesArray = searchBarView.selectedDatesArray
        }
        
        present(calendarVC, animated: false)
        
    }
}


