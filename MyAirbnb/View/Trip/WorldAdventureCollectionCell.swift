//
//  WorldAdventureCollectionCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 30/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class WorldAdventureCollectionCell: UICollectionViewCell {
    static let identifier = "WorldAdventureCollectionCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    let heartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "heart"), for: .normal)
        return button
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    let starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        return label
    }()
    
    let noOfReviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
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
        contentView.addSubview(imageView)
        contentView.addSubview(heartButton)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(starImage)
        contentView.addSubview(rateLabel)
        contentView.addSubview(noOfReviewLabel)
    }
    
    private func setAutolayout() {
        imageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        heartButton.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.top).offset(5)
            make.trailing.equalTo(imageView.snp.trailing).offset(-5)
            make.width.height.equalTo(20)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(imageView.snp.leading)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom).offset(5)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.trailing)
        }
        
        starImage.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(imageView.snp.leading)
            make.width.height.equalTo(11)
        }
        
        rateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(starImage.snp.centerY)
            make.leading.equalTo(starImage.snp.trailing).offset(3)
        }
        
        noOfReviewLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(starImage.snp.centerY)
            make.leading.equalTo(rateLabel.snp.trailing).offset(5)
        }
    }
    
    func setData(worldAdventureData: BestTrip) {
//        imageView.image = UIImage(named: "worldAdventure1")
        let imageUrl = URL(string: worldAdventureData.image1 ?? "")
        imageView.kf.setImage(with: imageUrl)
        
        categoryLabel.text = "\(worldAdventureData.durationTime)일 여행 코스 · 푸에르토아요라"
        titleLabel.text = worldAdventureData.name
        
        if worldAdventureData.ratingScore > 0.0 {
            starImage.image = UIImage(named: "star")
            rateLabel.text = String(worldAdventureData.ratingScore)
            noOfReviewLabel.text = String(worldAdventureData.reviewCount)
        }
    }
}
