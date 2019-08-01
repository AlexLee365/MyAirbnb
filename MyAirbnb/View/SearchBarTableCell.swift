//
//  SearchBarTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 26/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class SearchBarTableCell: UITableViewCell {
    static let identifier = "SearchBarTableCell"
    
    let iconImageView = UIImageView()
    let locationTextLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        self.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(17)
        }
        
        self.addSubview(locationTextLabel)
        locationTextLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureViewsOptions() {
        self.selectionStyle = .none
        
        iconImageView.image = UIImage(named: "locationMark")
        iconImageView.contentMode = .scaleAspectFit
        
        locationTextLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        locationTextLabel.textColor = StandardUIValue.shared.colorRegularText
    }
    
}
