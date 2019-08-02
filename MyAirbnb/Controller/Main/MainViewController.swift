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
        searchBarView.inController = self
        searchBarTableView.useCase = .inMainVC
        searchBarTableView.inController = self
        
        print("🔸🔸🔸 inset: ", SingletonCommonData.shared.deviceSafeAreaInset)
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
    
    var safeAreaInsetFlag = false
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        guard safeAreaInsetFlag == false else { return }
        print("--------------------------[safeArea]--------------------------")
        SingletonCommonData.shared.deviceSafeAreaInset = view.safeAreaInsets        // 기기 SafeAreaInset을 수치로 저장 및 활용
        safeAreaInsetFlag = true
        print("🔸🔸🔸 didChange Inset: ", SingletonCommonData.shared.deviceSafeAreaInset)
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
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -SingletonCommonData.shared.deviceSafeAreaInset.bottom).isActive = true
        
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
        // 서치바 검색 시작
        case Notification.Name.searchBarEditBegin:
            
            guard let text = sender.object as? String
                , let userInfo = sender.userInfo
                , let useCase = userInfo[SingletonCommonData.notiKeySearchBarUseCase] as? UseCase
                , let controller = userInfo[SingletonCommonData.notiKeySearchBarInController] as? UIViewController else {
                    print("‼️ MainVC edit begin noti")
                    return
            }
            
            switch useCase {
            case .inMainVC:
                showSearchBarTableView()
                if text == "" {
                    self.searchBarTableView.searchResult = SingletonCommonData.shared.stateArray
                }
            case .inHouseVC:
                guard let houseVC = controller as? HouseViewController else { print("‼️ : "); return }
                houseVC.showSearchBarTableView()
                if text == "" {
                    houseVC.searchBarTableView.searchResult = SingletonCommonData.shared.stateArray
                }
            case .inTripVC:
                ()
            }
            
        // 서치바 검색 종료 (취소버튼 클릭시)
        case Notification.Name.searchBarEditEnd:
            guard let userInfo = sender.userInfo
                , let useCase = userInfo[SingletonCommonData.notiKeySearchBarUseCase] as? UseCase
                , let controller = userInfo[SingletonCommonData.notiKeySearchBarInController] as? UIViewController else {
                    print("‼️ MainVC serachbarEditEnd noti userinfo ")
                    return
            }
            switch useCase {
            case .inMainVC:
                hideSearchBarTableView()
            case .inHouseVC:
                guard let houseVC = controller as? HouseViewController else { print("‼️ : "); return }
                houseVC.hideSearchBarTableView()
            case .inTripVC:
                ()
            }
            
            
        case Notification.Name.searchBarEditingChanged:     // 써치바 타이핑중
            guard let text = sender.object as? String
                , let userInfo = sender.userInfo
                , let useCase = userInfo[SingletonCommonData.notiKeySearchBarUseCase] as? UseCase
                , let controller = userInfo[SingletonCommonData.notiKeySearchBarInController] as? UIViewController else {
                    print("‼️ MainVC editing noti")
                    return
            }
            
            let stateArray = SingletonCommonData.shared.stateArray
            switch useCase {
            case .inMainVC:
                guard text != "" else {
                    self.searchBarTableView.searchResult = stateArray
                    return
                }
                var tempArray = [String]()
                tempArray = stateArray.filter{ $0.contains(text) || $0.lowercased().contains(text) }
                
                self.searchBarTableView.searchResult = tempArray
            case .inHouseVC:
                guard let houseVC = controller as? HouseViewController else { print("‼️ : "); return }
                guard text != "" else {
                    houseVC.searchBarTableView.searchResult = stateArray
                    return
                }
                var tempArray = [String]()
                tempArray = stateArray.filter{ $0.contains(text) || $0.lowercased().contains(text) }
                
                houseVC.searchBarTableView.searchResult = tempArray
            case .inTripVC:
                ()
            }
            
           
        // 서치바 검색어 검색 엔터
        case Notification.Name.searchBarEnterPressed:
            guard let userInfo = sender.userInfo
                , let textResult = userInfo["result"] as? String
                , let useCase = userInfo[SingletonCommonData.notiKeySearchBarUseCase] as? UseCase
                , let controller = userInfo[SingletonCommonData.notiKeySearchBarInController] as? UIViewController else {
                    print("‼️ MainVC serachbar enter noti userinfo ")
                    return
            }
            
            switch useCase {
            case .inMainVC:
                startIndicator()
                guard let mainVC = controller as? MainViewController else { print("‼️ searchBarEnterPressed noti mainVC "); return}
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
//                        self.navigationController?.pushViewController(houseVC, animated: false)
                        mainVC.navigationController?.pushViewController(houseVC, animated: false)
                    }
                }
            case .inHouseVC:
                guard let houseVC = controller as? HouseViewController else { print("‼️ searchBarEnterPressed noti mainVC "); return}
                houseVC.hideSearchBarTableView()
                houseVC.startIndicator()
                
                let urlString = netWork.basicUrlString
                    + "/rooms/?search=\(textResult)&ordering=total_rating&page_size=5&page=1"
                
                netWork.getHouseServerData(urlString: urlString) { (houseDateArray, success) in
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        houseVC.houseView.houseViewDatas.removeAll()
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
                        houseVC.houseView.flag = false
                        houseVC.houseView.tableView.reloadData()
                        houseVC.stopIndicator()                        
                    }
                }
            case .inTripVC:
                ()
            }
            
            
        // 서치 테이블뷰 스크롤시
        case Notification.Name.searchBarTableViewScrolled:
            guard let userInfo = sender.userInfo
                , let useCase = userInfo[SingletonCommonData.notiKeySearchBarUseCase] as? UseCase
                , let controller = userInfo[SingletonCommonData.notiKeySearchBarInController] as? UIViewController else {
                    print("‼️ MainVC serachbar enter noti userinfo ")
                    return
            }
            switch useCase {
            case .inMainVC:
                searchBarView.searchTF.resignFirstResponder()
            case .inHouseVC:
                guard let houseVC = controller as? HouseViewController else { print("‼️ : "); return }
                houseVC.searchBarView.searchTF.resignFirstResponder()
            case .inTripVC:
                ()
            }

        // 서치 테이블뷰 검색 결과 셀 선택
        case Notification.Name.searchBarTableCellSelected:
            guard let state = sender.object as? String
                , let userInfo = sender.userInfo
                , let useCase = userInfo[SingletonCommonData.notiKeySearchBarUseCase] as? UseCase
                , let controller = userInfo[SingletonCommonData.notiKeySearchBarInController] as? UIViewController else {
                    print("‼️ : ")
                    return
            }
            
            switch useCase {
            case .inMainVC:
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
            case .inHouseVC:
                guard let houseVC = controller as? HouseViewController else { print("‼️ : "); return }
                houseVC.hideSearchBarTableView()
                houseVC.startIndicator()
                
                let urlString = netWork.basicUrlString
                    + "/rooms/?search=\(state)&ordering=total_rating&page_size=5&page=1"
                
                netWork.getHouseServerData(urlString: urlString) { (houseDateArray, success) in
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        houseVC.houseView.houseViewDatas.removeAll()
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
                        houseVC.houseView.flag = false
                        houseVC.houseView.tableView.reloadData()
                        houseVC.searchBarView.searchTF.resignFirstResponder()
                        houseVC.stopIndicator()
                        houseVC.searchBarView.textEditEndAnimation()
                    }
                }
                
            case .inTripVC:
                ()
            }
            
            
        // 날짜 설정버튼
        case Notification.Name.searchBarDateBtnDidTap:
            guard let userInfo = sender.userInfo
                , let useCase = userInfo[SingletonCommonData.notiKeySearchBarUseCase] as? UseCase
                , let controller = userInfo[SingletonCommonData.notiKeySearchBarInController] as? UIViewController else {
                    print("‼️ searchBar DateBtn did tap noti ")
                    return
            }
            
            let calendarVC = CalenderViewController()
            calendarVC.modalPresentationStyle = .overFullScreen
            //        calendarVC.modalPresentationStyle = .overCurrentContext
            calendarVC.useCase = useCase
            calendarVC.inController = controller
            
            switch useCase {
            case .inMainVC:
                if searchBarView.selectedDatesArray.count > 0 {
                    calendarVC.beginDatesArray = searchBarView.selectedDatesArray
                }
            case .inHouseVC:
                guard let houseVC = controller as? HouseViewController else { print("‼️ : "); return }
                if houseVC.searchBarView.selectedDatesArray.count > 0 {
                    calendarVC.beginDatesArray = houseVC.searchBarView.selectedDatesArray
                }
            case .inTripVC:
                ()
            }
            
            
            present(calendarVC, animated: false)
            
        // 날짜 검색버튼 클릭
        case Notification.Name.searchBarDateResultBtnDidTap:
            guard let userInfo = sender.userInfo
                , let houseDataArray = userInfo["houseViewDataArray"] as? [HouseViewData]
                , let useCase = userInfo[SingletonCommonData.notiKeySearchBarUseCase] as? UseCase
                , let controller = userInfo[SingletonCommonData.notiKeySearchBarInController] as? UIViewController else {
                    print("‼️ MainVC SearchBar resultBtn noti userinfo ")
                    return
            }
            
            switch useCase {
            case .inMainVC:
                let houseVC = HouseViewController()
                houseVC.houseView.houseViewDatas = houseDataArray
                houseVC.searchBarView.selectedDatesArray = searchBarView.selectedDatesArray
                houseVC.searchBarView.selectedDateString = searchBarView.selectedDateString
                self.navigationController?.pushViewController(houseVC, animated: false)
            case .inHouseVC:
                guard let houseVC = controller as? HouseViewController else { print("‼️ : "); return }
                houseVC.houseView.houseViewDatas.removeAll()
                houseVC.houseView.houseViewDatas = houseDataArray
                houseVC.houseView.flag = false
                houseVC.houseView.tableView.reloadData()
                
            case .inTripVC:
                ()
            }
            
        // 인원 설정버튼
        case Notification.Name.searchBarPeopleBtnDidTap:
            guard let userInfo = sender.userInfo
                , let useCase = userInfo[SingletonCommonData.notiKeySearchBarUseCase] as? UseCase
                , let controller = userInfo[SingletonCommonData.notiKeySearchBarInController] as? UIViewController else {
                    print("‼️ ")
                    return
            }
            
            let filterPeopleVC = FilterPeopleViewController()
            filterPeopleVC.useCase = useCase
            filterPeopleVC.inController = controller
            
            switch useCase {
            case .inMainVC:
                filterPeopleVC.selectedPeople = searchBarView.selectedPeople
            case .inHouseVC:
                guard let houseVC = controller as? HouseViewController else { print("‼️ : "); return }
                filterPeopleVC.selectedPeople = houseVC.searchBarView.selectedPeople
            case .inTripVC:
                ()
            }
            
            filterPeopleVC.modalPresentationStyle = .overFullScreen
            present(filterPeopleVC, animated: false)
        
        // 인원 검색버튼 클릭
        case Notification.Name.searchBarPeopleResultBtnDidTap:
            guard let userInfo = sender.userInfo
                , let houseDataArray = userInfo["houseViewDataArray"] as? [HouseViewData]
                , let useCase = userInfo[SingletonCommonData.notiKeySearchBarUseCase] as? UseCase
                , let controller = userInfo[SingletonCommonData.notiKeySearchBarInController] as? UIViewController else {
                    print("‼️ MainVC SearchBar resultBtn noti userinfo ")
                    return
            }
            
            switch useCase {
            case .inMainVC:
                let houseVC = HouseViewController()
                houseVC.houseView.houseViewDatas = houseDataArray
                houseVC.searchBarView.selectedPeople = searchBarView.selectedPeople
                self.navigationController?.pushViewController(houseVC, animated: false)
            case .inHouseVC:
                guard let houseVC = controller as? HouseViewController else { print("‼️ : "); return }
                houseVC.houseView.houseViewDatas.removeAll()
                houseVC.houseView.houseViewDatas = houseDataArray
                houseVC.houseView.flag = false
                houseVC.houseView.tableView.reloadData()
            case .inTripVC:
                ()
            }
            
            
            
        // 필터 버튼 클릭
        case Notification.Name.searchBarFilterBtnDidTap:
            let filterRemainsVC = FilterRemainsViewController()
            filterRemainsVC.isDateSelected = (searchBarView.selectedDateString == "날짜") ? false : true
            present(filterRemainsVC, animated: true)
            
            
        // Push other views Notification
        // 숙소 리스트VC 로 이동
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
            
        // 숙소 상세VC 로 이동
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
            
        // 숙소 Plus 상세VC 로 이동
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

