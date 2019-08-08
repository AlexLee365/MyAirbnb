//
//  AllInterestCollectionCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class AllInterestCollectionCell: UICollectionViewCell {
    static let identifier = "AllInterestCollectionCell"
    
    let imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 15)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 14)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.numberOfLines = 0
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
        
        contentView.addSubview(imageView1)
        contentView.addSubview(imageView2)
        contentView.addSubview(imageView3)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
    }
    
    private func setAutolayout() {
        imageView1.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        
        imageView2.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(imageView1.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.height.equalTo(imageView1.snp.height).multipliedBy(0.49)
        }
        
        imageView3.snp.makeConstraints { (make) in
            make.top.equalTo(imageView2.snp.bottom).offset(5)
            make.leading.equalTo(imageView1.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.height.equalTo(imageView2.snp.height)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView1.snp.bottom).offset(15)
            make.leading.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
    }
    
    func setData(subTripCategoryData: SubTripCategory) {
        if let imageUrl = URL(string: subTripCategoryData.image1) {
            imageView1.kf.setImage(with: imageUrl)
        }
        
        if let imageUrl = URL(string: subTripCategoryData.image2 ?? "") {
            imageView2.kf.setImage(with: imageUrl)
        }
        
        if let imageUrl = URL(string: subTripCategoryData.image3 ?? "") {
            imageView3.kf.setImage(with: imageUrl)
        }
        
        titleLabel.text = subTripCategoryData.name
        descLabel.text = subTripCategoryData.subTripCategoryDescription
    }
}


