//
//  QualifiedHouseTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 18/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class QualifiedHouseTableCell: UITableViewCell {
    static let identifier = "QualifiedHouseTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.8, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "검증된 숙소"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.5)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "에어비앤비 플러스"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "퀄리티와 인테리어 디자인이 검증된 숙소 셀렉션"
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
    
    let subLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.5)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "에어비앤비 Luxe"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descLabel2: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "세심하게 준비된 서비스를 제공하는 엄선된 럭셔리 숙소"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let switchOnOff2: UISwitch = {
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
        self.selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        contentView.addSubview(descLabel)
        switchOnOff.addTarget(self, action: #selector(mySwitchDidChange(_:)), for: .touchUpInside)
        contentView.addSubview(switchOnOff)
        
        contentView.addSubview(subLabel2)
        contentView.addSubview(descLabel2)
        switchOnOff2.addTarget(self, action: #selector(mySwitchDidChange(_:)), for: .touchUpInside)
        contentView.addSubview(switchOnOff2)
    }
    
    @objc private func mySwitchDidChange(_ sender: UISwitch) {
        if switchOnOff.isOn {
            print("on")
        } else {
            print("off")
        }
    }
    
    private func setAutolayout() {
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        subLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 10).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        descLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        
        switchOnOff.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        switchOnOff.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        subLabel2.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 30).isActive = true
        subLabel2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        descLabel2.topAnchor.constraint(equalTo: subLabel2.bottomAnchor, constant: 10).isActive = true
        descLabel2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        descLabel2.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        descLabel2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        
        switchOnOff2.topAnchor.constraint(equalTo: subLabel2.topAnchor).isActive = true
        switchOnOff2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
}
