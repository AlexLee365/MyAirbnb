//
//  FourSquareCollectCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import Kingfisher

class FourSquareCollectCell: UICollectionViewCell {
    static let identifier = "FourSquareCollectCell"
    
    let mainImageView = UIImageView()
    let likeBtn = UIButton()
    
    let detailLabel = UILabel()
    let houseNameLabel = UILabel()
    
    let ratingImageLabel = UILabel()
    let ratingAndHostInfoLabel = UILabel()
    lazy var ratingStackView = UIStackView(arrangedSubviews: [ratingImageLabel, ratingAndHostInfoLabel])
    

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
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55).isActive = true
        
        mainImageView.addSubview(likeBtn)
        likeBtn.translatesAutoresizingMaskIntoConstraints = false
        likeBtn.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 5).isActive = true
        likeBtn.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -5).isActive = true
        likeBtn.widthAnchor.constraint(equalToConstant: 16).isActive = true
        likeBtn.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        self.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 5).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        
        self.addSubview(houseNameLabel)
        houseNameLabel.translatesAutoresizingMaskIntoConstraints = false
        houseNameLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 5).isActive = true
        houseNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        houseNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.addSubview(ratingStackView)
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.topAnchor.constraint(equalTo: houseNameLabel.bottomAnchor, constant: 7).isActive = true
        ratingStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        ratingStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ratingStackView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        ratingImageLabel.centerYAnchor.constraint(equalTo: ratingStackView.centerYAnchor).isActive = true
        ratingAndHostInfoLabel.centerYAnchor.constraint(equalTo: ratingStackView.centerYAnchor).isActive = true
        
       
        
    }
    
    private func configureViewsOptions() {
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.masksToBounds = true
        mainImageView.layer.cornerRadius = 2
        mainImageView.image = UIImage(named: "roomImage")
        
        likeBtn.setImage(UIImage(named: "heart"), for: .normal)
        
        detailLabel.text = "저택전체 ・ 이아(OIA)"
        detailLabel.font = .systemFont(ofSize: 8, weight: .bold)
        detailLabel.textColor = #colorLiteral(red: 0.5516145825, green: 0.2798806429, blue: 0.08037244529, alpha: 0.8247806079)
        detailLabel.textAlignment = .left
        
        houseNameLabel.text = "Charming, Cozy Casita with Desert Garden and apart. terrace"
        houseNameLabel.numberOfLines = 2
        houseNameLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        houseNameLabel.textColor = #colorLiteral(red: 0.3221844435, green: 0.3202747703, blue: 0.3236560524, alpha: 1)
        
        ratingStackView.axis = .horizontal
        ratingStackView.distribution = .fill
        ratingStackView.alignment = .leading
        ratingStackView.spacing = 5
        
        ratingImageLabel.text = String(repeating: "★", count: 5)
        ratingImageLabel.textColor = UIColor(red:0.09, green:0.51, blue:0.54, alpha:1.0)
        ratingImageLabel.font = .systemFont(ofSize: 5, weight: .regular)
        
        ratingAndHostInfoLabel.text = "40 ・ 슈퍼호스트"
        ratingAndHostInfoLabel.font = .systemFont(ofSize: 8, weight: .regular)
        ratingAndHostInfoLabel.textColor = #colorLiteral(red: 0.3221844435, green: 0.3202747703, blue: 0.3236560524, alpha: 1)
    }
    
    func setData(houseData: HouseDataInList) {
//        mainImageView.image = houseData.imageArray.first ?? UIImage(named: "houseSample")
        detailLabel.text = "\(houseData.roomType) ・ \(houseData.state)"
        houseNameLabel.text = houseData.title
        ratingImageLabel.text = houseData.drawStarsWithHouseRate()
        ratingAndHostInfoLabel.text = "\(houseData.reservations) ・ \(houseData.superHost ?? "일반 호스트")"
        guard let url = URL(string: houseData.image) else { print("‼️ url convert error "); return }
        mainImageView.kf.setImage(with: url)
    }
    
    
}
