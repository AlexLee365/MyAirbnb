//
//  ImagesCollectionTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 29/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ImagesCollectionTableCell: UITableViewCell {
    static let identifier = "ImagesCollectionTableCell"
    
    let firstImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let secondImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let thirdImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let fourthImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let fifthImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let sixthImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let seventhImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.selectionStyle = .none
        
        contentView.addSubview(firstImage)
        contentView.addSubview(secondImage)
        contentView.addSubview(thirdImage)
        contentView.addSubview(fourthImage)
        contentView.addSubview(fifthImage)
        contentView.addSubview(sixthImage)
        contentView.addSubview(seventhImage)
    }
    
    private func setAutolayout() {
        let width = UIScreen.main.bounds.width
        
        firstImage.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.leading.equalTo(20)
            make.width.height.equalTo(width - 40)
        }
        
        secondImage.snp.makeConstraints { (make) in
            make.top.equalTo(firstImage.snp.bottom).offset(10)
            make.leading.equalTo(firstImage.snp.leading)
            make.width.equalTo(((width - 40) / 2) - 5)
            make.height.equalTo(secondImage.snp.width).multipliedBy(0.7)
        }
        
        thirdImage.snp.makeConstraints { (make) in
            make.top.equalTo(firstImage.snp.bottom).offset(10)
            make.trailing.equalTo(firstImage.snp.trailing)
            make.width.equalTo(((width - 40) / 2) - 5)
            make.height.equalTo(thirdImage.snp.width).multipliedBy(0.7)
        }
        
        fourthImage.snp.makeConstraints { (make) in
            make.top.equalTo(secondImage.snp.bottom).offset(10)
            make.leading.equalTo(secondImage.snp.leading)
            make.width.equalTo(secondImage.snp.width)
            make.height.equalTo(fourthImage.snp.width).multipliedBy(1.4)
        }
        
        fifthImage.snp.makeConstraints { (make) in
            make.top.equalTo(thirdImage.snp.bottom).offset(10)
            make.trailing.equalTo(thirdImage.snp.trailing)
            make.width.equalTo(thirdImage.snp.width)
            make.height.equalTo(fifthImage.snp.width).multipliedBy(1.4)
        }
        
        sixthImage.snp.makeConstraints { (make) in
            make.top.equalTo(fourthImage.snp.bottom).offset(10)
            make.leading.equalTo(fourthImage.snp.leading)
            make.width.equalTo(secondImage.snp.width)
            make.height.equalTo(secondImage.snp.height)
        }
        
        seventhImage.snp.makeConstraints { (make) in
            make.top.equalTo(fifthImage.snp.bottom).offset(10)
            make.trailing.equalTo(fifthImage.snp.trailing)
            make.width.equalTo(thirdImage.snp.width)
            make.height.equalTo(thirdImage.snp.height)
            make.bottom.equalTo(-20)
        }
    }
    
    func setData(tripAdditionalData: Additional) {
        if let imageUrl = URL(string: tripAdditionalData.image1) {
            firstImage.kf.setImage(with: imageUrl)
        }
        if let imageUrl = URL(string: tripAdditionalData.image2) {
            secondImage.kf.setImage(with: imageUrl)
        }
        if let imageUrl = URL(string: tripAdditionalData.image3) {
            thirdImage.kf.setImage(with: imageUrl)
        }
        if let imageUrl = URL(string: tripAdditionalData.image4) {
            fourthImage.kf.setImage(with: imageUrl)
        }
        if let imageUrl = URL(string: tripAdditionalData.image5) {
            fifthImage.kf.setImage(with: imageUrl)
        }
        if let imageUrl = URL(string: tripAdditionalData.image6) {
            sixthImage.kf.setImage(with: imageUrl)
        }
        if let imageUrl = URL(string: tripAdditionalData.image7) {
            seventhImage.kf.setImage(with: imageUrl)
        }
        
    }
}
