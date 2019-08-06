//
//  CheckInOutInfoTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 31/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class CheckInOutInfoTableCell: UITableViewCell {
    static let identifier = "CheckInOutInfoTableCell"
    
    let checkInLabel: UILabel = {
        let label = UILabel()
        label.text = "체크인"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 12)
        return label
    }()
    
    let checkInDateLabel: UILabel = {
        let label = UILabel()
        label.text = "10월 24일"
        label.textColor = StandardUIValue.shared.colorBlueGreen
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 18)
        return label
    }()
    
    let checkOutLabel: UILabel = {
        let label = UILabel()
        label.text = "체크아웃"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 12)
        return label
    }()
    
    let checkOutDateLabel: UILabel = {
        let label = UILabel()
        label.text = "10월 29일"
        label.textColor = StandardUIValue.shared.colorBlueGreen
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 18)
        return label
    }()
    
    let peopleLabel: UILabel = {
        let label = UILabel()
        label.text = "인원"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 12)
        return label
    }()
    
    let noOfGuestLabel: UILabel = {
        let label = UILabel()
        label.text = "게스트 1명"
        label.textColor = StandardUIValue.shared.colorBlueGreen
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 18)
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
        
        contentView.addSubview(checkInLabel)
        contentView.addSubview(checkInDateLabel)
        contentView.addSubview(checkOutLabel)
        contentView.addSubview(checkOutDateLabel)
        contentView.addSubview(peopleLabel)
        contentView.addSubview(noOfGuestLabel)
    }
    
    private func setAutolayout() {
        checkInLabel.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.leading.equalTo(20)
        }
        
        checkOutLabel.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.centerX.equalToSuperview()
        }
        
        peopleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.trailing.equalTo(-20)
        }
        
        checkInDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(checkInLabel.snp.bottom).offset(5)
            make.leading.equalTo(20)
        }
        
        checkOutDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(checkOutLabel.snp.bottom).offset(5)
            make.centerX.equalTo(checkOutLabel.snp.centerX)
        }
        
        noOfGuestLabel.snp.makeConstraints { (make) in
            make.top.equalTo(peopleLabel.snp.bottom).offset(5)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-20)
        }
    }
    
    func setData(selectedData: ([Date], Int)) {
        let componentsIn = Calendar.current.dateComponents([.month, .day], from: selectedData.0.first ?? Date())
        checkInDateLabel.text = "\(componentsIn.month ?? 0)월 \(componentsIn.day ?? 0)일"
        let componentsOut = Calendar.current.dateComponents([.month, .day], from: selectedData.0.last ?? Date())
        checkOutDateLabel.text = "\(componentsOut.month ?? 0)월 \(componentsOut.day ?? 0)일"
        noOfGuestLabel.text = "게스트 \(selectedData.1)명"
    }
}
