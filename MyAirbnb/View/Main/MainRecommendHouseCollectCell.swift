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
    
    let ratingImageView = UIImageView()
    let ratingAndHostInfoLabel = UILabel()
    lazy var secondStackView = UIStackView(arrangedSubviews: [ratingImageView, ratingAndHostInfoLabel])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        self.addSubview(firstStackView)
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        firstStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 5).isActive = true
        firstStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        firstStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        firstStackView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
    }
    
    private func configureViewsOptions() {
        mainImageView.backgroundColor = .blue
        houseGradeImageView.backgroundColor = .yellow
        
        firstStackView.axis = .horizontal
        firstStackView.alignment = .leading
        firstStackView.distribution = .fillEqually
    }
    
    
}
