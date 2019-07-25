//
//  HouseDetailStayingDaysTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 19/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseDetailStayingDaysTableCell: UITableViewCell {
    static let identifier = "HouseDetailStayingDaysTableCell"
    
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let topBottomMargin = StandardUIValue.shared.houseDetailTopBottomMargin
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: topBottomMargin).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
//        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -topBottomMargin).isActive = true
        
        label.configureHouseDetailMainText()
        label.text = "최소 1박"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(minStayingDay: Int) {
        label.text = "최소 \(minStayingDay)박"
    }
    
}
