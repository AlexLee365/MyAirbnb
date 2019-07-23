//
//  FilterRemainsViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 16/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class FilterRemainsViewController: UIViewController {
    
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
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "필터"
        titleLabel.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       
        return view
    }()

    let removeAllBtn: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.titleLabel?.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        button.setTitle(" 모두 지우기 ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let bottomView: BottomView = {
        let view = BottomView()
        view.backColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let showBtn: UIButton = {
        let button = UIButton()
        button.setTitle("300개 이상의 숙소 보기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.5, weight: .bold)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
        setAutolayout()
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InstantBookTableCell.self, forCellReuseIdentifier: InstantBookTableCell.identifier)
        tableView.register(QualifiedHouseTableCell.self, forCellReuseIdentifier: QualifiedHouseTableCell.identifier)
        tableView.register(PriceRangeTableCell.self, forCellReuseIdentifier: PriceRangeTableCell.identifier)
        tableView.register(HouseTypeTableCell.self, forCellReuseIdentifier: HouseTypeTableCell.identifier)
        tableView.register(BedFilterTableCell.self, forCellReuseIdentifier: BedFilterTableCell.identifier)
        tableView.register(CheckboxTableCell.self, forCellReuseIdentifier: CheckboxTableCell.identifier)
        view.addSubview(tableView)
        
        view.addSubview(topView)
        
        removeAllBtn.addTarget(self, action: #selector(removeAllBtnDidTap(_:)), for: .touchUpInside)
        topView.addSubview(removeAllBtn)
        
        view.addSubview(bottomView)
        
        bottomView.addSubview(showBtn)
    }
    
    @objc private func removeAllBtnDidTap(_ sender: UIButton) {
        
    }
    
    private func setAutolayout() {
        let guide = view.safeAreaLayoutGuide
        topView.delegate = self
        topView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
    
        removeAllBtn.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        removeAllBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        removeAllBtn.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.11).isActive = true
        
        showBtn.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        showBtn.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        showBtn.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.85).isActive = true
        showBtn.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.63).isActive = true
    }
    
    var checkBoxViewButtons = [[UIButton]]()
    
    
}

// MARK: - UITableViewDataSource

extension FilterRemainsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let instantBookCell = tableView.dequeueReusableCell(withIdentifier: InstantBookTableCell.identifier, for: indexPath) as! InstantBookTableCell
            return instantBookCell
            
        case 1:
            let qualifiedHouseCell = tableView.dequeueReusableCell(withIdentifier: QualifiedHouseTableCell.identifier, for: indexPath) as! QualifiedHouseTableCell
            return qualifiedHouseCell
            
        case 2:
            let priceRangeCell = tableView.dequeueReusableCell(withIdentifier: PriceRangeTableCell.identifier, for: indexPath) as! PriceRangeTableCell
            return priceRangeCell
            
        case 3:
            let houseTypeCell = tableView.dequeueReusableCell(withIdentifier: HouseTypeTableCell.identifier, for: indexPath) as! HouseTypeTableCell
            return houseTypeCell
        case 4:
            let bedCell = tableView.dequeueReusableCell(withIdentifier: BedFilterTableCell.identifier, for: indexPath) as! BedFilterTableCell
            return bedCell
            
        case 5:
            let convenienceFacilityCell = tableView.dequeueReusableCell(withIdentifier: CheckboxTableCell.identifier, for: indexPath) as! CheckboxTableCell
            
            convenienceFacilityCell.setting(data: checkBoxDatas[0])
            
            let tempButtons = convenienceFacilityCell.checkBoxViewArray.compactMap { $0.checkBox }
            checkBoxViewButtons.insert(tempButtons, at: 0)
            
            return convenienceFacilityCell
            
        case 6:
            let facilityCell = tableView.dequeueReusableCell(withIdentifier: CheckboxTableCell.identifier, for: indexPath) as! CheckboxTableCell

            facilityCell.setting(data: checkBoxDatas[1])
            
            return facilityCell

        case 7:
            let buildingTypeCell = tableView.dequeueReusableCell(withIdentifier: CheckboxTableCell.identifier, for: indexPath) as! CheckboxTableCell

            buildingTypeCell.setting(data: checkBoxDatas[2])
            
            return buildingTypeCell

        case 8:
            let distictHouseCell = tableView.dequeueReusableCell(withIdentifier: CheckboxTableCell.identifier, for: indexPath) as! CheckboxTableCell

            distictHouseCell.setting(data: checkBoxDatas[3])
            
            return distictHouseCell

        case 9:
            let houseRuleCell = tableView.dequeueReusableCell(withIdentifier: CheckboxTableCell.identifier, for: indexPath) as! CheckboxTableCell
            
            houseRuleCell.setting(data: checkBoxDatas[4])

            return houseRuleCell
            
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - TableviewTopViewDelegate

extension FilterRemainsViewController: UITableViewDelegate {
    
}

extension FilterRemainsViewController: TableviewTopViewDelegate {
    func popView() {
        dismiss(animated: true, completion: nil)
    }
}
