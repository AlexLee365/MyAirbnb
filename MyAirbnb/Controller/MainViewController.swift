//
//  MainViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 06/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UI Properties
    let searchBarView = SearchBarView()
    let searchBarTableViewBackWhiteView = UIView()
    let searchBarTableView = SearchBarTableView()
    
    var mainView = MainView()
    
    // MARK: - Properties
    let notiCenter = NotificationCenter.default
    
    let netWork = NetworkCommunicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        
        setAutoLayout()
        configureViewsOptions()
        addNotificationObserver()
        getServerDataTest()
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
        
        
        view.sendSubviewToBack(searchBarTableViewBackWhiteView)
        
        
        
    }
    
    private func configureViewsOptions() {
        view.backgroundColor = .white
        
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
            //            let tabbarHeight = self.tabBarController!.tabBar.frame.height
            //            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabbarHeight).isActive = true
            
            setLayout = true
        }
    }
    
    private func addNotificationObserver() {
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarEditBegin, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarEditEnd, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarDateBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarPeopleBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarFilterBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .moveToHouseView, object: nil)
    }
    
    @objc func receiveNotification(_ sender: Notification) {
        switch sender.name {
        case Notification.Name.searchBarEditBegin:
            print("receiveSearchEditBeginNotification")
            showSearchBarTableView()
            
        case Notification.Name.searchBarEditEnd:
            print("receiveSearchEditEndNotification")
            hideSearchBarTableView()
            
        case Notification.Name.searchBarDateBtnDidTap:
            print("receiveSearchDateBtnTapNotification")
            let calendarVC = CalenderViewController()
            calendarVC.modalPresentationStyle = .overFullScreen
            //        calendarVC.modalPresentationStyle = .overCurrentContext
            
            if searchBarView.selectedDatesArray.count > 0 {
                calendarVC.beginDatesArray = searchBarView.selectedDatesArray
            }
            
            present(calendarVC, animated: false)
            
        case Notification.Name.searchBarPeopleBtnDidTap:
            print("receiveSearchPeopleBtnTapNotification")
            let filterPeopleVC = FilterPeopleViewController()
            filterPeopleVC.selectedPeople = searchBarView.selectedPeople
            
            filterPeopleVC.modalPresentationStyle = .overFullScreen
            present(filterPeopleVC, animated: false)
            
        case Notification.Name.searchBarFilterBtnDidTap:
            print("receiveSearchFilterBtnTapNotification")
            let filterRemainsVC = FilterRemainsViewController()
            
            present(filterRemainsVC, animated: true)
            
        case Notification.Name.moveToHouseView:
            print("receiveMoveToHouseViewNotification")
            
            let houseVC = HouseViewController()
            navigationController?.pushViewController(houseVC, animated: false)
            
        default : break
        }
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
    
    private func getServerDataTest() {
        let urlString = netWork.basicUrlString
            + "/rooms/?search=seoul&ordering=price&page_size=5&page=1"
        
        
        netWork.getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json) in
            print("🔵🔵🔵 Entire: ")
//            print(json)
            guard let object = json as? [String: Any] else { print("object convert error"); return }
            print(object)
            
//            let encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))
//            if let messageString = String(cString: recevieCstring, encoding: encoding) { print(messageString)
            print("🔵🔵🔵 value: ")
            
            let resultArray = object["results"] as! [[String: Any]]
            print(resultArray)

        }
        
        
    }
    
}


class NetworkCommunicator {
    let basicUrlString = "http://airbnb.tthae.com/api"
    
    func getJsonObjectFromAPI(urlString: String = "", urlForSpecificProcessing incomingUrl: URL?, completion: @escaping (Any) -> ()) {
        // url 매개변수 값을 넣으면 url로 URLSession API호출 진행 (밖에서 url을 별도 처리해주고 넣어줘야할경우 사용)
        // url 값이 들어오지않으면 urlString으로 API호출 진행
        
        guard let url = (incomingUrl == nil) ? URL(string: urlString) : incomingUrl else { return }
        // url 매개변수값을 넣지않아 없으면 urlString값을 url로 변환하여 API호출 : url 값이 들어왔을 경우 들어온 incomingUrl로 API호출
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { print("error!!"); return }
//            print("🔵🔵🔵 response: ", response)
            guard let data = data else { print("data convert error"); return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) else { print("json conver error"); return }
            completion(jsonObject)
        }
        dataTask.resume()
    }
    
    func getUrlFromKoreanText(urlString: String) -> URL? {
        guard let translateAPIString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: translateAPIString)
            else { print("convertUrl failed"); return nil }
        return url
    }
}


//        let urlString = "https://kapi.kakao.com/v1/translation/translate?"
//            + "app_key=e4e4abd79709fdbc4e04e732818ac6f1&"
//            + "src_lang=\()&"
//            + "target_lang=\()&"
//            + "query=\()"
