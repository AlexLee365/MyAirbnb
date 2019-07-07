//
//  TripViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class TripViewController: UIViewController {

    let tableView = UITableView()
    
    let searchBarView: SearchBarView = {
        let searchBarView = SearchBarView()
        searchBarView.searchImageView.image = UIImage(named: "<#T##String#>")
        return searchBarView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    private func configure() {
        
        
        view.addSubview(searchBarView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(TripIntroTableViewCell.self, forCellReuseIdentifier: TripIntroTableViewCell.identifier)
        tableView.register(SpecialTripTableViewCell.self, forCellReuseIdentifier: SpecialTripTableViewCell.identifier)
        tableView.register(SeoulRecommenedTripTableViewCell.self, forCellReuseIdentifier: SeoulRecommenedTripTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    private func setAutolayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}


// MARK: - UITableViewDataSource

extension TripViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            tableView.rowHeight = 545

            let introCell = tableView.dequeueReusableCell(withIdentifier: TripIntroTableViewCell.identifier, for: indexPath) as! TripIntroTableViewCell
            
            introCell.backgroundColor = .black
            introCell.selectionStyle = .none
            
            return introCell
            
        } else if indexPath.row == 1 {
            tableView.rowHeight = 530
            
            let specialTripCell = tableView.dequeueReusableCell(withIdentifier: SpecialTripTableViewCell.identifier, for: indexPath) as! SpecialTripTableViewCell
            
            specialTripCell.selectionStyle = .none
            
            return specialTripCell
            
        } else if indexPath.row == 2 {
            tableView.rowHeight = 545
            
            let seoulRecommendedTripCell = tableView.dequeueReusableCell(withIdentifier: SeoulRecommenedTripTableViewCell.identifier, for: indexPath) as! SeoulRecommenedTripTableViewCell
            
            seoulRecommendedTripCell.selectionStyle = .none
            
            return seoulRecommendedTripCell
            
        } else {
            tableView.rowHeight = 510
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension TripViewController: UITableViewDelegate {
    
}
