//
//  ThreePhotoCell.swift
//  MyAirbnb
//
//  Created by 김광준 on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import UIKit

class ThreePhotoCell: UITableViewCell {
    static let identifier = "ThreePhotoCell"
    
    let nationNameLable = UILabel()
    let descriptionLable = UILabel()
    
    let firstImage = UIImageView()
    let secondImage = UIImageView()
    let thirdImage = UIImageView()
    
    //    var threePhotoData = [ThreePhoto]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ThreePhotoCell.identifier)
        
        setupLayout()
        setupConfigure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let sideMargin: CGFloat = StandardUIValue.shared.mainViewSideMargin
        let imageWidth = UIScreen.main.bounds.width
        let imageHeight = imageWidth / 1.7
        let firstImageWidth = UIScreen.main.bounds.width / 1.7
        let subImageWidth = (imageHeight / 2) - 2.5
        
        
        contentView.addSubview(firstImage)
        firstImage.translatesAutoresizingMaskIntoConstraints = false
        firstImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: sideMargin).isActive = true
        firstImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        firstImage.widthAnchor.constraint(equalToConstant: firstImageWidth).isActive = true
        firstImage.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        
        contentView.addSubview(secondImage)
        secondImage.translatesAutoresizingMaskIntoConstraints = false
        secondImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: sideMargin).isActive = true
        secondImage.leadingAnchor.constraint(equalTo: firstImage.trailingAnchor, constant: 5).isActive = true
        secondImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(sideMargin)).isActive = true
        secondImage.widthAnchor.constraint(equalToConstant: subImageWidth).isActive = true
        secondImage.heightAnchor.constraint(equalToConstant: subImageWidth).isActive = true
        
        contentView.addSubview(thirdImage)
        thirdImage.translatesAutoresizingMaskIntoConstraints = false
        thirdImage.topAnchor.constraint(equalTo: secondImage.bottomAnchor, constant: 5).isActive = true
        thirdImage.leadingAnchor.constraint(equalTo: firstImage.trailingAnchor, constant: 5).isActive = true
        thirdImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        thirdImage.widthAnchor.constraint(equalToConstant: subImageWidth).isActive = true
        thirdImage.heightAnchor.constraint(equalToConstant: subImageWidth).isActive = true
        
        contentView.addSubview(nationNameLable)
        nationNameLable.translatesAutoresizingMaskIntoConstraints = false
        nationNameLable.topAnchor.constraint(equalTo: firstImage.bottomAnchor, constant: sideMargin).isActive = true
        nationNameLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        nationNameLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(sideMargin)).isActive = true
        
        contentView.addSubview(descriptionLable)
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.topAnchor.constraint(equalTo: firstImage.bottomAnchor, constant: sideMargin).isActive = true
        descriptionLable.leadingAnchor.constraint(equalTo: nationNameLable.trailingAnchor, constant: 10).isActive = true
        descriptionLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(sideMargin)).isActive = true
        
        
    }
    
    private func setupConfigure() {
        firstImage.contentMode = .scaleAspectFill
        firstImage.clipsToBounds = true
        secondImage.contentMode = .scaleAspectFill
        secondImage.clipsToBounds = true
        thirdImage.contentMode = .scaleAspectFill
        thirdImage.clipsToBounds = true
        
        nationNameLable.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        nationNameLable.textAlignment = .left
        nationNameLable.sizeToFit()
        
        descriptionLable.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.light)
        descriptionLable.textAlignment = .left
        descriptionLable.sizeToFit()
    }
    
    
    func setData(data: ThreePhoto) {
        firstImage.image = data.firstImage
        secondImage.image = data.secondImage
        thirdImage.image = data.thirdImage
    }
}

