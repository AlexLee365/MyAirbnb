//
//  PlusIntroCollectionCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 25/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class PlusIntroCollectionCell: UICollectionViewCell {
    static let identifier = "PlusIntroCollectionCell"
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
//        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.font = UIFont(name: StandardUIValue.shared.airbnbMediumFontString, size: 14)
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
        contentView.addSubview(infoLabel)
    }
    
    private func setAutolayout() {
        infoLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
