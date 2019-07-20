//
//  HouseDetailStayingDaysTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 19/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseDetailStayingDaysTableCell: UITableViewCell {
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let topBottomMargin = StandardUIValue.shared.houseDetailTopBottomMargin
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: topBottomMargin).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        label.configureHouseDetailSubText()
        label.text = "최소 1박"
    }

}
