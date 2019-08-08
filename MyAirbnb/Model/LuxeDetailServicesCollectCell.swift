//
//  LuxeDetailServicesCollectCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/07.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import Kingfisher

class LuxeDetailServicesCollectCell: UICollectionViewCell {
    static let identifier = "LuxeDetailServicesCollectCell"
    
    let mainImageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        self.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(mainImageView.snp.width).multipliedBy(0.65)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(mainImageView.snp.bottom).offset(10)
        }
    }
    
    private func configureViewsOptions() {
        mainImageView.image = UIImage(named: "serviceSample2")
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.masksToBounds = true
        
        titleLabel.text = "Title"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 13, weight: .regular)
    }
    
    func setData(facility: [String]) {
        titleLabel.text = facility[0]
        
        if let url = URL(string: facility[1]){
            mainImageView.kf.setImage(with: url)
        }
    }
}
