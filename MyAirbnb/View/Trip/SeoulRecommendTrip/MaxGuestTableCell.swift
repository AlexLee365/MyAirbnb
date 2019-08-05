//
//  MaxGuestTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class MaxGuestTableCell: UITableViewCell {
    static let identifier = "MaxGuestTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 17.5)
        return label
    }()
    
    let greaterThanImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "greaterThan")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 14)
        label.numberOfLines = 0
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
        contentView.addSubview(greaterThanImage)
        contentView.addSubview(subLabel)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.leading.equalTo(20)
        }
        
        greaterThanImage.snp.makeConstraints { (make) in
            make.trailing.equalTo(-20)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.height.equalTo(15)
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(20)
            make.trailing.equalTo(greaterThanImage.snp.leading).offset(-25)
            make.bottom.equalTo(-25)
        }
    }
}
