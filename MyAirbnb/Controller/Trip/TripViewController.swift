//
//  TripViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class TripViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        
        tableView.register(TripIntroTableViewCell.self, forCellReuseIdentifier: TripIntroTableViewCell.identifier)
        tableView.register(SpecialTripTableViewCell.self, forCellReuseIdentifier: SpecialTripTableViewCell.identifier)
        tableView.register(SeoulRecommenedTripTableViewCell.self, forCellReuseIdentifier: SeoulRecommenedTripTableViewCell.identifier)
        tableView.register(WorldAdventureTableCell.self, forCellReuseIdentifier: WorldAdventureTableCell.identifier)
        tableView.register(TodaySeoulExperienceTableViewCell.self, forCellReuseIdentifier: TodaySeoulExperienceTableViewCell.identifier)
        tableView.register(OtherCityTripTableCell.self, forCellReuseIdentifier: OtherCityTripTableCell.identifier)
        
        return tableView
    }()
    
    let searchBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.opacity = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchBarView: SearchBarView = {
        let searchBarView = SearchBarView()
        searchBarView.searchImageBtn.setImage(UIImage(named: "back33"), for: .normal)
        searchBarView.backgroundColor = .clear
        return searchBarView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
        searchBarView.useCase = .inTripVC
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    var isStatusBarWhite = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isStatusBarWhite {
            return .lightContent
        } else {
            return .default
        }
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        view.addSubview(searchBarView)
        searchBarView.filterStackView.isHidden = true
        searchBarView.searchTF.text = "트립"
        
        view.addSubview(searchBarBackgroundView)
        view.bringSubviewToFront(searchBarView)
    }
    
    private func setAutolayout() {
        
        let safeGuide = view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        searchBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
       
        searchBarBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBarBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBarBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBarBackgroundView.bottomAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 10).isActive = true
    }
}


// MARK: - UITableViewDataSource

extension TripViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let introCell = tableView.dequeueReusableCell(withIdentifier: TripIntroTableViewCell.identifier, for: indexPath) as! TripIntroTableViewCell
            
            introCell.delegate = self
            
            return introCell
            
        case 1:
            let specialTripCell = tableView.dequeueReusableCell(withIdentifier: SpecialTripTableViewCell.identifier, for: indexPath) as! SpecialTripTableViewCell
            return specialTripCell
            
        case 2:
            let seoulRecommendedTripCell = tableView.dequeueReusableCell(withIdentifier: SeoulRecommenedTripTableViewCell.identifier, for: indexPath) as! SeoulRecommenedTripTableViewCell
            
            seoulRecommendedTripCell.delegate = self
            
            return seoulRecommendedTripCell
            
        case 3:
            let worldAdventureCell = tableView.dequeueReusableCell(withIdentifier: WorldAdventureTableCell.identifier, for: indexPath) as! WorldAdventureTableCell
            
            worldAdventureCell.delegate = self
            
            return worldAdventureCell
            
        case 4:
            let todaySeoulExperienceCell = tableView.dequeueReusableCell(withIdentifier: TodaySeoulExperienceTableViewCell.identifier, for: indexPath) as! TodaySeoulExperienceTableViewCell
            return todaySeoulExperienceCell
            
        case 5:
            let otherCityTripCell = tableView.dequeueReusableCell(withIdentifier: OtherCityTripTableCell.identifier, for: indexPath) as! OtherCityTripTableCell
            return otherCityTripCell
            
        default:
            return UITableViewCell()
        }
    }
}


// MARK: - UITableViewDelegate

extension TripViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // scrollView offset이 (cell.height - backgroundview.height) 일때 opacity가 1이되야함
        // scrollView offset이 대략 200전부터 opacity가 변하기 시작하도록 함
        
        let becomeWhiteEndPoint = 545 - searchBarBackgroundView.frame.height
        let becomeWhiteStartPoint = becomeWhiteEndPoint - 100
        
        if scrollView.contentOffset.y > becomeWhiteStartPoint {
            let opacity = ( scrollView.contentOffset.y - becomeWhiteStartPoint ) / (becomeWhiteEndPoint - becomeWhiteStartPoint)
            searchBarBackgroundView.layer.opacity = Float(opacity)
            isStatusBarWhite = false
        } else {
            searchBarBackgroundView.layer.opacity = 0
            isStatusBarWhite = true
        }
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 545
        case 1:
            return 530
        case 2:
            return 555
        case 3:
            return 810
        case 4:
           return 900
        case 5:
            return 300
        default:
            return 0
        }
    }
}

// MARK: - TripIntroTableViewCellDelegate

extension TripViewController: TripIntroTableViewCellDelegate {
    func presentView(index: IndexPath) {
        let avFoundationVC = AVFoundationViewController()
        avFoundationVC.beginPageCount = index.row
        let navi = UINavigationController(rootViewController: avFoundationVC)
        present(navi, animated: true)
    }
}


// MARK: - SeoulRecommenedTripTableViewCellDelegate

extension TripViewController: SeoulRecommenedTripTableViewCellDelegate {
    func pushVC() {
        let detailVC = SeoulRecommendedDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func pushVCForBtn() {
        let tripAllVC = TripAllViewController()
        navigationController?.pushViewController(tripAllVC, animated: false)
    }
}

// MARK: - WorldAdventureTableCellDelegate

extension TripViewController: WorldAdventureTableCellDelegate {
    func pushAdventureVC() {
        let adventureVC = VideosDetailViewController()
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(adventureVC, animated: true)
    }
}

