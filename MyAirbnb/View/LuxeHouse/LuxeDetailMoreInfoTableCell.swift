//
//  LuxeDetailMoreInfoTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/07.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import SnapKit

class LuxeDetailMoreInfoTableCell: UITableViewCell {
    static let identifier = "LuxeDetailMoreInfoTableCell"
    
    let logoImageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let seeMoreLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        let sideMargin = StandardUIValue.shared.mainViewSideMargin * 2
        
        self.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(60)
            make.leading.equalTo(sideMargin)
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.leading.equalTo(sideMargin)
            make.trailing.equalTo(-sideMargin)
        }
        
        self.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalTo(sideMargin)
            make.trailing.equalTo(-sideMargin)
        }
        
        self.addSubview(seeMoreLabel)
        seeMoreLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(25)
            make.bottom.equalTo(-50)
        }
    }
    
    private func configureViewsOptions() {
        self.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.6109803082)
        self.selectionStyle = .none
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "LuxeDetailLogo")
        
        titleLabel.text = "모든 것이 5성급인 특별한 숙소"
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 22)
        
        subtitleLabel.text = "Airbnb Luxe는 고급 편의시설, 서비스, 전담 여행 디자이너를 갖추고 최상의 관리 상태와 전문적인 디자인을 자랑하는 숙소를 제공합니다."
        subtitleLabel.textColor = StandardUIValue.shared.colorRegularText
        subtitleLabel.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 15)
        subtitleLabel.setLineSpacing(lineSpacing: 5, lineHeightMultiple: 1)
        subtitleLabel.numberOfLines = 0
        
        seeMoreLabel.text = "자세히 알아보기 >"
        seeMoreLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        seeMoreLabel.textColor = StandardUIValue.shared.colorPurple
    }
}
