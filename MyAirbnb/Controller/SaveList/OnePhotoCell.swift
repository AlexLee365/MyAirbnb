//
//  OnePhotoCell.swift
//  MyAirbnb
//
//  Created by 김광준 on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import UIKit

class OnePhotoCell: UITableViewCell {
    static let identifier = "OnePhotoCell"
    
    let nationNameLable = UILabel()
    let descriptionLable = UILabel()
    let firstImage = UIImageView()
    
    //    var onePhotoData = [OnePhoto]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: OnePhotoCell.identifier)
        
        setupLayout()
        setupConfigure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        let titleLableWidth = UIScreen.main.bounds.width
        let imageWidth = UIScreen.main.bounds.width - (StandardUIValue.shared.mainViewSideMargin * 2)
        let sideMargin: CGFloat = StandardUIValue.shared.mainViewSideMargin
        let imageHeight = imageWidth / 1.7
        
        contentView.addSubview(firstImage)
        firstImage.translatesAutoresizingMaskIntoConstraints = false
        firstImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        firstImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        firstImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(sideMargin)).isActive = true
        firstImage.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        
        contentView.addSubview(nationNameLable)
        nationNameLable.translatesAutoresizingMaskIntoConstraints = false
        nationNameLable.topAnchor.constraint(equalTo: firstImage.bottomAnchor, constant: 20).isActive = true
        nationNameLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        nationNameLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
        contentView.addSubview(descriptionLable)
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.topAnchor.constraint(equalTo: firstImage.bottomAnchor, constant: 20).isActive = true
        descriptionLable.leadingAnchor.constraint(equalTo: nationNameLable.trailingAnchor, constant: 10).isActive = true
        descriptionLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
    }
    
    private func setupConfigure() {
        
        firstImage.contentMode = .scaleAspectFill
        firstImage.clipsToBounds = true
        
        nationNameLable.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        nationNameLable.textAlignment = .left
        nationNameLable.sizeToFit()
        
        descriptionLable.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.light)
        descriptionLable.textAlignment = .left
        descriptionLable.sizeToFit()
    }
    
    func setData(onePhotoData: OnePhoto) {
        firstImage.image = onePhotoData.firstImage
    }
}

