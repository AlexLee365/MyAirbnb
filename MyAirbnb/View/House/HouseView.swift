//
//  HouseView.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 17/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HouseTopLabelTableCell.self, forCellReuseIdentifier: HouseTopLabelTableCell.identifier)
        tableView.register(HouseLuxeTableCell.self, forCellReuseIdentifier: HouseLuxeTableCell.identifier)
        tableView.register(HousePlusTableCell.self, forCellReuseIdentifier: HousePlusTableCell.identifier)
        tableView.register(AllHouseLabelTableCell.self, forCellReuseIdentifier: AllHouseLabelTableCell.identifier)
        tableView.register(AllHousesTableCell.self, forCellReuseIdentifier: AllHousesTableCell.identifier)
        self.addSubview(tableView)
    }
    
    private func setAutolayout() {
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
}


// MARK: - UITableViewDataSource

extension HouseView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let topLabelCell = tableView.dequeueReusableCell(withIdentifier: HouseTopLabelTableCell.identifier, for: indexPath) as! HouseTopLabelTableCell
            topLabelCell.topLabel.text = "여행 날짜와 게스트 인원수를 입력하면 1박당 총 요금을 확인할 수 있습니다. 관광세가 추가로 부과될 수 있습니다."
            topLabelCell.selectionStyle = .none
            return topLabelCell
        case 1:
            let luxeHouseCell = tableView.dequeueReusableCell(withIdentifier: HouseLuxeTableCell.identifier, for: indexPath) as! HouseLuxeTableCell
            luxeHouseCell.selectionStyle = .none
            return luxeHouseCell
        case 2:
            let plusHouseCell = tableView.dequeueReusableCell(withIdentifier: HousePlusTableCell.identifier, for: indexPath) as! HousePlusTableCell
            plusHouseCell.selectionStyle = .none
            return plusHouseCell
        case 3:
            let allHouseLabelCell = tableView.dequeueReusableCell(withIdentifier: AllHouseLabelTableCell.identifier, for: indexPath) as! AllHouseLabelTableCell
            allHouseLabelCell.selectionStyle = .none
            return allHouseLabelCell
        default:
            let allHousesCell = tableView.dequeueReusableCell(withIdentifier: AllHousesTableCell.identifier, for: indexPath) as! AllHousesTableCell
            allHousesCell.houseTypeLabel.text = "게스트용 별채 전체 • TYRINGHAM"
            allHousesCell.houseNameLabel.text = "Charming, Cozy Casita with Desert Garden and apart. terrace"
            allHousesCell.ratingImageLabel.text = String(repeating: "★", count: 5)
            allHousesCell.ratingAndHostInfoLabel.text = "40 ・ 슈퍼호스트"
            allHousesCell.selectionStyle = .none
            return allHousesCell
        }
    }
    
    
}

// MARK: - UITabBarDelegate

extension HouseView: UITableViewDelegate {
    
}
