//
//  StepThreeTitleTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class StepThreeTitleTableCell: UITableViewCell {
    static let identifier = "StepThreeTitleTableCell"
    
    let stepLabel: UILabel = {
        let label = UILabel()
        label.text = "3/3단계"
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 16)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "확인 및 결제"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 27)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Vienna의 집 전체"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 15)
        return label
    }()
    
    let bookingInfo: UILabel = {
        let label = UILabel()
        label.text = "8월 29일~30일, 게스트 1명"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 15)
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
        
        contentView.addSubview(stepLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(bookingInfo)
        contentView.addSubview(houseImageView)
    }
    
    private func setAutolayout() {
        stepLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(stepLabel.snp.bottom).offset(3)
            make.leading.equalTo(20)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalTo(20)
        }
        
        bookingInfo.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom).offset(5)
            make.leading.equalTo(20)
        }
        
        houseImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(-20)
            make.top.equalTo(categoryLabel.snp.top)
            make.width.equalTo(80)
            make.height.equalTo(60)
            make.bottom.equalTo(-30)
        }
    }
    
    func setData(houseData: HouseDetailData , selecteData: ([Date], Int)) {
        let componentOfFirstDay = Calendar.current.dateComponents([.month, .day], from: selecteData.0.first ?? Date())
        let componentOfLastDay = Calendar.current.dateComponents([.month, .day], from: selecteData.0.last ?? Date())
        
        
        categoryLabel.text = "\( (houseData.host.first ?? "") ?? "" )님의 \(houseData.roomType)"
        bookingInfo.text = "\(componentOfFirstDay.month ?? 0)월 \(componentOfFirstDay.day ?? 0)일 ~ \(componentOfLastDay.month ?? 0)월 \(componentOfLastDay.day ?? 0)일, 게스트 \(selecteData.1)명 "
        guard let url = URL(string: houseData.image ?? "") else { print("‼️ : "); return }
        houseImageView.kf.setImage(with: url)
    }
}
