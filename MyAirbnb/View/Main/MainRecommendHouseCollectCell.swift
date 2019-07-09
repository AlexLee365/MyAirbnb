//
//  MainRecommendHouseCollectCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 09/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class MainRecommendHouseCollectCell: UICollectionViewCell {
    static let identifier = "MainRecommendHouseCollectCell"
    
    // MARK: - UI Properties
    let mainImageView = UIImageView()
    
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
        mainImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55).isActive = true
        
        self.addSubview(firstStackView)
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        firstStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 5).isActive = true
        firstStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        firstStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        firstStackView.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
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
        secondStackView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        ratingImageLabel.centerYAnchor.constraint(equalTo: secondStackView.centerYAnchor).isActive = true
        ratingAndHostInfoLabel.centerYAnchor.constraint(equalTo: secondStackView.centerYAnchor).isActive = true
    }
    
    private func configureViewsOptions() {
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.masksToBounds = true
        mainImageView.layer.cornerRadius = 2
        
        firstStackView.axis = .horizontal
        firstStackView.alignment = .leading
        firstStackView.distribution = .fill
        firstStackView.spacing = 3
        
        houseGradeImageView.image = UIImage(named: "houseGradeSample_PlusP")
        houseGradeImageView.contentMode = .scaleAspectFit
        houseGradeImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        dateAndGuestLabel.text = "7월14일 - 7월17일 ・ 게스트 2명"
        dateAndGuestLabel.font = .systemFont(ofSize: 8, weight: .bold)
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
        ratingImageLabel.font = .systemFont(ofSize: 5, weight: .regular)
        
        ratingAndHostInfoLabel.text = "215 ・ 슈퍼호스트"
        ratingAndHostInfoLabel.font = .systemFont(ofSize: 8, weight: .regular)
        ratingAndHostInfoLabel.textColor = #colorLiteral(red: 0.3221844435, green: 0.3202747703, blue: 0.3236560524, alpha: 1)
        
        
        
        
        
    }
    
    
}
