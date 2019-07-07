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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TripIntroTableViewCell.self, forCellReuseIdentifier: TripIntroTableViewCell.identifier)
        tableView.register(SpecialTripTableViewCell.self, forCellReuseIdentifier: SpecialTripTableViewCell.identifier)
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
            return introCell
            
        } else {
            tableView.rowHeight = 500
            
            let specialTripCell = tableView.dequeueReusableCell(withIdentifier: SpecialTripTableViewCell.identifier, for: indexPath) as! SpecialTripTableViewCell
            
            return specialTripCell
        }
    }
}

// MARK: - UITableViewDelegate

extension TripViewController: UITableViewDelegate {
    
}
