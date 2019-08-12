//
//  LuxeDetailImagesTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/07.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class LuxeDetailImagesTableCell: UITableViewCell {
    static let identifier = "LuxeDetailImagesTableCell"
    
    let firstFullImageView = UIImageView()
    let secondSmallImageView = UIImageView()
    let thirdSmallImageView = UIImageView()
    let fourthLognImageView = UIImageView()
    let fifthSmallImageView = UIImageView()
    let sixthSmallImageView = UIImageView()
    
    let seeAllBtn = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        let spacing: CGFloat = 12
        let smallImageWidth = (UIScreen.main.bounds.width - 40 - spacing) / 2
        let smallImageHeight = smallImageWidth * 0.65
        
        self.addSubview(firstFullImageView)
        firstFullImageView.snp.makeConstraints { (make) in
            make.top.leading.equalTo(sideMargin)
            make.trailing.equalTo(-sideMargin)
            make.height.equalTo(firstFullImageView.snp.width).multipliedBy(0.65)
        }
        self.addSubview(secondSmallImageView)
        secondSmallImageView.snp.makeConstraints { (make) in
            make.top.equalTo(firstFullImageView.snp.bottom).offset(spacing)
            make.leading.equalTo(sideMargin)
            make.width.equalTo(smallImageWidth)
            make.height.equalTo(smallImageHeight)
        }
        
        self.addSubview(thirdSmallImageView)
        thirdSmallImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.top.equalTo(secondSmallImageView.snp.bottom).offset(spacing)
            make.width.equalTo(smallImageWidth)
            make.height.equalTo(smallImageHeight)
        }
        
        self.addSubview(fourthLognImageView)
        fourthLognImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(secondSmallImageView.snp.trailing).offset(spacing)
            make.trailing.equalTo(-sideMargin)
            make.top.equalTo(firstFullImageView.snp.bottom).offset(spacing)
            make.height.equalTo(smallImageHeight * 2 + spacing)
        }
        
        self.addSubview(fifthSmallImageView)
        fifthSmallImageView.snp.makeConstraints { (make) in
            make.top.equalTo(thirdSmallImageView.snp.bottom).offset(spacing)
            make.leading.equalTo(sideMargin)
            make.width.equalTo(smallImageWidth)
            make.height.equalTo(smallImageHeight)
        }
        
        self.addSubview(sixthSmallImageView)
        sixthSmallImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(fifthSmallImageView.snp.trailing).offset(spacing)
            make.trailing.equalTo(-sideMargin)
            make.top.equalTo(fourthLognImageView.snp.bottom).offset(spacing)
            make.height.equalTo(smallImageHeight)
//            make.bottom.equalTo(-20)
        }
        
        self.addSubview(seeAllBtn)
        seeAllBtn.snp.makeConstraints { (make) in
            make.top.equalTo(sixthSmallImageView.snp.bottom).offset(35)
            make.leading.equalTo(sideMargin)
            make.trailing.equalTo(-sideMargin)
            make.height.equalTo(seeAllBtn.snp.width).multipliedBy(0.135)
//            make.bottom.equalTo(-60)
        }
        
    }
    
    private func configureViewsOptions() {
        self.selectionStyle = .none
        
        firstFullImageView.contentMode = .scaleAspectFill
        firstFullImageView.image = UIImage(named: "roomSample1")
        firstFullImageView.clipsToBounds = true
        
        secondSmallImageView.contentMode = .scaleAspectFill
        secondSmallImageView.image = UIImage(named: "roomSample2")
        secondSmallImageView.clipsToBounds = true
        
        thirdSmallImageView.contentMode = .scaleAspectFill
        thirdSmallImageView.image = UIImage(named: "roomSample3")
        thirdSmallImageView.clipsToBounds = true
        
        fourthLognImageView.contentMode = .scaleAspectFill
        fourthLognImageView.image = UIImage(named: "roomSample4")
        fourthLognImageView.clipsToBounds = true
        
        fifthSmallImageView.contentMode = .scaleAspectFill
        fifthSmallImageView.image = UIImage(named: "roomSample5")
        fifthSmallImageView.clipsToBounds = true
        
        sixthSmallImageView.contentMode = .scaleAspectFill
        sixthSmallImageView.image = UIImage(named: "house1")
        sixthSmallImageView.clipsToBounds = true
        
        seeAllBtn.setTitle("사진 모두 보기", for: .normal)
        seeAllBtn.setTitleColor(StandardUIValue.shared.colorPurple, for: .normal)
        seeAllBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        seeAllBtn.layer.borderColor = StandardUIValue.shared.colorPurple.cgColor
        seeAllBtn.layer.borderWidth = 1
        seeAllBtn.layer.cornerRadius = 5
        seeAllBtn.clipsToBounds = true
    }
    
    func setData(luxeData: HouseDetailData) {
        if let url = URL(string: luxeData.image1 ?? "") {
            firstFullImageView.kf.setImage(with: url)
        }
        if let url = URL(string: luxeData.image2 ?? "") {
            secondSmallImageView.kf.setImage(with: url)
        }
        if let url = URL(string: luxeData.image3 ?? "") {
            thirdSmallImageView.kf.setImage(with: url)
        }
        if let url = URL(string: luxeData.image4 ?? "") {
            fourthLognImageView.kf.setImage(with: url)
        }
        if let url = URL(string: luxeData.image5 ?? "") {
            fifthSmallImageView.kf.setImage(with: url)
        }
        if let url = URL(string: luxeData.image6 ?? "") {
            sixthSmallImageView.kf.setImage(with: url)
        }
    }
    
    

}
