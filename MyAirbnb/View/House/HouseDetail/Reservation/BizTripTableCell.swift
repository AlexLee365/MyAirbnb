//
//  BizTripTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 31/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class BizTripTableCell: UITableViewCell {
    static let identifier = "BizTripTableCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "출장입니다."
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 18)
        return label
    }()
    
    let switchOnOff: UISwitch = {
        let onOff = UISwitch()
        onOff.setOn(false, animated: true)
        onOff.onTintColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        return onOff
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
        contentView.addSubview(label)
        
        switchOnOff.addTarget(self, action: #selector(mySwitchDidChange(_:)), for: .touchUpInside)
        contentView.addSubview(switchOnOff)
    }
    
    private func setAutolayout() {
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
        }
        
        switchOnOff.snp.makeConstraints { (make) in
            make.centerY.equalTo(label.snp.centerY)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-20)
        }
    }
    
    @objc private func mySwitchDidChange(_ sender: UISwitch) {
        
    }
}
