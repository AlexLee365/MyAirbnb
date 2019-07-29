//
//  InfoCategoryView.swift
//  MyAirbnb
//
//  Created by Solji Kim on 30/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class InfoCategoryView: UIView {

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 13)
        label.textColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 17.5)
        label.numberOfLines = 0
        label.textColor = .white
        label.setLineSpacing(lineSpacing: 4.0)
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
        self.backgroundColor = .black
        self.addSubview(iconImageView)
        self.addSubview(categoryTitleLabel)
        self.addSubview(descLabel)
    }
    
    private func setAutolayout() {
        iconImageView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        categoryTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
            make.leading.equalToSuperview()
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryTitleLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
