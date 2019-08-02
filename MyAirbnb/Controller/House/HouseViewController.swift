//
//  HouseViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 14/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HouseViewController: UIViewController {
    
    // MARK: - UI Properteis
    let searchBarView: SearchBarView = {
        let searchBarView = SearchBarView()
        searchBarView.searchImageBtn.setImage(UIImage(named: "back33"), for: .normal)
        return searchBarView
    }()
    let searchBarTableViewBackWhiteView = UIView()
    let searchBarTableView = SearchBarTableView()
    
    let houseView = HouseView()
    
    let indicatorView = UIView()
    let indicator = NVActivityIndicatorView(frame: .zero)
    
    
    // MARK: - Properties
    let jsonDecoder = JSONDecoder()
    let netWork = NetworkCommunicator()
    let notiCenter = NotificationCenter.default
    var searchWord: String? {
        didSet {
            searchBarView.searchTF.text = (searchWord == nil) ? "숙소" : "숙소 ・ \(searchWord ?? "")"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewsOptions()
        setAutolayout()
        makeIndicatorView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        searchBarView.useCase = .inHouseVC
        searchBarView.inController = self
        searchBarTableView.useCase = .inHouseVC
        searchBarTableView.inController = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        searchBarView.searchTF.resignFirstResponder()
        searchBarView.searchTF.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
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
        houseView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -SingletonCommonData.shared.deviceSafeAreaInset.bottom).isActive = true
        
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
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        searchBarView.searchTF.text = (searchWord == nil) ? "숙소" : "숙소 ・ \(searchWord ?? "")"
        searchBarView.searchImageBtn.addTarget(self, action: #selector(searchImageBtnDidTap), for: .touchUpInside)
        
        searchBarTableView.alpha = 0
        searchBarTableViewBackWhiteView.backgroundColor = .white
        searchBarTableViewBackWhiteView.alpha = 0
    }
    
    @objc func searchImageBtnDidTap() {
        navigationController?.popViewController(animated: false)
    }
    
    func showSearchBarTableView() {
        view.bringSubviewToFront(searchBarTableViewBackWhiteView)
        self.searchBarTableViewBackWhiteView.alpha = 1
        
        UIView.animate(withDuration: 0.3) {
            self.searchBarTableView.alpha = 1
        }
    }
    
    func hideSearchBarTableView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.searchBarTableView.alpha = 0
        }) { (_) in
            self.searchBarTableViewBackWhiteView.alpha = 0
            self.view.sendSubviewToBack(self.searchBarTableViewBackWhiteView)
        }
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
    
    func startIndicator() {
        view.bringSubviewToFront(indicatorView)
        indicator.startAnimating()
    }
    
    func stopIndicator() {
        view.sendSubviewToBack(indicatorView)
        indicator.stopAnimating()
    }
    
}
