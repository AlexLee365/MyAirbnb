//
//  MainCategoryCollectCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 08/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit



class MainCategoryCollectCell: UICollectionViewCell {
    static let identifier = "mainCategoryCollectCell"
    
    let mainImageView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        contentView.addSubview(mainImageView)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6).isActive = true
        
        let leftMargin: CGFloat = 10
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leftMargin).isActive = true
        
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leftMargin).isActive = true
    }
    
    private func configureViewsOptions() {
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 3
        self.contentView.backgroundColor = .white
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 3
        
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.masksToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        titleLabel.textColor = .black
        
        detailLabel.font = .systemFont(ofSize: 11, weight: .bold)
        detailLabel.textColor = .lightGray
    }
    
    var setLayout = false
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        if setLayout == false {
            
        }
    }
    
    func setData(_ category: Category) {
        mainImageView.image = category.image
        titleLabel.text = category.title
        detailLabel.text = category.subTitle
    }
    
    
    

}
