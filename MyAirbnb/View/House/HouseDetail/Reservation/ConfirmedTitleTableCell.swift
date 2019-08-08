//
//  ConfirmedTitleTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 07/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class ConfirmedTitleTableCell: UITableViewCell {
    static let identifier = "ConfirmedTitleTableCell"
    
    let airbnbLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tabbarIcon_Travel_selected")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let airbnbTitle: UILabel = {
        let label = UILabel()
        label.text = "airbnb"
        label.textColor = StandardUIValue.shared.colorPink
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 30)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "예약이 확정되었습니다."
        label.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 40)
        return label
    }()
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "서울 여행 관련 정보입니다."
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 16)
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Vienna의 집 전체"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 16)
        return label
    }()
    
    let bookingInfo: UILabel = {
        let label = UILabel()
        label.text = "8월 29일~30일, 게스트 1명"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 16)
        return label
    }()
    
    let houseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "kitchen2")
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
        
        contentView.addSubview(airbnbLogo)
        contentView.addSubview(airbnbTitle)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stateLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(bookingInfo)
        contentView.addSubview(houseImageView)
    }
    
    private func setAutolayout() {
        airbnbLogo.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.centerX.equalToSuperview().offset(-50)
            make.width.height.equalTo(60)
        }
        
        airbnbTitle.snp.makeConstraints { (make) in
            make.leading.equalTo(airbnbLogo.snp.trailing)
            make.centerY.equalTo(airbnbLogo.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(airbnbLogo.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        
        stateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(titleLabel.snp.centerX)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(stateLabel.snp.bottom).offset(40)
            make.leading.equalTo(20)
        }
        
        bookingInfo.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom).offset(5)
            make.leading.equalTo(20)
        }
        
        houseImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(-20)
            make.top.equalTo(categoryLabel.snp.top)
            make.width.equalTo(120)
            make.height.equalTo(80)
            make.bottom.equalTo(-30)
        }
    }
}
