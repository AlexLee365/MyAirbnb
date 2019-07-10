//
//  MainFullImageTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 10/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class MainFullImageTableCell: UITableViewCell {
    static let identifier = "MainFullImageTableCell"
    
    let fullImageView = UIImageView()
    let detailTitleLabel = UILabel()
    let titleLabel = UILabel()
    let buttonLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func setAutoLayout() {
        
        contentView.addSubview(fullImageView)
        let imageWidth = UIScreen.main.bounds.width - (StandardUIValue.shared.mainViewSideMargin * 2)
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        fullImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: StandardUIValue.shared.mainViewSideMargin).isActive = true
        fullImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: StandardUIValue.shared.mainTableViewCellsTopBottomPadding).isActive = true
        fullImageView.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        fullImageView.heightAnchor.constraint(equalTo: fullImageView.widthAnchor, multiplier: 1.25).isActive = true
        fullImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        let topPadding: CGFloat = 15
        fullImageView.addSubview(detailTitleLabel)
        detailTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailTitleLabel.topAnchor.constraint(equalTo: fullImageView.topAnchor, constant: topPadding+5).isActive = true
        detailTitleLabel.leadingAnchor.constraint(equalTo: fullImageView.leadingAnchor, constant: StandardUIValue.shared.mainViewSideMargin).isActive = true
        
        fullImageView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: detailTitleLabel.bottomAnchor, constant: topPadding).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: detailTitleLabel.leadingAnchor).isActive = true
        
        fullImageView.addSubview(buttonLabel)
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding+5).isActive = true
        buttonLabel.leadingAnchor.constraint(equalTo: detailTitleLabel.leadingAnchor).isActive = true
        
    }
    
    private func configureViewsOptions() {
        fullImageView.contentMode = .scaleAspectFill
        fullImageView.layer.cornerRadius = 10
        fullImageView.clipsToBounds = true
        
        detailTitleLabel.text = "에어비앤비 어드벤처를 소개합니다"
        detailTitleLabel.font = .systemFont(ofSize: 11, weight: .regular)
        detailTitleLabel.textColor = .white
        
        titleLabel.text = "계획을 전혀 세우지않고도\n완벽한 여행을 즐기는 법"
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 21, weight: .bold)
        titleLabel.textColor = .white
        
        buttonLabel.text = "자세히보기 ＞"
        buttonLabel.font = .systemFont(ofSize: 13, weight: .bold)
        buttonLabel.textColor = .white
        
    }
  
    
    
}