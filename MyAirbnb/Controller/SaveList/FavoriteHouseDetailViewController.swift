//
//  FavoriteHouseDetailViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/08.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class FavoriteHouseDetailViewController: UIViewController {

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
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(SaveDetailTitleTableCell.self, forCellReuseIdentifier: SaveDetailTitleTableCell.identifier)
        tableView.register(NoOfLikeListTableCell.self, forCellReuseIdentifier: NoOfLikeListTableCell.identifier)
        tableView.register(LikeListTableCell.self, forCellReuseIdentifier: LikeListTableCell.identifier)
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutolayout()
    }
    

    // MARK: - Properties
    
    private func configure() {
        topView.delegate = self
        view.addSubview(topView)
        
        tableView.dataSource = self
//        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func setAutolayout() {
        view.backgroundColor = .white
        
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


// MARK: - TableviewTopViewDelegate
extension FavoriteHouseDetailViewController: TableviewTopViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: - UITableViewDataSource
extension FavoriteHouseDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let titleCell = tableView.dequeueReusableCell(withIdentifier: SaveDetailTitleTableCell.identifier, for: indexPath) as! SaveDetailTitleTableCell
            titleCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            return titleCell
        case 1:
            let noOfLikeListCell = tableView.dequeueReusableCell(withIdentifier: NoOfLikeListTableCell.identifier, for: indexPath)
            return noOfLikeListCell
        default:
            let likeListCell = tableView.dequeueReusableCell(withIdentifier: LikeListTableCell.identifier, for: indexPath) as! LikeListTableCell
            return likeListCell
        }
    }
}
