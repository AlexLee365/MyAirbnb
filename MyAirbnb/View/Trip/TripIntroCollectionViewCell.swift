//
//  TripIntroCollectionViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class TripIntroCollectionViewCell: UICollectionViewCell {
    static let identifier = "tripIntroCollectionViewCell"
    
    let imageView = UIImageView()
    let categoryLabel = UILabel()
    let titleLabel = UILabel()
    let hostNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        
        categoryLabel.textColor = .white
        categoryLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        contentView.addSubview(categoryLabel)
        
        hostNameLabel.textColor = .white
        hostNameLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        contentView.addSubview(hostNameLabel)
        
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16.5, weight: .heavy)
        contentView.addSubview(titleLabel)
        
    }
    
    private func setAutolayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        categoryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        hostNameLabel.translatesAutoresizingMaskIntoConstraints = false
        hostNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        hostNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.bottomAnchor.constraint(equalTo: hostNameLabel.topAnchor, constant: -10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: hostNameLabel.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85).isActive = true
    }
    
    func setData(representTripData: RepresentationTrip5) {
        imageView.image = UIImage(named: "adventure")
        categoryLabel.text = representTripData.category
        hostNameLabel.text = representTripData.host.username
        titleLabel.text = representTripData.name
    }
}
