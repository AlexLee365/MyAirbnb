//
//  TripScheduleTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 27/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

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
    
    let lineTopView = UIView()
    let lineView = UIView()
    let lineCircleView = UIView()
    
    var tripTotalDays = 0
    var currentIndex = 0
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
//        switch currentIndex {
//        case 5:
//            lineTopView.isHidden = true
//        case tripTotalDays + 4:
//            lineView.isHidden = true
//        default: break
//        }
    }
    
    private func configure() {
        self.selectionStyle = .none
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(programImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)

        lineView.backgroundColor = .gray
        contentView.addSubview(lineView)
        
        lineTopView.backgroundColor = .gray
        contentView.addSubview(lineTopView)

        lineCircleView.backgroundColor = .white
        lineCircleView.layer.borderWidth = 1.2
        lineCircleView.layer.borderColor = UIColor.gray.cgColor
        lineCircleView.clipsToBounds = true
        lineCircleView.layer.cornerRadius = 3.0
        contentView.addSubview(lineCircleView)
    }
    
    private func setAutolayout() {
        dayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(5)
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
        
        lineTopView.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.top.equalToSuperview()
            make.width.equalTo(1.2)
            make.bottom.equalTo(dayLabel.snp.centerY)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.width.equalTo(1.2)
            make.top.equalTo(dayLabel.snp.centerY)
            make.bottom.equalToSuperview()
        }
        
        lineCircleView.snp.makeConstraints { (make) in
            make.centerX.equalTo(lineView.snp.centerX)
            make.centerY.equalTo(dayLabel.snp.centerY)
            make.width.height.equalTo(6)
        }
    }
    
    func setData(additionalScheduleData: AdditionalSchedule) {
            dayLabel.text = "\(additionalScheduleData.day)일차 · \(currentIndex - 4)번째 액티비티"
            
            let imageUrl = URL(string: additionalScheduleData.image1)
            programImage.kf.setImage(with: imageUrl)
            
            titleLabel.text = ""
            descLabel.text = additionalScheduleData.additionalScheduleDescription
//        }
    }
}
