//
//  AverageReviewRateTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class AverageReviewRateTableCell: UITableViewCell {
    static let identifier = "AverageReviewRateTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "후기 253개"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 28)
        label.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        return label
    }()
    
    let starLabel: UILabel = {
        let label = UILabel()
        label.text = String(repeating: "★", count: 5)
        label.textColor = StandardUIValue.shared.colorBlueGreen
        label.font = .systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    let rateCategoryArr = ["정확성", "의사소통", "청결도", "위치", "체크인", "가치"]
    var averageRatePerCategoryViewArr = [UIView]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(starLabel)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.leading.equalTo(20)
        }
        
        starLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
        }
        
        setAverageRateLabel()
    }
    
    private func setAverageRateLabel() {
        for i in 0..<rateCategoryArr.count {
            let view = ReviewRatingView()
            
            view.ratingTypeLabel.text = rateCategoryArr[i]
            view.starLabel.text = String(repeating: "★", count: 5)
            
            averageRatePerCategoryViewArr.append(view)
        }
        
        for i in 0..<averageRatePerCategoryViewArr.count {
            contentView.addSubview(averageRatePerCategoryViewArr[i])
            
            averageRatePerCategoryViewArr[i].snp.makeConstraints { (make) in
                make.leading.equalTo(20)
                make.trailing.equalTo(-20)
            }
            
            switch i {
            case 0:
                averageRatePerCategoryViewArr[i].snp.makeConstraints { (make) in
                    make.top.equalTo(starLabel.snp.bottom).offset(15)
                }
            case averageRatePerCategoryViewArr.count - 1:
                averageRatePerCategoryViewArr[i].snp.makeConstraints { (make) in
                    make.bottom.equalTo(-15)
                }
                fallthrough
            default:
                averageRatePerCategoryViewArr[i].snp.makeConstraints { (make) in
                    make.top.equalTo(averageRatePerCategoryViewArr[i-1].snp.bottom).offset(15)
                }
            }
        }
    }
}

class ReviewRatingView: UIView {
    
    let ratingTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 13)
        label.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        return label
    }()
    
    let starLabel: UILabel = {
        let label = UILabel()
        label.textColor = StandardUIValue.shared.colorBlueGreen
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(ratingTypeLabel)
        self.addSubview(starLabel)
    }
    
    private func setAutolayout() {
        ratingTypeLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview()
        }
        
        starLabel.snp.makeConstraints { (make) in
            make.top.trailing.bottom.equalToSuperview()
        }
    }
}
