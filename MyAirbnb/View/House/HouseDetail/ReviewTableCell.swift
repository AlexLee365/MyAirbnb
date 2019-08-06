//
//  ReviewTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class ReviewTableCell: UITableViewCell {
    static let identifier = "ReviewTableCell"
    
    let userProfileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "userProfileImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Kiwon"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 17)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2019년 3월"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 15)
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "추천합니다. 도시와 거리는 조금 있습니다만 비엔나를 깊히있게 이해하는 계기가 되었습니다."
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 15)
        label.setLineSpacing(lineSpacing: 3.0)
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
        
        contentView.addSubview(userProfileImage)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(reviewLabel)
    }
    
    private func setAutolayout() {
        userProfileImage.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.leading.equalTo(20)
            make.width.height.equalTo(40)
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.leading.equalTo(userProfileImage.snp.trailing).offset(15)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(3)
            make.leading.equalTo(userNameLabel.snp.leading)
        }
        
        reviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userProfileImage.snp.bottom).offset(15)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-20)
        }
    }
}
