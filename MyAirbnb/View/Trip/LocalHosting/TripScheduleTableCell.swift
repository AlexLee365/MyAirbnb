//
//  TripScheduleTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 27/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class TripScheduleTableCell: UITableViewCell {
    static let identifier = "TripScheduleTableCell"
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.setLineSpacing(lineSpacing: 3)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 14)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let programImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.setLineSpacing(lineSpacing: 3)
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 15)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 3)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 14)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
//    let lineImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    let linearView: UIView = {
//        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
//        return view
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
//        contentView.addSubview(lineImage)
//        contentView.addSubview(linearView)
        contentView.addSubview(dayLabel)
        contentView.addSubview(programImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
    }
    
    private func setAutolayout() {
//        lineImage.snp.makeConstraints { (make) in
//            make.top.equalTo(20)
//            make.leading.equalTo(5)
//            make.width.equalTo(10)
//            make.height.equalToSuperview()
//        }
        
//        linearView.snp.makeConstraints { (make) in
//            make.top.equalTo(dayLabel.snp.top)
//            make.leading.equalTo(20)
//            make.width.equalTo(3)
//        }
        
        dayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.leading.equalTo(40)
        }
        
        programImage.snp.makeConstraints { (make) in
            make.top.equalTo(dayLabel.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel.snp.leading)
            make.trailing.equalTo(-20)
            make.height.equalTo(programImage.snp.width).multipliedBy(0.6)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(programImage.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel.snp.leading)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(dayLabel.snp.leading)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-20)
        }
    }
}
