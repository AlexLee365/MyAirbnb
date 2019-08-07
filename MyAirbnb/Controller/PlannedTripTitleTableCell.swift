//
//  PlannedTripTitleTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 07/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class PlannedTripTitleTableCell: UITableViewCell {
    static let identifier = "PlannedTripTitleTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "여행"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
//        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 29)
        label.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        return label
    }()
    
    let noOfPlannedTrip: UILabel = {
        let label = UILabel()
        label.text = "예정된 여행 2개"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 16)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(noOfPlannedTrip)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(48)
            make.leading.equalTo(20)
        }
        
        noOfPlannedTrip.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalTo(20)
            make.bottom.equalTo(0)
        }
    }
}
