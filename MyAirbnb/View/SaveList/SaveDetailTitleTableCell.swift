//
//  SaveDetailTitleTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 08/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class SaveDetailTitleTableCell: UITableViewCell {
    static let identifier = "SaveDetailTitleTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Yeonnam-dong, Mapo-gu"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.numberOfLines = 0
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 30)
        return label
    }()
    
    let subInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "모든 날짜 · 게스트 1명 · 비공개"
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 15)
        return label
    }()
    
    let inviteBtn: UIButton = {
        let button = UIButton()
        button.setTitle(" 친구 초대 + ", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "AirbnbCerealApp-Medium", size: 14)
        button.layer.cornerRadius = 15
        button.layer.borderColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        button.layer.borderWidth = 1
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Properties
    
    private func configure() {
        self.selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subInfoLabel)
        contentView.addSubview(inviteBtn)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.leading.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        subInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(20)
        }
        
        inviteBtn.snp.makeConstraints { (make) in
            make.top.equalTo(subInfoLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.height.equalTo(35)
            make.width.equalTo(100)
            make.bottom.equalTo(-20)
        }
    }
}
