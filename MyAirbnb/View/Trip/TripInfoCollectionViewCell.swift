//
//  TripInfoCollectionViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 07/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import Kingfisher

class TripInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "tripInfoCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let heartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noOfReviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        contentView.addSubview(imageView)
        
        contentView.addSubview(heartButton)
        
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(languageLabel)
        
        contentView.addSubview(starImage)
        contentView.addSubview(rateLabel)
        contentView.addSubview(noOfReviewLabel)
    }
    
    private func setAutolayout() {
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.58).isActive = true
        
        heartButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 5).isActive = true
        heartButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -5).isActive = true
        heartButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        heartButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        descLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        
        languageLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 5).isActive = true
        languageLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        
        starImage.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 10).isActive = true
        starImage.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        starImage.widthAnchor.constraint(equalToConstant: 11).isActive = true
        starImage.heightAnchor.constraint(equalToConstant: 11).isActive = true
        
        rateLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor).isActive = true
        rateLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 3).isActive = true
        
        noOfReviewLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor).isActive = true
        noOfReviewLabel.leadingAnchor.constraint(equalTo: rateLabel.trailingAnchor, constant: 5).isActive = true
    }
    
    func setData(recommendedTripData: BestTrip) {
        imageView.image = UIImage(named: "bathbomb")
        
        if recommendedTripData.detailCategory != "" {
            categoryLabel.text = recommendedTripData.detailCategory
        } else {
            categoryLabel.text = "트립"
        }
        
        titleLabel.text = recommendedTripData.name
        
        if !recommendedTripData.provides.isEmpty {
            var text = ""
            
            for i in 0..<recommendedTripData.provides.count {
                text += "\(recommendedTripData.provides[i] ?? ""), "
            }
            text.removeLast()
            text.removeLast()
            
            descLabel.text = "\(recommendedTripData.durationTime)시간 · \(text) 포함"
        } else {
            descLabel.text = "\(recommendedTripData.durationTime)시간"
        }
        
        languageLabel.text = "\(recommendedTripData.language)로 진행"

        if recommendedTripData.ratingScore > 0.0 {
            starImage.image = UIImage(named: "star")
            rateLabel.text = String(recommendedTripData.ratingScore)
            noOfReviewLabel.text = "(\(recommendedTripData.reviewCount))"
        }
    }
    
    func setDataForAllTrip(allTripData: AllTripData) {
        imageView.image = UIImage(named: "bathbomb")
        
//        if allTripData.detailCategory != "" {
//            categoryLabel.text = allTripData.detailCategory
//        } else {
//            categoryLabel.text = "트립"
//        }
        
        titleLabel.text = allTripData.name
        
        if !allTripData.provides.isEmpty {
            var text = ""
            
            for i in 0..<allTripData.provides.count {
                text += "\(allTripData.provides[i] ?? ""), "
            }
            text.removeLast()
            text.removeLast()
            
            descLabel.text = "\(allTripData.durationTime)시간 · \(text) 포함"
        } else {
            descLabel.text = "\(allTripData.durationTime)시간"
        }
        
        languageLabel.text = "\(allTripData.language)로 진행"
        
        if allTripData.ratingScore > 0.0 {
            starImage.image = UIImage(named: "star")
            rateLabel.text = String(allTripData.ratingScore)
//            noOfReviewLabel.text = "(\(allTripData.reviewCount))"
        }
    }
}
