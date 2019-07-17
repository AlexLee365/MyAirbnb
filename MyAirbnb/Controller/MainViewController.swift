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
    let houseView = AccommodationView()
    
    // modify
    var mainView = MainView()
    
    let searchBarTableViewBackWhiteView = UIView()
    let searchBarTableView = SearchBarTableView()
    
    let testView = UIView()
    
    let notiCenter = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        
        setAutoLayout()
        configureViewsOptions()
        addNotificationObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideSearchBarTableView()
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
//        mainView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 110).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        view.addSubview(searchBarTableViewBackWhiteView)
        searchBarTableViewBackWhiteView.translatesAutoresizingMaskIntoConstraints = false
        searchBarTableViewBackWhiteView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: -40).isActive = true
        searchBarTableViewBackWhiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBarTableViewBackWhiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBarTableViewBackWhiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        searchBarTableViewBackWhiteView.addSubview(searchBarTableView)
        searchBarTableView.translatesAutoresizingMaskIntoConstraints = false
        searchBarTableView.topAnchor.constraint(equalTo: searchBarTableViewBackWhiteView.topAnchor).isActive = true
        searchBarTableView.leadingAnchor.constraint(equalTo: searchBarTableViewBackWhiteView.leadingAnchor).isActive = true
        searchBarTableView.trailingAnchor.constraint(equalTo: searchBarTableViewBackWhiteView.trailingAnchor).isActive = true
        searchBarTableView.bottomAnchor.constraint(equalTo: searchBarTableViewBackWhiteView.bottomAnchor).isActive = true
        
        view.sendSubviewToBack(searchBarTableViewBackWhiteView)
        
        
    }
    
    private func configureViewsOptions() {
        view.backgroundColor = .white
        

        testView.backgroundColor = .yellow
        testView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        searchBarTableView.alpha = 0
        searchBarTableViewBackWhiteView.backgroundColor = .white
        searchBarTableViewBackWhiteView.alpha = 0
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
            
            
            
            if let mainTableCell = mainView.mainTableView.cellForRow(at: IndexPath(row: 0, section: 0))
                as? MainCategoryTableCell {
                mainTableCell.delegate = self
            }
            setLayout = true
        }
    }
    
    private func addNotificationObserver() {
        notiCenter.addObserver(self, selector: #selector(receiveSearchEditBeginNotification(_:)), name: .searchBarEditBegin, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveSearchEditEndNotification(_:)), name: .searchBarEditEnd, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveSearchDateBtnTapNotification(_:)), name: .searchBarDateBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveSearchPeopleBtnTapNotification(_:)), name: .searchBarPeopleBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveSearchFilterBtnTapNotification(_:)), name: .searchBarFilterBtnDidTap, object: nil)
    }
    
    @objc func receiveSearchEditBeginNotification(_ sender: Notification) { // 수정 시작
        print("receiveSearchEditBeginNotification")
        showSearchBarTableView()
    }
    
    @objc func receiveSearchEditEndNotification(_ sender: Notification) {   // 수정 종료
        print("receiveSearchEditEndNotification")
        hideSearchBarTableView()
    }
    
   
    
    @objc func receiveSearchDateBtnTapNotification(_ sender: Notification) {
        print("receiveSearchDateBtnTapNotification")
        let calendarVC = CalenderViewController()
        calendarVC.modalPresentationStyle = .overFullScreen
//        calendarVC.modalPresentationStyle = .overCurrentContext
        
        if searchBarView.selectedDatesArray.count > 0 {
            calendarVC.beginDatesArray = searchBarView.selectedDatesArray
        }

        present(calendarVC, animated: false)
    }
    
    @objc func receiveSearchPeopleBtnTapNotification(_ sender: Notification) {
        print("receiveSearchPeopleBtnTapNotification")
        let filterPeopleVC = FilterPeopleViewController()
        filterPeopleVC.selectedPeople = searchBarView.selectedPeople
        
        filterPeopleVC.modalPresentationStyle = .overFullScreen
        present(filterPeopleVC, animated: false)
    }
    
    @objc func receiveSearchFilterBtnTapNotification(_ sender: Notification) {
        print("receiveSearchFilterBtnTapNotification")
        
    }
    
    private func showSearchBarTableView() {
        view.bringSubviewToFront(searchBarTableViewBackWhiteView)
        self.searchBarTableViewBackWhiteView.alpha = 1
        
        UIView.animate(withDuration: 0.3) {
            self.searchBarTableView.alpha = 1
        }
    }
    private func hideSearchBarTableView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.searchBarTableView.alpha = 0
        }) { (_) in
            self.searchBarTableViewBackWhiteView.alpha = 0
            self.view.sendSubviewToBack(self.searchBarTableViewBackWhiteView)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print("touchesEnd")
        
        let location = touches.first!.location(in: searchBarTableView)
        print(location)
        
        if searchBarTableView.frame.contains(location) {
            searchBarView.searchTF.resignFirstResponder()
        }
    }
    
}


extension MainViewController: MainCategoryTableCellDelegate {
    func pushView() {
        let houseVC = HouseViewController()
        navigationController?.pushViewController(houseVC, animated: false)
    }
}



