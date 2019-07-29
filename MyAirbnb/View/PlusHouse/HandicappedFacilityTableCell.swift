//
//  HandicappedFacilityTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 26/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HandicappedFacilityTableCell: UITableViewCell {
    static let identifier = "HandicappedFacilityTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "장애인 편의시설"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "이 숙소의 호스트는 숙소의 장애인 이용 편의성을 점검하였습니다."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let majorAmenityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "주요 편의시설"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let seeAllBtn: UIButton = {
        let button = UIButton()
        button.setTitle("편의시설 11개 보기", for: .normal)
        button.setTitleColor(StandardUIValue.shared.colorWine, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    let amenitiesArray = ["주요 출입문까지 계단이나 문턱 없이 이동 가능", "주요 출입문까지 이어지는 넓은 복도", "현관까지 통로에 충분한 조명"]
    
    var amenityLabelsArray = [(UILabel, UILabel)]()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
        setAmenityLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(majorAmenityTitleLabel)
        contentView.addSubview(seeAllBtn)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.leading.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-30)
        }
        
        majorAmenityTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(30)
            make.leading.equalTo(20)
        }
        
        seeAllBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalToSuperview()
        }
    }
    
    
    private func setAmenityLabel() {
        for i in 0..<amenitiesArray.count {
            
            let bulletLabel: UILabel = {
                let label = UILabel()
                label.text = "·"
                label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
                return label
            }()
            
            let amenityLabel: UILabel = {
                let label = UILabel()
                label.text = amenitiesArray[i]
                label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
                label.font = UIFont.systemFont(ofSize: 16.5)
                return label
            }()
            
            amenityLabelsArray.append((bulletLabel, amenityLabel))
        }
        
        for i in 0..<amenityLabelsArray.count {
            contentView.addSubview(amenityLabelsArray[i].0)
            contentView.addSubview(amenityLabelsArray[i].1)
            
            amenityLabelsArray[i].0.snp.makeConstraints { (make) in
                make.leading.equalTo(20)
            }
            
            amenityLabelsArray[i].1.snp.makeConstraints { (make) in
                make.centerY.equalTo(amenityLabelsArray[i].0.snp.centerY)
                make.leading.equalTo(amenityLabelsArray[i].0.snp.trailing).offset(3)
            }
            
            switch i {
            case 0:
                amenityLabelsArray[i].0.snp.makeConstraints { (make) in
                    make.top.equalTo(majorAmenityTitleLabel.snp.bottom).offset(15)
                }
                
                amenityLabelsArray[i].1.snp.makeConstraints { (make) in
                    make.top.equalTo(majorAmenityTitleLabel.snp.bottom).offset(15)
                }
                
            case amenityLabelsArray.count - 1:
                amenityLabelsArray[i].0.snp.makeConstraints { (make) in
                    make.bottom.equalTo(seeAllBtn.snp.top).offset(-20)
                }
                fallthrough
                
            default:
                amenityLabelsArray[i].0.snp.makeConstraints { (make) in
                    make.top.equalTo(amenityLabelsArray[i - 1].0.snp.bottom).offset(10)
                }
                
                amenityLabelsArray[i].1.snp.makeConstraints { (make) in
                    make.top.equalTo(amenityLabelsArray[i - 1].1.snp.bottom).offset(10)
                }
            }
        }
    }
}
