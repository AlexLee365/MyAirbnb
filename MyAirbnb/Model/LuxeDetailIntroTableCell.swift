//
//  LuxeDetailIntroTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/06.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class LuxeDetailIntroTableCell: UITableViewCell {
    static let identifier = "LuxeDetailIntroTableCell"
    
    // MARK: - UI Properties
    let logoImageView = UIImageView()
    let roomTitleLabel = UILabel()
    let locationLabel = UILabel()
    let separateineView = UIView()
    
//    let introTitleLable = UILabel()
    let descriptionLabel = UILabel()
    let guestNumberLabel = UILabel()
    let hospitalityByLuxuryRetreatsImageView = UIImageView()
    

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
        
        self.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.top.leading.equalTo(sideMargin)
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        self.addSubview(roomTitleLabel)
        roomTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.top.equalTo(logoImageView.snp.bottom).offset(5)
        }
        
        self.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.top.equalTo(roomTitleLabel.snp.bottom).offset(8)
        }
        
        self.addSubview(separateineView)
        separateineView.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.top.equalTo(locationLabel.snp.bottom).offset(40)
            make.height.equalTo(1)
            make.width.equalTo(50)
        }
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.top.equalTo(separateineView.snp.bottom).offset(37)
            make.trailing.equalTo(-sideMargin)
        }
        
        self.addSubview(guestNumberLabel)
        guestNumberLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
        }
        
        self.addSubview(hospitalityByLuxuryRetreatsImageView)
        hospitalityByLuxuryRetreatsImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.top.equalTo(guestNumberLabel.snp.bottom).offset(8)
            make.height.equalTo(30)
            make.width.equalTo(220)
            make.bottom.equalTo(-20)
        }
    }

    
    private func configureViewsOptions() {
        self.selectionStyle = .none
        let textColor = StandardUIValue.shared.colorRegularText
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "LuxeDetailLogo")
        
        roomTitleLabel.text = "Baan Paa Talee"
        roomTitleLabel.textColor = .black
        roomTitleLabel.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 30)
        
        locationLabel.text = "Seoul, Korea"
        locationLabel.textColor = .black
        locationLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        separateineView.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        
        descriptionLabel.text = "그늘에 놓인 선베드에 누워 모더니즘 양식의 저택 아래 소용돌이치는 바다를 감상하세요. 유명 건축가인 아르네 카펜터가 설계한 이 저택은 절벽에 자리잡고 있으며, 뾰족한 지붕, 테라스 전망대, 야외 정자를 갖추고 있습니다."
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = textColor
//        descriptionLabel.font = .systemFont(ofSize: 15, weight: .regular)
        descriptionLabel.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 15)
        descriptionLabel.setLineSpacing(lineSpacing: 6, lineHeightMultiple: 1)
        
        guestNumberLabel.text = "게스트 20명 ・ 침실 9개 ・ 화장실 9개"
        guestNumberLabel.textColor = .black
        guestNumberLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        hospitalityByLuxuryRetreatsImageView.image = UIImage(named: "LuxuryTextImage")
        hospitalityByLuxuryRetreatsImageView.contentMode = .scaleAspectFit
    }
    
    func setData(luxeData: HouseDetailData) {
        roomTitleLabel.text = luxeData.title
        locationLabel.text = "\(luxeData.state), Mexico"
        descriptionLabel.text = luxeData.houseDescription
        descriptionLabel.setLineSpacing(lineSpacing: 6, lineHeightMultiple: 1)
        guestNumberLabel.text = "게스트 \(luxeData.capacity)명 ・ 침실 \(luxeData.bedroom)개 ・ 화장실 \(luxeData.bathroom)개"
    }

}
