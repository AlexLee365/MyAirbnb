//
//  HouseInfoTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 07/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HouseInfoTableCell: UITableViewCell {
    static let identifier = "HouseInfoTableCell"
    
    let scheduleLabel: UILabel = {
        let label = UILabel()
        label.text = "2박 • 1월 19일 (토), 오후 3:00"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 16)
        return label
    }()
    
    let houseNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Gallery"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 25)
        label.numberOfLines = 0
        return label
    }()
    
    let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "saveLocation")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "위치 안내"
        label.textColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 15)
        return label
    }()
    
    let phoneIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "saveCall")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let phoneTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "전화"
        label.textColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 15)
        return label
    }()
    
    let msgIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "saveContact")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let contactTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "연락하기"
        label.textColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 15)
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
        
        contentView.addSubview(scheduleLabel)
        contentView.addSubview(houseNameLabel)
        contentView.addSubview(locationIcon)
        contentView.addSubview(locationTitleLabel)
        contentView.addSubview(phoneIcon)
        contentView.addSubview(phoneTitleLabel)
        contentView.addSubview(msgIcon)
        contentView.addSubview(contactTitleLabel)
    }
    
    private func setAutolayout() {
        scheduleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
        }
        
        houseNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scheduleLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        locationIcon.snp.makeConstraints { (make) in
            make.top.equalTo(houseNameLabel.snp.bottom).offset(25)
            make.centerX.equalTo(locationTitleLabel.snp.centerX)
            make.width.height.equalTo(30)
        }
        
        locationTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(locationIcon.snp.bottom).offset(3)
            make.leading.equalTo(45)
            make.bottom.equalTo(-20)
        }
        
        phoneIcon.snp.makeConstraints { (make) in
            make.top.equalTo(houseNameLabel.snp.bottom).offset(25)
            make.centerX.equalTo(phoneTitleLabel.snp.centerX)
            make.width.height.equalTo(30)
        }
        
        phoneTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(phoneIcon.snp.bottom).offset(3)
            make.leading.equalTo(locationTitleLabel.snp.trailing).offset(80)
        }
        
        msgIcon.snp.makeConstraints { (make) in
            make.top.equalTo(houseNameLabel.snp.bottom).offset(25)
            make.centerX.equalTo(contactTitleLabel.snp.centerX)
            make.width.height.equalTo(30)
        }
        
        contactTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(msgIcon.snp.bottom).offset(3)
            make.trailing.equalTo(-45)
        }
    }
}
