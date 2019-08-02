//
//  TripSearchMainViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class TripSearchMainViewController: UIViewController {

    let searchBarView = SearchBarView()
    var searchUrl = ""
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        
        tableView.register(AllInterestTableCell.self, forCellReuseIdentifier: AllInterestTableCell.identifier)
        tableView.register(RecommendedTripTableCell.self, forCellReuseIdentifier: RecommendedTripTableCell.identifier)
        tableView.register(FullImageTouchTableCell.self, forCellReuseIdentifier: FullImageTouchTableCell.identifier)
        tableView.register(AllTripsTableCell.self, forCellReuseIdentifier: AllTripsTableCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
        getServerData()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        view.addSubview(searchBarView)
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func setAutolayout() {
        searchBarView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBarView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    let netWork = NetworkCommunicator()
    let jsonDecoder = JSONDecoder()
    
    var stateData: StateDetailData?
    
    func getServerData() {
        let urlString = searchUrl
        
        netWork.getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json, success) in
            
            guard success else {
                print("get serverData failed")
                return
            }
            
            guard let data = try? JSONSerialization.data(withJSONObject: json) else {
                print("‼️ moveToHouseDetail noti data convert error")
                return
            }
            
            guard let result = try? self.jsonDecoder.decode(StateDetailData.self, from: data) else {
                print("‼️ moveToHouseDetail noti result decoding convert error")
                return
            }
            
            self.stateData = result
            print("stateData", self.stateData)
        }
    }
}


// MARK: - UITableViewDataSource

extension TripSearchMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let allInterestCell = tableView.dequeueReusableCell(withIdentifier: AllInterestTableCell.identifier, for: indexPath) as! AllInterestTableCell
            return allInterestCell
        case 1:
            let recommendedCell = tableView.dequeueReusableCell(withIdentifier: RecommendedTripTableCell.identifier, for: indexPath) as! RecommendedTripTableCell
            return recommendedCell
        case 2:
            let fullImageTouchCell = tableView.dequeueReusableCell(withIdentifier: FullImageTouchTableCell.identifier, for: indexPath) as! FullImageTouchTableCell
            return fullImageTouchCell
        case 3:
            let allTripsCell = tableView.dequeueReusableCell(withIdentifier: AllTripsTableCell.identifier, for: indexPath) as! AllTripsTableCell
            return allTripsCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension TripSearchMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            let height = ((UIScreen.main.bounds.width - 40) * 1.25 ) + 50
            return height
        } else {
            return UITableView.automaticDimension
        }
    }
}

