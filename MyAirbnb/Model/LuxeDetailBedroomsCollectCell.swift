//
//  LuxeDetailBedroomsCollectCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/07.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class LuxeDetailBedroomsCollectCell: UICollectionViewCell {
    static let identifier = "LuxeDetailBedroomsCollectCell"

    let mainImageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLable = UILabel()
    
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
        
        self.addSubview(subtitleLable)
        subtitleLable.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.trailing.equalTo(-5)
            
        }
    }
    
    private func configureViewsOptions() {
        mainImageView.image = UIImage(named: "house3")
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        
        titleLabel.text = "침대"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        subtitleLable.text = "TV, 실내 욕실, 킹사이즈 침대"
        subtitleLable.textColor = .black
        subtitleLable.font = .systemFont(ofSize: 12, weight: .regular)
        subtitleLable.numberOfLines = 2
    }
    
    func setData(titleText: String, imageUrlString: String) {
        titleLabel.text = titleText
        if let url = URL(string: imageUrlString) {
            mainImageView.kf.setImage(with: url)
        }
    }
}
