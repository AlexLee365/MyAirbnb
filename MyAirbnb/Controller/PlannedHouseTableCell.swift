//
//  PlannedHouseTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 07/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class PlannedHouseTableCell: UITableViewCell {
    static let identifier = "PlannedHouseTableCell"
    
    let plannedDateLabel: UILabel = {
        let label = UILabel()
        label.text = "7월 26일 - 7월 31일"
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 15)
        return label
    }()
    
    let houseNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Arakawa-ku"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let representImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "kitchen2")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let leftLineFirstView = UIView()
    let leftLineSecondView = UIView()
    let leftLineCircleView = UIView()
    
    
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
        
        contentView.addSubview(plannedDateLabel)
        contentView.addSubview(houseNameLabel)
        contentView.addSubview(representImageView)
        
        representImageView.contentMode = .scaleAspectFill
        representImageView.layer.masksToBounds = true
        
        leftLineFirstView.backgroundColor = StandardUIValue.shared.colorBlueGreen
        
        leftLineCircleView.backgroundColor = StandardUIValue.shared.colorBlueGreen
        leftLineCircleView.layer.cornerRadius = 4
        leftLineCircleView.layer.masksToBounds = true
        
        leftLineSecondView.backgroundColor = StandardUIValue.shared.colorBlueGreen
    }
    
    private func setAutolayout() {
        let sideMargin: CFloat = 20
        let contentSideMargin: CGFloat = 50
        
        plannedDateLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(contentSideMargin-10)
            make.top.equalTo(25)
        }
        
        houseNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(plannedDateLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentSideMargin)
            make.trailing.equalTo(-30)
        }
        
        representImageView.snp.makeConstraints { (make) in
            make.top.equalTo(houseNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentSideMargin)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(representImageView.snp.width).multipliedBy(0.6)
            make.bottom.equalTo(-20)
        }
        
        self.addSubview(leftLineFirstView)
        leftLineFirstView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalTo(sideMargin)
            make.bottom.equalTo(plannedDateLabel.snp.centerY)
            make.width.equalTo(1.2)
        }
        
        self.addSubview(leftLineCircleView)
        leftLineCircleView.snp.makeConstraints { (make) in
            make.centerX.equalTo(leftLineFirstView.snp.centerX)
            make.centerY.equalTo(plannedDateLabel.snp.centerY)
            make.width.height.equalTo(8)
        }
        
        self.addSubview(leftLineSecondView)
        leftLineSecondView.snp.makeConstraints { (make) in
            make.top.equalTo(plannedDateLabel.snp.centerY)
            make.leading.equalTo(sideMargin)
            make.width.equalTo(1.2)
            make.bottom.equalToSuperview()
        }
    }
    
    func setData(firstHidden: Bool, secondHidden: Bool, reservation: Reservation) {
        leftLineFirstView.isHidden = firstHidden
        leftLineSecondView.isHidden = secondHidden
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        let startDate = dateformatter.date(from: reservation.startDate) ?? Date()
        let endDate = dateformatter.date(from: reservation.endDate) ?? Date()
        
        let componentStart = Calendar.current.dateComponents([.month, .day], from: startDate)
        let componentEnd = Calendar.current.dateComponents([.month, .day], from: endDate)
        
        plannedDateLabel.text = "\(componentStart.month ?? 0)월 \(componentStart.day ?? 0)일 - \(componentEnd.month ?? 0)월 \(componentEnd.day ?? 0)일"
        houseNameLabel.text = reservation.title
        
        if let url = URL(string: reservation.image) {
            representImageView.kf.setImage(with: url)
        }
    }
}
