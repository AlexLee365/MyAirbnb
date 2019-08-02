//
//  RefundPolicyTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class RefundPolicyTableCell: UITableViewCell {
    static let identifier = "RefundPolicyTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "환불 정책: 엄격"
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 14)
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "체크인 30일 전까지 예약을 취소하면 전액 환불됩니다. 그 이후 체크인 전에 취소하면 50%가 환불됩니다."
        label.numberOfLines = 0
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 14)
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
        contentView.addSubview(descLabel)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(20)
            make.trailing.bottom.equalTo(-20)
        }
    }
}
