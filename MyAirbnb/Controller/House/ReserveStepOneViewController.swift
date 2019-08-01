//
//  ReserveStepOneViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 31/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class ReserveStepOneViewController: UIViewController {

    let topView: TableviewTopView = {
        let view = TableviewTopView()
        view.backgroundColor = .white
        view.backButton.setImage(UIImage(named: "backBlack"), for: .normal)
        view.shareButton.isHidden = true
        view.heartButton.isHidden = true
        
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        view.layer.shadowRadius = 0
        view.layer.shadowColor = UIColor.gray.cgColor
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.register(StepOneTitleTableCell.self, forCellReuseIdentifier: StepOneTitleTableCell.identifier)
        tableView.register(CheckInCheckOutInfoTableCell.self, forCellReuseIdentifier: CheckInCheckOutInfoTableCell.identifier)
        
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
        
        topView.delegate = self
        view.addSubview(topView)
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func setAutolayout() {
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


// MARK: - UITableViewDataSource

extension ReserveStepOneViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let stepTitleCell = tableView.dequeueReusableCell(withIdentifier: StepOneTitleTableCell.identifier, for: indexPath) as! StepOneTitleTableCell
            return stepTitleCell
        case 1:
            let checkInOutInfoCell = tableView.dequeueReusableCell(withIdentifier: CheckInCheckOutInfoTableCell.identifier, for: indexPath) as! CheckInCheckOutInfoTableCell
            return checkInOutInfoCell
        default:
            return UITableViewCell()
        }
    }
    
    
}

// MARK: - UITableViewDelegate

extension ReserveStepOneViewController: UITableViewDelegate {
}

// MARK: - TableviewTopViewDelegate

extension ReserveStepOneViewController: TableviewTopViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
