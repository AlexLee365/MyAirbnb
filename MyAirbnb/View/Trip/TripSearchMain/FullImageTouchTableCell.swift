//
//  FullImageTouchTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class FullImageTouchTableCell: UITableViewCell {
    static let identifier = "FullImageTouchTableCell"
    
    let fullImageView = FullImageView()
    let detailTitleLabel = UILabel()
    let titleLabel = UILabel()
    let buttonLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        fullImageView.contentMode = .scaleAspectFill
        fullImageView.layer.cornerRadius = 10
        fullImageView.clipsToBounds = true
        fullImageView.layer.masksToBounds = true
        fullImageView.isUserInteractionEnabled = true
        fullImageView.image = UIImage(named: "tripImageTouching")
        contentView.addSubview(fullImageView)
        
        detailTitleLabel.text = "에어비앤비 트립"
        detailTitleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        detailTitleLabel.textColor = .white
        fullImageView.addSubview(detailTitleLabel)
        
        titleLabel.text = "혼자서는 찾기 힘든 장소에서 즐기는 잊을 수 없는 액티비티"
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = .white
        fullImageView.addSubview(titleLabel)

        buttonLabel.text = "자세히 알아보기 ＞"
        buttonLabel.font = .systemFont(ofSize: 14, weight: .bold)
        buttonLabel.textColor = .white
        fullImageView.addSubview(buttonLabel)
    }
    
    private func setAutolayout() {
        fullImageView.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(fullImageView.snp.width).multipliedBy(1.25)
        }
        
        detailTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.leading.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(detailTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.width.equalToSuperview().multipliedBy(0.65)
        }
        
        buttonLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
        
    }
    
    
//    func setData(fullImageData: HouseFullImagDataInList) {
//        titleLabel.text = fullImageData.title
//        fullImageView.image = fullImageData.image
//    }
    
}
