//
//  HouseDetailBedRoomsCollectCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 22/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HouseDetailBedRoomsCollectCell: UICollectionViewCell {
    static let identifier = "HouseDetailBedRoomsCollectCell"
    
    let iconView = UIImageView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        self.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.centerY.equalTo(self.snp.centerY).offset(-25)
            make.leading.equalTo(self).offset(sideMargin)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(10)
            make.leading.equalTo(self).offset(sideMargin)
        }
        
        self.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(self).offset(sideMargin)
        }
    }
    
    
    private func configureViewsOptions() {
        self.layer.cornerRadius = 7
        self.layer.borderColor = #colorLiteral(red: 0.7850933671, green: 0.7804276347, blue: 0.7886807919, alpha: 0.2230308219)
        self.layer.borderWidth = 1
        
        iconView.image = UIImage(named: "bedroomSample1")
        iconView.contentMode = .scaleAspectFit
        
        titleLabel.configureHouseDetailMainText()
        titleLabel.text = "공용 공간"
        
        subTitleLabel.configureHouseDetailSubText()
        subTitleLabel.text = "퀸사이즈 침대 1개"
    }
}
