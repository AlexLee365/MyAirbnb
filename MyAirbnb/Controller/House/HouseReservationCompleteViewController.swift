//
//  HouseReservationCompleteViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 07/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HouseReservationCompleteViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ConfirmedTitleTableCell.self, forCellReuseIdentifier: ConfirmedTitleTableCell.identifier)
        tableView.register(PaymentOverviewTableCell.self, forCellReuseIdentifier: PaymentOverviewTableCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        tableView.dataSource = self
        view.addSubview(tableView)
        
    }
    
    private func setAutolayout() {
        tableView.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UITableViewDataSource

extension HouseReservationCompleteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let confirmedTitleCell = tableView.dequeueReusableCell(withIdentifier: ConfirmedTitleTableCell.identifier, for: indexPath) as! ConfirmedTitleTableCell
            return confirmedTitleCell
        case 1:
            let payOverviewCell = tableView.dequeueReusableCell(withIdentifier: PaymentOverviewTableCell.identifier, for: indexPath) as! PaymentOverviewTableCell
            payOverviewCell.delegate = self
            return payOverviewCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - PaymentOverviewTableCellDelegate

extension HouseReservationCompleteViewController: PaymentOverviewTableCellDelegate {
    func returnToMainVC() {
        
    }
}
