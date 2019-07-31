//
//  ReserveInfoTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 31/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class ReserveInfoTableCell: UITableViewCell {
    static let identifier = "ReserveInfoTableCell"
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "집 전체"
        label.textColor = StandardUIValue.shared.colorBrown
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 12)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "₩40,000 /박"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 18)
        return label
    }()
    
    let starLabel: UILabel = {
        let label = UILabel()
        label.text = String(repeating: "★", count: 5)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 12)
        label.textColor = StandardUIValue.shared.colorBlueGreen
        return label
    }()
    
    let noOfReviewLabel: UILabel = {
        let label = UILabel()
        label.text = "후기 101개"
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 12)
        return label
    }()
    
    let houseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "luxeHouseSample2")
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
        
        contentView.addSubview(categoryLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(starLabel)
        contentView.addSubview(noOfReviewLabel)
        contentView.addSubview(houseImageView)
    }
    
    private func setAutolayout() {
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.leading.equalTo(20)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
        }
        
        starLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(3)
            make.leading.equalTo(20)
            make.bottom.equalTo(-30)
        }
        
        noOfReviewLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(starLabel.snp.trailing).offset(3)
            make.centerY.equalTo(starLabel.snp.centerY)
        }
        
        houseImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(-20)
            make.top.equalTo(25)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(houseImageView.snp.width).multipliedBy(0.7)
        }
    }
}
