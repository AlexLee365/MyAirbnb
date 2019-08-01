//
//  HouseDetailReviewTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

protocol HouseDetailReviewTableCellDelegate: class {
    func presentReviewVC()
}

class HouseDetailReviewTableCell: UITableViewCell {
    static let identifier = "HouseDetailReviewTableCell"
    
    weak var delegate: HouseDetailReviewTableCellDelegate?
    
    let userProfileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "userProfileImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Kiwon"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 14)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2019년 3월"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 14)
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
    
    let clearBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    let readBtnLabel: UILabel = {
        let label = UILabel()
        label.text = "후기 253개 읽기"
        label.numberOfLines = 0
        label.textColor = StandardUIValue.shared.colorBlueGreen
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 16)
        return label
    }()
    
    let starLabel: UILabel = {
        let label = UILabel()
        label.text = String(repeating: "★", count: 5)
        label.textColor = StandardUIValue.shared.colorBlueGreen
        label.font = .systemFont(ofSize: 12, weight: .regular)
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
        
        clearBtn.addTarget(self, action: #selector(readReviewBtnDidTap(_:)), for: .touchUpInside)
        contentView.addSubview(clearBtn)
        
        contentView.addSubview(readBtnLabel)
        contentView.addSubview(starLabel)
    }
    
    private func setAutolayout() {
        userProfileImage.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.leading.equalTo(20)
            make.width.height.equalTo(50)
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.leading.equalTo(userProfileImage.snp.trailing).offset(15)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(3)
            make.leading.equalTo(userNameLabel.snp.leading)
        }
        
        reviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userProfileImage.snp.bottom).offset(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        clearBtn.snp.makeConstraints { (make) in
            make.top.equalTo(reviewLabel.snp.bottom)
            make.height.equalTo(80)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        readBtnLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(clearBtn.snp.centerY)
            make.leading.equalTo(20)
        }
        
        starLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(clearBtn.snp.centerY)
            make.trailing.equalTo(-20)
        }
    }
    
    @objc private func readReviewBtnDidTap(_ sender: UIButton) {
        delegate?.presentReviewVC()
    }
}
