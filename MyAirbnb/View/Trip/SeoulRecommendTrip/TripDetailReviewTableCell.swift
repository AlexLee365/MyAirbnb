//
//  TripDetailReviewTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

protocol TripDetailReviewTableCellDelegate: class {
    func presentTripDetailReviewVC()
}

class TripDetailReviewTableCell: UITableViewCell {
    static let identifier = "TripDetailReviewTableCell"

    weak var delegate: TripDetailReviewTableCellDelegate?
    
    let userProfileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 17)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 14)
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 16)
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
        label.numberOfLines = 0
        label.textColor = StandardUIValue.shared.colorBlueGreen
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 15.5)
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
            make.top.equalTo(userProfileImage.snp.top)
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
    
    func setData(tripReviewData: TripReview, tripData: TripDetail) {
        userProfileImage.image = UIImage(named: "userProfileImage")
        userNameLabel.text = tripReviewData.userSet
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateformatter.date(from: tripReviewData.createdAt) ?? Date()
        
        let reviewDate = Calendar.current.dateComponents([.year, .month], from: date)
        
        dateLabel.text = "\(reviewDate.year ?? 0)년 \(reviewDate.month ?? 0)월"
        reviewLabel.text = tripReviewData.tripReviewDescription
        readBtnLabel.text = "후기 \(tripData.tripReviews.count)개 읽기"
    }
    
    @objc private func readReviewBtnDidTap(_ sender: UIButton) {
        delegate?.presentTripDetailReviewVC()
    }
}

