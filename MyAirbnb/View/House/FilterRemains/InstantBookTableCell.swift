//
//  InstantBookTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 17/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class InstantBookTableCell: UITableViewCell {
    static let identifier = "InstantBookTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.5)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "즉시 예약"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "호스트의 응답을 기다릴 필요 없이 바로 예약하세요"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let switchOnOff: UISwitch = {
        let onOff = UISwitch()
        onOff.setOn(false, animated: true)
        onOff.onTintColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        onOff.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        switchOnOff.addTarget(self, action: #selector(mySwitchDidChange(_:)), for: .touchUpInside)
        contentView.addSubview(switchOnOff)
    }
    
    @objc private func mySwitchDidChange(_ sender: UISwitch) {
        if switchOnOff.isOn {
            
        } else {
            
        }
    }

    private func setAutolayout() {
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25).isActive = true
        
        switchOnOff.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        switchOnOff.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
}
