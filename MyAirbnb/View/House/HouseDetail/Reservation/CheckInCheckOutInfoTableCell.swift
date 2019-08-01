//
//  CheckInCheckOutInfoTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class CheckInCheckOutInfoTableCell: UITableViewCell {
    static let identifier = "CheckInCheckOutInfoTableCell"
    
    let checkInView = CheckInOutInfoView()
    let checkOutView = CheckInOutInfoView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        checkInView.monthLabel.text = "8월"
        checkInView.dateLabel.text = "17일"
        checkInView.dayLabel.text = "토요일"
        checkInView.checkInOutLabel.text = "check in"
        checkInView.timeLabel.text = "15:00 이후"
        contentView.addSubview(checkInView)
        
        checkOutView.monthLabel.text = "8월"
        checkOutView.dateLabel.text = "19일"
        checkOutView.dayLabel.text = "월요일"
        checkOutView.checkInOutLabel.text = "check out"
        checkOutView.timeLabel.text = "10:00"
        contentView.addSubview(checkOutView)
    }
    
    private func setAutolayout() {
        checkInView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        checkOutView.snp.makeConstraints { (make) in
            make.top.equalTo(checkInView.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.bottom.equalTo(-20)
        }
    }
}


class CheckInOutInfoView: UIView {
    let dateContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return view
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 11)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 16)
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 15)
        return label
    }()
    
    let checkInOutLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 15)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 16)
        return label
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
        self.addSubview(dateContainerView)
        dateContainerView.addSubview(monthLabel)
        dateContainerView.addSubview(dateLabel)
        
        self.addSubview(dayLabel)
        self.addSubview(checkInOutLabel)
        self.addSubview(timeLabel)
    }
    
    private func setAutolayout() {
        dateContainerView.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        monthLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(8)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(monthLabel.snp.bottom).offset(3)
            make.bottom.equalTo(-8)
        }
        
        dayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.leading.equalTo(dateContainerView.snp.trailing).offset(15)
        }
        
        checkInOutLabel.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.leading.equalTo(dayLabel.snp.trailing).offset(3)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dayLabel.snp.bottom).offset(3)
            make.leading.equalTo(dayLabel.snp.leading)
        }
    }
}
