//
//  HostAndHouseTypeTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 07/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HostAndHouseTypeTableCell: UITableViewCell {
    static let identifier = "HostAndHouseTypeTableCell"
    
    let houseTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "아파트"
        label.textColor = StandardUIValue.shared.colorBrown
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 15)
        return label
    }()
    
    let hostLabel: UILabel = {
        let label = UILabel()
        label.text = "호스트: Marie님"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 15)
        return label
    }()
    
    let hostImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "hostSample3")
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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
        
        contentView.addSubview(houseTypeLabel)
        contentView.addSubview(hostLabel)
        contentView.addSubview(hostImage)
    }
    
    private func setAutolayout() {
        houseTypeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.leading.equalTo(20)
        }
        
        hostLabel.snp.makeConstraints { (make) in
            make.top.equalTo(houseTypeLabel.snp.bottom)
            make.leading.equalTo(20)
        }
        
        hostImage.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.trailing.bottom.equalTo(-20)
            make.width.height.equalTo(60)
        }
    }
}
