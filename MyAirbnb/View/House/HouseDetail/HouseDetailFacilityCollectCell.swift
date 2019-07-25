//
//  HouseDetailFacilityCollectCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 22/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HouseDetailFacilityCollectCell: UICollectionViewCell {
    static let identifier = "HouseDetailFacilityCollectCell"
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalTo(self)
        }
        
        titleLabel.configureHouseDetailSubText()
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(facility: String) {
        titleLabel.text = "・ \(facility)"
    }
    
}
