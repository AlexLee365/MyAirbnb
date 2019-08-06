//
//  TestSaveViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 18/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class TestSaveViewController: UIViewController {

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

extension TestSaveViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let plannedTripTitleCell = tableView.dequeueReusableCell(withIdentifier: PlannedTripTitleTableCell.identifier, for: indexPath)
            return plannedTripTitleCell
 
        default:
            let plannedHouseCell = tableView.dequeueReusableCell(withIdentifier: PlannedHouseTableCell.identifier, for: indexPath) as! PlannedHouseTableCell
            
            return plannedHouseCell
        }
        
    }
}

// MARK: - UITableViewDelegate

extension TestSaveViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let saveDetailVC = SaveDetailViewController()
        present(saveDetailVC, animated: true)
    }
}
