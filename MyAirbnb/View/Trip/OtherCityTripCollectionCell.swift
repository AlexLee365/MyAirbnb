//
//  OtherCityTripCollectionCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 30/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class OtherCityTripCollectionCell: UICollectionViewCell {
    static let identifier = "OtherCityTripCollectionCell"
    
    let otherCityImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 14)
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
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
        self.contentView.backgroundColor = .white
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 8
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        
        contentView.addSubview(otherCityImage)
        contentView.addSubview(cityNameLabel)
    }
    
    private func setAutolayout() {
        otherCityImage.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        cityNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(otherCityImage.snp.bottom).offset(10)
            make.leading.equalTo(15)
            make.bottom.equalTo(-10)
        }
    }
    
    func setData(cityListArray: State) {
        cityNameLabel.text = cityListArray.name
    }
}
