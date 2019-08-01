//
//  HouseDetailReserveInfoViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 31/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HouseDetailReserveInfoViewController: UIViewController {

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
        
        tableView.register(ReserveInfoTableCell.self, forCellReuseIdentifier: ReserveInfoTableCell.identifier)
        tableView.register(CheckInOutInfoTableCell.self, forCellReuseIdentifier: CheckInOutInfoTableCell.identifier)
        tableView.register(BizTripTableCell.self, forCellReuseIdentifier: BizTripTableCell.identifier)
        tableView.register(TaxInfoTableCell.self, forCellReuseIdentifier: TaxInfoTableCell.identifier)
        
        return tableView
    }()
    
    let bottomView: BottomInfoView = {
        let view = BottomInfoView()
        view.backColor = .white
        return view
    }()
    
    let reqBookingBtn: UIButton = {
        let button = UIButton()
        button.setTitle(" 예약 요청 ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AirbnbCerealApp-Bold", size: 14.5)
        button.layer.cornerRadius = 4
        button.backgroundColor = StandardUIValue.shared.colorPink
        return button
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

        view.addSubview(bottomView)
        
        reqBookingBtn.addTarget(self, action: #selector(reqReserveBtnDidTap(_:)), for: .touchUpInside)
        bottomView.addSubview(reqBookingBtn)
    }
    
    private func setAutolayout() {
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        let height = UIScreen.main.bounds.height * 0.1
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(height)
        }
        
        reqBookingBtn.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.65)
        }
    }
    
    @objc private func reqReserveBtnDidTap(_ sender: UIButton) {
        let reserveStepVC = ReserveStepOneViewController()
        navigationController?.pushViewController(reserveStepVC, animated: true)
    }
}


// MARK: - UITableViewDataSource

extension HouseDetailReserveInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let  reserveInfoCell = tableView.dequeueReusableCell(withIdentifier: ReserveInfoTableCell.identifier, for: indexPath) as! ReserveInfoTableCell
            return reserveInfoCell
        case 1:
            let checkInOutInfoCell = tableView.dequeueReusableCell(withIdentifier: CheckInOutInfoTableCell.identifier, for: indexPath) as! CheckInOutInfoTableCell
            return checkInOutInfoCell
        case 2:
            let bizTripCell = tableView.dequeueReusableCell(withIdentifier: BizTripTableCell.identifier, for: indexPath) as! BizTripTableCell
            return bizTripCell
        case 3:
            let taxInfoCell = tableView.dequeueReusableCell(withIdentifier: TaxInfoTableCell.identifier, for: indexPath) as! TaxInfoTableCell
            taxInfoCell.hideSeparator()
            return taxInfoCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension HouseDetailReserveInfoViewController: UITableViewDelegate {
    
}

// MARK: - TableviewTopViewDelegate

extension HouseDetailReserveInfoViewController: TableviewTopViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
