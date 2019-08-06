//
//  HouseReviewViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HouseReviewViewController: UIViewController {

    let topView: TableviewTopView = {
        let view = TableviewTopView()
        view.backgroundColor = .white
        view.backButton.setImage(UIImage(named: "close"), for: .normal)
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
        
        tableView.register(AverageReviewRateTableCell.self, forCellReuseIdentifier: AverageReviewRateTableCell.identifier)
        tableView.register(ReviewTableCell.self, forCellReuseIdentifier: ReviewTableCell.identifier)
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
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
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}


// MARK: - UITableViewDataSource

extension HouseReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let  averageRateCell = tableView.dequeueReusableCell(withIdentifier: AverageReviewRateTableCell.identifier, for: indexPath) as! AverageReviewRateTableCell
            return averageRateCell
        } else {
            let reviewTableCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableCell.identifier, for: indexPath) as! ReviewTableCell
            return reviewTableCell
        }
    }
}

// MARK: - UITableViewDelegate

extension HouseReviewViewController: UITableViewDelegate {
    
}

// MARK: - TableviewTopViewDelegate

extension HouseReviewViewController: TableviewTopViewDelegate {
    func popView() {
        dismiss(animated: true)
    }
}
