//
//  PlannedTravelViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/07.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class PlannedTravelViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        
        tableView.register(PlannedTripTitleTableCell.self, forCellReuseIdentifier: PlannedTripTitleTableCell.identifier)
        tableView.register(PlannedHouseTableCell.self, forCellReuseIdentifier: PlannedHouseTableCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func setAutolayout() {
        
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


// MARK: - UITableViewDataSource

extension PlannedTravelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let plannedTripTitleCell = tableView.dequeueReusableCell(withIdentifier: PlannedTripTitleTableCell.identifier, for: indexPath)
            return plannedTripTitleCell
            
        default:
            let plannedHouseCell = tableView.dequeueReusableCell(withIdentifier: PlannedHouseTableCell.identifier, for: indexPath) as! PlannedHouseTableCell
            
            switch indexPath.row {
            case 1:
                plannedHouseCell.setData(firstHidden: true, secondHidden: false)
            case 3:
                plannedHouseCell.setData(firstHidden: false, secondHidden: true)
            default:
                plannedHouseCell.setData(firstHidden: false, secondHidden: false)
            }
            
            
            
            return plannedHouseCell
        }
        
    }
}

// MARK: - UITableViewDelegate

extension PlannedTravelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let saveDetailVC = SaveDetailViewController()
        present(saveDetailVC, animated: true)
    }
}
