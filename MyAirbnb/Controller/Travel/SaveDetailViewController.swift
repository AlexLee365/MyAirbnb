//
//  SaveDetailViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 07/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class SaveDetailViewController: UIViewController {
    
    let topView: TableviewTopView = {
        let view = TableviewTopView()
        view.backgroundColor = .clear
        view.backButton.setImage(UIImage(named: "close"), for: .normal)
        view.heartButton.setImage(#imageLiteral(resourceName: "shareBlack"), for: .normal)
        view.shareButton.isHidden = true
        return view
    }()
    
    let representImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "categoryHouseImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let confirmLabel = UILabel()
        confirmLabel.text = "예약 확정"
        confirmLabel.textAlignment = .center
        confirmLabel.font = UIFont(name: "AirbnbCerealApp-Bold", size: 13)
        confirmLabel.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.5)
        confirmLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        confirmLabel.layer.cornerRadius = 5
        imageView.addSubview(confirmLabel)
        
        confirmLabel.snp.makeConstraints({ (make) in
            make.bottom.trailing.equalTo(-20)
            make.width.equalTo(90)
            make.height.equalTo(30)
        })
        
        return imageView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.register(HouseInfoTableCell.self, forCellReuseIdentifier: HouseInfoTableCell.identifier)
        tableView.register(HostAndHouseTypeTableCell.self, forCellReuseIdentifier: HostAndHouseTypeTableCell.identifier)
        tableView.register(HouseDetailCheckInTableCell.self, forCellReuseIdentifier: HouseDetailCheckInTableCell.identifier)
        tableView.register(BillsTableCell.self, forCellReuseIdentifier: BillsTableCell.identifier)
        
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
        representImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        tableView.tableHeaderView = representImageView
        view.addSubview(tableView)
        
        topView.delegate = self
        view.addSubview(topView)
    }
    
    private func setAutolayout() {
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}


// MARK: - UITableViewDataSource

extension SaveDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let houseInfoCell = tableView.dequeueReusableCell(withIdentifier: HouseInfoTableCell.identifier, for: indexPath) as! HouseInfoTableCell
            houseInfoCell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            return houseInfoCell
            
        case 1:
            let hostInfoCell = tableView.dequeueReusableCell(withIdentifier: HostAndHouseTypeTableCell.identifier, for: indexPath) as! HostAndHouseTypeTableCell
            hostInfoCell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            return hostInfoCell
            
        case 2:
            let checkInOutCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailCheckInTableCell.identifier, for: indexPath) as! HouseDetailCheckInTableCell
            checkInOutCell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            return checkInOutCell
            
        case 3:
            let billCell = tableView.dequeueReusableCell(withIdentifier: BillsTableCell.identifier, for: indexPath) as! BillsTableCell
            billCell.delegate = self
            return billCell
        default:
            return UITableViewCell()
        }
    }
}


// MARK: - TableviewTopViewDelegate

extension SaveDetailViewController: TableviewTopViewDelegate {
    func popView() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - BillsTableCellDelegate

extension SaveDetailViewController: BillsTableCellDelegate {
    func presentBillsVC() {
//        let billsVC = BillsViewController()
//
//        present(billsVC, animated: true)
        
        let billsVC = HouseDetailReserveInfoViewController()
        billsVC.bottomView.isHidden = true
        present(billsVC, animated: true)
    }
}
