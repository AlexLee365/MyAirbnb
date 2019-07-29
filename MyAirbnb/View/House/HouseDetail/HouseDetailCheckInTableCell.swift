//
//  HouseDetailCheckInTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 22/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HouseDetailCheckInTableCell: UITableViewCell {
    static let identifier = "HouseDetailCheckInTableCell"
    
    let checkInLabel = UILabel()
    let centerImageView = UIImageView()
    let checkOutLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        let topBottomMargin = StandardUIValue.shared.houseDetailTopBottomMargin
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        self.addSubview(checkInLabel)
        checkInLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topBottomMargin)
            make.leading.equalTo(sideMargin)
        }
        
        self.addSubview(centerImageView)
        centerImageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        self.addSubview(checkOutLabel)
        checkOutLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(-sideMargin)
            make.top.equalTo(topBottomMargin)
            make.bottom.equalTo(-topBottomMargin)
        }
    }
    
    private func configureViewsOptions() {
        configureTitleText(checkInLabel)
        checkInLabel.text = "체크인\n14:00 이후"
        
        centerImageView.image = UIImage(named: "diagnoalLine")
        centerImageView.contentMode = .scaleAspectFit
        
        configureTitleText(checkOutLabel)
        checkOutLabel.textAlignment = .right
        checkOutLabel.text = "체크아웃\n11:00"
    }
    
    private func configureTitleText(_ label: UILabel) {
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.textColor = StandardUIValue.shared.colorBoldText
        label.numberOfLines = 0
    }
    
    func setData(checkIn: String, checkOut: String) {
        checkInLabel.text = "체크인\n14:00 이후"
        checkOutLabel.text = "체크아웃\n11:00"
    }
    

}
