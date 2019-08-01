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
        tableView.register(CautionTableCell.self, forCellReuseIdentifier: CautionTableCell.identifier)
        
        return tableView
    }()
    
    let bottomView: HouseBottomView = {
        let view = HouseBottomView()
        view.isDateSelected = true
        view.noOfReviewLabel.isHidden = true
        view.priceDetailBtn.isHidden = true
        view.starImageLabel.isHidden = true
        
        view.reserveBtn.setTitle("다음", for: .normal)
        view.reserveBtn.setTitleColor(.white, for: .normal)
        view.reserveBtn.backgroundColor = StandardUIValue.shared.colorBlueGreen
        
        view.priceLabel.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            
        })
        view.reserveBtn.snp.makeConstraints({ (make) in
            make.width.equalTo(80)
        })
        
        return view
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
        
        bottomView.priceLabel.attributedText = attributedText(first: "₩162,007 ", second: "1박")
        bottomView.reserveBtn.addTarget(self, action: #selector(nextBtnDidTap(_:)), for: .touchUpInside)
        view.addSubview(bottomView)
    }
    
    @objc private func nextBtnDidTap(_ sender: UIButton) {
        let stepTwoVC = ReserveStepTwoViewController()
        navigationController?.pushViewController(stepTwoVC, animated: true)
    }
    
    private func setAutolayout() {
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        let height = UIScreen.main.bounds.height * 0.12
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(height)
        }
    }
    
    private func attributedText(first: String, second: String) -> NSAttributedString{
        let string = first + second as NSString
        let result = NSMutableAttributedString(string: string as String)
        let attributesForFirstWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Bold", size: 17) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        let attributesForSecondWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Book", size: 16) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        result.setAttributes(attributesForFirstWord, range: string.range(of: first))
        result.setAttributes(attributesForSecondWord, range: string.range(of: second))
        
        return NSAttributedString(attributedString: result)
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
        case 2:
            let cautionCell = tableView.dequeueReusableCell(withIdentifier: CautionTableCell.identifier, for: indexPath) as! CautionTableCell
            return cautionCell
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
