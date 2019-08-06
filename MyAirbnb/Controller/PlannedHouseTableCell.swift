//
//  PlannedHouseTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 07/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class PlannedHouseTableCell: UITableViewCell {
    static let identifier = "PlannedHouseTableCell"
    
    let plannedDateLabel: UILabel = {
        let label = UILabel()
        label.text = "• 7월 26일 - 7월 31일"
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 15)
        return label
    }()
    
    let houseNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Arakawa-ku"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let representImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "kitchen2")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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
        
        contentView.addSubview(plannedDateLabel)
        contentView.addSubview(houseNameLabel)
        contentView.addSubview(representImageView)
    }
    
    private func setAutolayout() {
        plannedDateLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(30)
        }
        
        houseNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(plannedDateLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-30)
        }
        
        representImageView.snp.makeConstraints { (make) in
            make.top.equalTo(houseNameLabel.snp.bottom).offset(15)
            make.leading.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(representImageView.snp.width).multipliedBy(0.6)
            make.bottom.equalTo(-20)
        }
    }
}
