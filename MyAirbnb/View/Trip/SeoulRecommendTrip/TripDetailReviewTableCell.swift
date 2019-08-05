//
//  TripDetailReviewTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class TripDetailReviewTableCell: UITableViewCell {
    static let identifier = "TripDetailReviewTableCell"

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
            make.top.equalTo(userProfileImage.snp.top)
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
            make.bottom.equalTo(-20)
        }
    }
    
    func setData(tripReviewData: TripReview) {
        userNameLabel.text = tripReviewData.userSet
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateformatter.date(from: tripReviewData.createdAt) ?? Date()
        
        let reviewDate = Calendar.current.dateComponents([.year, .month], from: date)
        
        dateLabel.text = "\(reviewDate.year ?? 0)년 \(reviewDate.month ?? 0)월"
        reviewLabel.text = tripReviewData.tripReviewDescription
    }
}

