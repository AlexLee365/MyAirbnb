//
//  HousePlusCollectionCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 14/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import Kingfisher

class HousePlusCollectionCell: UICollectionViewCell {
    static let identifier = "HousePlusCollectionCell"
    
    let mainImageView = UIImageView()
    let likeBtn = LikeButton(contentID: 0, contentType: .room)
    
    let houseGradeImageView = UIImageView()
    let dateAndGuestLabel = UILabel()
    lazy var firstStackView = UIStackView(arrangedSubviews: [houseGradeImageView, dateAndGuestLabel])
    
    let houseNameLabel = UILabel()
    
    let ratingImageLabel = UILabel()
    let ratingAndHostInfoLabel = UILabel()
    lazy var secondStackView = UIStackView(arrangedSubviews: [ratingImageLabel, ratingAndHostInfoLabel])
    
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
        mainImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        
        mainImageView.addSubview(likeBtn)
        likeBtn.translatesAutoresizingMaskIntoConstraints = false
        likeBtn.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 2).isActive = true
        likeBtn.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -5).isActive = true
        likeBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        likeBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.addSubview(firstStackView)
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        firstStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 5).isActive = true
        firstStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        firstStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        firstStackView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        houseGradeImageView.centerYAnchor.constraint(equalTo: firstStackView.centerYAnchor).isActive = true
        houseGradeImageView.heightAnchor.constraint(equalTo: firstStackView.heightAnchor).isActive = true
        dateAndGuestLabel.centerYAnchor.constraint(equalTo: firstStackView.centerYAnchor).isActive = true
        
        self.addSubview(houseNameLabel)
        houseNameLabel.translatesAutoresizingMaskIntoConstraints = false
        houseNameLabel.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 5).isActive = true
        houseNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        houseNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.addSubview(secondStackView)
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        secondStackView.topAnchor.constraint(equalTo: houseNameLabel.bottomAnchor, constant: 7).isActive = true
        secondStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        secondStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        secondStackView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        ratingImageLabel.centerYAnchor.constraint(equalTo: secondStackView.centerYAnchor).isActive = true
        ratingAndHostInfoLabel.centerYAnchor.constraint(equalTo: secondStackView.centerYAnchor).isActive = true
    }
    
    private func configureViewsOptions() {
        
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.image = UIImage(named: "houseSample")
        mainImageView.layer.masksToBounds = true
        mainImageView.layer.cornerRadius = 3
        mainImageView.isUserInteractionEnabled = true
        
        likeBtn.setImage(UIImage(named: "heart"), for: .normal)
        likeBtn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        firstStackView.axis = .horizontal
        firstStackView.alignment = .leading
        firstStackView.distribution = .fill
        firstStackView.spacing = 3
        
        houseGradeImageView.image = UIImage(named: "houseGrade_Plus")
        houseGradeImageView.contentMode = .scaleAspectFit
        houseGradeImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        dateAndGuestLabel.text = "7월14일 - 7월17일 ・ 게스트 2명"
        dateAndGuestLabel.font = .systemFont(ofSize: 10, weight: .bold)
        dateAndGuestLabel.textColor = #colorLiteral(red: 0.386121124, green: 0.02965694666, blue: 0.2658225596, alpha: 0.7088505993)
        dateAndGuestLabel.textAlignment = .left
        
        houseNameLabel.text = "Charming, Cozy Casita with Desert Garden and apart. terrace"
        houseNameLabel.numberOfLines = 2
        houseNameLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        houseNameLabel.textColor = #colorLiteral(red: 0.3221844435, green: 0.3202747703, blue: 0.3236560524, alpha: 1)
        
        secondStackView.axis = .horizontal
        secondStackView.alignment = .leading
        secondStackView.spacing = 5
        
        ratingImageLabel.text = String(repeating: "★", count: 5)
        ratingImageLabel.textColor = #colorLiteral(red: 0.386121124, green: 0.02965694666, blue: 0.2658225596, alpha: 0.7088505993)
        ratingImageLabel.font = .systemFont(ofSize: 10, weight: .regular)
        
        ratingAndHostInfoLabel.text = "215 ・ 슈퍼호스트"
        ratingAndHostInfoLabel.font = .systemFont(ofSize: 11, weight: .regular)
        ratingAndHostInfoLabel.textColor = #colorLiteral(red: 0.3221844435, green: 0.3202747703, blue: 0.3236560524, alpha: 1)
    }
    
    func setData(plusHouseData: HouseDataInList) {  // HOusePlusDataInList
        if let url = URL(string: plusHouseData.image) {
            mainImageView.kf.setImage(with: url)
        }
        
        dateAndGuestLabel.text = "검증됨 ・ \(plusHouseData.state)"
        houseNameLabel.text = plusHouseData.title
        ratingImageLabel.text = plusHouseData.drawStarsWithHouseRate()
        ratingAndHostInfoLabel.text = "\(plusHouseData.reservations) ・ 슈퍼호스트"
        likeBtn.resetContentIDAndTypeAndHouseData(contentID: plusHouseData.id, contentType: .room, houseData: plusHouseData)
    }
}

