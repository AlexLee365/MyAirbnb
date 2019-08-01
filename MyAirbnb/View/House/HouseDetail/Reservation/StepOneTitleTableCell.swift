//
//  StepOneTitleTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class StepOneTitleTableCell: UITableViewCell {
    static let identifier = "StepOneTitleTableCell"
    
    let stepLabel: UILabel = {
        let label = UILabel()
        label.text = "1/3단계"
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 16)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "숙소 예약"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 27)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
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
        contentView.addSubview(stepLabel)
        contentView.addSubview(titleLabel)
    }
    
    private func setAutolayout() {
        stepLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(stepLabel.snp.bottom).offset(3)
            make.leading.equalTo(20)
            make.bottom.equalTo(-20)
        }
    }
}
