//
//  MainViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 06/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import Kingfisher

class MainViewController: UIViewController {
    
    // MARK: - UI Properties
    let searchBarView = SearchBarView()
    let searchBarTableViewBackWhiteView = UIView()
    let searchBarTableView = SearchBarTableView()
    
    var mainView = MainView()
    
    let indicatorView = UIView()
    let indicator = NVActivityIndicatorView(frame: .zero)
    
    // MARK: - Properties
    let jsonDecoder = JSONDecoder()
    let notiCenter = NotificationCenter.default
    let netWork = NetworkCommunicator()
    let kingfisher = ImageDownloader.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAutoLayout()
        configureViewsOptions()
        addNotificationObserver()
        makeIndicatorView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        searchBarView.useCase = .inMainVC
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBarView.searchTF.resignFirstResponder()
        searchBarView.searchTF.text = ""
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideSearchBarTableView()
        stopIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
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
        mainView.topAnchor.constraint(equalTo: searchBarView.filterStackView.bottomAnchor, constant: 5).isActive = true
        //        mainView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 110).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: 0).isActive = true
        
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
        
        view.bringSubviewToFront(searchBarView)
        view.sendSubviewToBack(searchBarTableViewBackWhiteView)
    }
    
    private func configureViewsOptions() {
        view.backgroundColor = .white
        
        searchBarTableView.alpha = 0
        searchBarTableViewBackWhiteView.backgroundColor = .white
        searchBarTableViewBackWhiteView.alpha = 0
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
        
    }
    
    private func makeIndicatorView() {
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBarView.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        indicatorView.backgroundColor = .white
        view.sendSubviewToBack(indicatorView)
        
        let centerX = UIScreen.main.bounds.width/2
        let centerY = UIScreen.main.bounds.height/2
        indicatorView.addSubview(indicator)
        indicator.frame = CGRect(x: centerX-15, y: centerY-300, width: 30, height: 30)
        indicator.type = .ballBeat
        indicator.color = StandardUIValue.shared.colorBlueGreen
    }
    
    private func startIndicator() {
        view.bringSubviewToFront(indicatorView)
        indicator.startAnimating()
    }
    
    private func stopIndicator() {
        view.sendSubviewToBack(indicatorView)
        indicator.stopAnimating()
    }
}

//Notification
extension MainViewController {
    private func addNotificationObserver() {
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarEditBegin, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarEditEnd, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarEditingChanged, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarEnterPressed, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarTableViewScrolled, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarTableCellSelected, object: nil)
        
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarDateBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarDateResultBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarPeopleBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarPeopleResultBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarFilterBtnDidTap, object: nil)
        
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .moveToHouseView, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .moveToHouseDetailView, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .moveToPlusHouseDetailView, object: nil)
    }
    
    @objc func receiveNotification(_ sender: Notification) {
        switch sender.name {
            
        // SearchBar Notification
        case Notification.Name.searchBarEditBegin:
            showSearchBarTableView()
            guard let text = sender.object as? String else { print("‼️ MainVC edit begin noti"); return }
            if text == "" {
                self.searchBarTableView.searchResult = SingletonCommonData.shared.stateArray
            }
            
        case Notification.Name.searchBarEditEnd:
            hideSearchBarTableView()
            
        case Notification.Name.searchBarEditingChanged:     // 써치바 타이핑중
            guard let text = sender.object as? String else { print("‼️ MainVC editing noti"); return }
            
            let stateArray = SingletonCommonData.shared.stateArray
            guard text != "" else {
                self.searchBarTableView.searchResult = stateArray
                return
            }
            var tempArray = [String]()
            tempArray = stateArray.filter{ $0.contains(text) || $0.lowercased().contains(text) }
            
            self.searchBarTableView.searchResult = tempArray
            
        case Notification.Name.searchBarEnterPressed:       // 검색어 검색 엔터
            startIndicator()
            guard let userInfo = sender.userInfo
                , let textResult = userInfo["result"] as? String else {
                    print("‼️ MainVC serachbar enter noti userinfo ")
                    return
            }
            
            let urlString = netWork.basicUrlString
                + "/rooms/?search=\(textResult)&ordering=total_rating&page_size=5&page=1"
            
            netWork.getHouseServerData(urlString: urlString) { (houseDateArray, success) in
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    let houseVC = HouseViewController()
                    switch success {
                    case true:
                        guard let houseDateArray = houseDateArray else { return }
                        let houseviewDataNormal = HouseViewData(data: houseDateArray, cellStyle: .normalHouse)
                        houseVC.houseView.houseViewDatas = self.setHouseDatasWhenResultExist()
                        houseVC.houseView.houseViewDatas.append(houseviewDataNormal)
                    case false:
                        houseVC.houseView.houseViewDatas = self.setHouseDatasWithNoResult()
                    }
                    houseVC.searchWord = textResult
                    self.navigationController?.pushViewController(houseVC, animated: false)
                }
            }
            
        case Notification.Name.searchBarTableViewScrolled:
            searchBarView.searchTF.resignFirstResponder()

        case Notification.Name.searchBarTableCellSelected:
            guard let state = sender.object as? String else { return }
            startIndicator()
            hideSearchBarTableView()
            
            let urlString = netWork.basicUrlString
                + "/rooms/?search=\(state)&ordering=total_rating&page_size=5&page=1"
            
            netWork.getHouseServerData(urlString: urlString) { (houseDateArray, success) in
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    let houseVC = HouseViewController()
                    switch success {
                    case true:
                        guard let houseDateArray = houseDateArray else { return }
                        let houseviewDataNormal = HouseViewData(data: houseDateArray, cellStyle: .normalHouse)
                        houseVC.houseView.houseViewDatas = self.setHouseDatasWhenResultExist()
                        houseVC.houseView.houseViewDatas.append(houseviewDataNormal)
                    case false:
                        houseVC.houseView.houseViewDatas = self.setHouseDatasWithNoResult()
                    }
                    houseVC.searchWord = state
                    self.navigationController?.pushViewController(houseVC, animated: false)
                }
            }
            
        case Notification.Name.searchBarDateBtnDidTap:          // 날짜 설정버튼
            let calendarVC = CalenderViewController()
            calendarVC.modalPresentationStyle = .overFullScreen
            //        calendarVC.modalPresentationStyle = .overCurrentContext
            
            if searchBarView.selectedDatesArray.count > 0 {
                calendarVC.beginDatesArray = searchBarView.selectedDatesArray
            }
            
            present(calendarVC, animated: false)
            
        case Notification.Name.searchBarDateResultBtnDidTap:    // 날짜 검색버튼 클릭
            print("🔴🔴🔴 : ")
            guard let userInfo = sender.userInfo
                , let houseDataArray = userInfo["houseViewDataArray"] as? [HouseViewData] else {
                    print("‼️ MainVC SearchBar resultBtn noti userinfo ")
                    return
            }
            
            let houseVC = HouseViewController()
            houseVC.houseView.houseViewDatas = houseDataArray
            houseVC.searchBarView.selectedDatesArray = searchBarView.selectedDatesArray
            houseVC.searchBarView.selectedDateString = searchBarView.selectedDateString
            self.navigationController?.pushViewController(houseVC, animated: false)
            
        case Notification.Name.searchBarPeopleBtnDidTap:        // 인원 설정버튼
            let filterPeopleVC = FilterPeopleViewController()
            filterPeopleVC.selectedPeople = searchBarView.selectedPeople
            
            filterPeopleVC.modalPresentationStyle = .overFullScreen
            present(filterPeopleVC, animated: false)
            
        case Notification.Name.searchBarPeopleResultBtnDidTap:      // 인원 검색버튼 클릭
            guard let userInfo = sender.userInfo
                , let houseDataArray = userInfo["houseViewDataArray"] as? [HouseViewData] else {
                    print("‼️ MainVC SearchBar resultBtn noti userinfo ")
                    return
            }
            
            let houseVC = HouseViewController()
            houseVC.houseView.houseViewDatas = houseDataArray
            houseVC.searchBarView.selectedPeople = searchBarView.selectedPeople
            self.navigationController?.pushViewController(houseVC, animated: false)
            
        case Notification.Name.searchBarFilterBtnDidTap:
            let filterRemainsVC = FilterRemainsViewController()
            filterRemainsVC.isDateSelected = (searchBarView.selectedDateString == "날짜") ? false : true
            present(filterRemainsVC, animated: true)
            
            
        // Push other views Notification
        case Notification.Name.moveToHouseView:
            startIndicator()
            let urlString = netWork.basicUrlString
                + "/rooms/?search=seoul&ordering=price&page_size=5&page=1"
            
            netWork.getHouseServerData(urlString: urlString) { (housedataArray, success) in
                guard let housedataArray = housedataArray else { return }
                let houseviewDataNormal = HouseViewData(data: housedataArray, cellStyle: .normalHouse)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    let houseVC = HouseViewController()
                    houseVC.houseView.houseViewDatas = self.setHouseDatasWithLuxePlusData()
                    houseVC.houseView.houseViewDatas.append(houseviewDataNormal)
                    self.navigationController?.pushViewController(houseVC, animated: false)
                }
            }
            
            
        case Notification.Name.moveToHouseDetailView:
            guard let userInfo = sender.userInfo as? [String: Any]
                , let roomID = userInfo["roomID"] as? Int
                , let type = userInfo["type"] as? String
                , let name = userInfo["houseName"] as? String
                else { print("moveToHouseDetailView noti error"); return }
            
            let houseDetailVC = HouseDetailViewController()
            houseDetailVC.roomID = roomID
            houseDetailVC.nameLabelPlaceholder = name
            houseDetailVC.typeLablePlaceholder = type
            houseDetailVC.isDateSelected = (searchBarView.selectedDatesArray.count == 0) ? false : true
            self.navigationController?.pushViewController(houseDetailVC, animated: false)
            
        case Notification.Name.moveToPlusHouseDetailView:
            let plusHouseVC = PlusViewController()
            navigationController?.pushViewController(plusHouseVC, animated: true)
            
        default : break
        }
    }
}

// HouseDatas Setting
extension MainViewController {
    private func setHouseDatasWhenResultExist() -> [HouseViewData] {
        let houseviewDataIntroLabel = HouseViewData(
            data: [HouseIntroLabelDataInList(intro: "여행 날짜와 게스트 인원수를 입력하면 1박당 총 요금을 확인할 수 있습니다. 관광세가 추가로 부과될 수 있습니다.")],
            cellStyle: .introLabel)
        
        let houseviewDataTitleLabel = HouseViewData(
            data: [HouseTitleLabelDataInList(title: "300개 이상의 숙소 모두 둘러보기")], cellStyle: .titleLabel)
        
        return [houseviewDataIntroLabel, houseviewDataTitleLabel]
    }
    
    private func setHouseDatasWithNoResult() -> [HouseViewData]{
        let houseviewDataIntroLabel = HouseViewData(
            data: [HouseIntroLabelDataInList(intro: "숙소 결과가 없습니다.")],
            cellStyle: .introLabel)
        return [houseviewDataIntroLabel]
    }
    
    private func setHouseDatasWithLuxePlusData() -> [HouseViewData] {
        
        let luxeData = mainView.mainViewDatas.filter{$0.cellStyle == .luxe}.map{$0.data as! [HouseLuxeDataInList]}.first ?? []
        let plusData = mainView.mainViewDatas.filter{$0.cellStyle == .plus}.map{$0.data as! [HousePlusDataInList]}.first ?? []
        
        let houseviewDataIntroLabel = HouseViewData(
            data: [HouseIntroLabelDataInList(intro: "여행 날짜와 게스트 인원수를 입력하면 1박당 총 요금을 확인할 수 있습니다. 관광세가 추가로 부과될 수 있습니다.")],
            cellStyle: .introLabel)
        let houseviewDataLuxe = HouseViewData(data: luxeData, cellStyle: .luxe)
        let houseviewDataPlus = HouseViewData(data: plusData, cellStyle: .plus)
        let houseviewDataTitleLabel = HouseViewData(
            data: [HouseTitleLabelDataInList(title: "300개 이상의 숙소 모두 둘러보기")], cellStyle: .titleLabel)
        
        return [houseviewDataIntroLabel, houseviewDataLuxe, houseviewDataPlus, houseviewDataTitleLabel]
    }
}

