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
    }
}
