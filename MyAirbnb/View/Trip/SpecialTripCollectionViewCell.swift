//
//  SpecialTripCollectionViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 07/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import Kingfisher

class SpecialTripCollectionViewCell: UICollectionViewCell {
    static let identifier = "specialTripCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.numberOfLines = 0
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
        
        self.contentView.backgroundColor = .white
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 8
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
    }
    
    private func setAutolayout() {
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setData(mainCategoryData: MainCategory) {
        let imageUrl = URL(string: mainCategoryData.image ?? "")
        imageView.kf.setImage(with: imageUrl)
        titleLabel.text = mainCategoryData.name
        descLabel.text = mainCategoryData.mainCategoryDescription
    }
}
