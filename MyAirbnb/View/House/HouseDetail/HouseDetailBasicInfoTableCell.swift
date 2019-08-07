//
//  HouseDetailBasicInfoTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 17/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseDetailBasicInfoTableCell: UITableViewCell {
    static let identifier = "HouseDetailBasicInfoTableCell"
    
    // MARK: - UI Properties
    let typeTopLabel = UILabel()
    let nameLabel = UILabel()
    
    let locationLabel = UILabel()
    let hostNameLabel = UILabel()
    let hostImageView = UIImageView()
    
    let typeIconView = UIImageView()
    let typeLabel = UILabel()
    let typeDetailLabel = UILabel()
    
    let locationIconView = UIImageView()
    let locationInfoLabel = UILabel()
    let locationInfoDetailLabel = UILabel()
    
    let cleanIconView = UIImageView()
    let cleanLabel = UILabel()
    let cleanDetailLabel = UILabel()
    
    let hostInfoIconView = UIImageView()
    let hostInfoLabel = UILabel()
    let hostInfoDetailLabel = UILabel()
    
    let checkInIconView = UIImageView()
    let checkInLabel = UILabel()
    let checkInDetailLabel = UILabel()
    
    
    
    
    // MARK: - Properties
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("--------------------------[HouseDetailBasicInfoTableCell init]--------------------------")
        
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var setLayout = false
    override func layoutSubviews() {
        super.layoutSubviews()
        if setLayout == false, hostImageView.frame.width > 1 {
            hostImageView.layer.cornerRadius = hostImageView.frame.width/2
            setLayout = true
        }
    }
    

    private func setAutoLayout() {
        let sideMargin: CGFloat = StandardUIValue.shared.mainViewSideMargin
        let textLineSpacing: CGFloat = 5
        let categoryLineSpacing: CGFloat = 10
        let iconViewWidth:CGFloat = 22
        
        self.addSubview(typeTopLabel)
        typeTopLabel.translatesAutoresizingMaskIntoConstraints = false
        typeTopLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: StandardUIValue.shared.houseDetailTopBottomMargin).isActive = true
        typeTopLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: typeTopLabel.bottomAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        self.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        
        self.addSubview(hostNameLabel)
        hostNameLabel.translatesAutoresizingMaskIntoConstraints = false
        hostNameLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 2).isActive = true
        hostNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        
        self.addSubview(hostImageView)
        hostImageView.translatesAutoresizingMaskIntoConstraints = false
        hostImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        hostImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin).isActive = true
        hostImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        hostImageView.heightAnchor.constraint(equalTo: hostImageView.widthAnchor, multiplier: 1).isActive = true
        
        
        // 유형
        self.addSubview(typeIconView)
        typeIconView.translatesAutoresizingMaskIntoConstraints = false
        typeIconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        typeIconView.topAnchor.constraint(equalTo: hostNameLabel.bottomAnchor, constant: 50).isActive = true
        typeIconView.widthAnchor.constraint(equalToConstant: iconViewWidth).isActive = true
        typeIconView.heightAnchor.constraint(equalTo: typeIconView.widthAnchor, multiplier: 1).isActive = true
        
        self.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.leadingAnchor.constraint(equalTo: typeIconView.trailingAnchor, constant: sideMargin/2).isActive = true
        typeLabel.bottomAnchor.constraint(equalTo: typeIconView.bottomAnchor).isActive = true
        
        self.addSubview(typeDetailLabel)
        typeDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        typeDetailLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor).isActive = true
        typeDetailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin).isActive = true
        typeDetailLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: textLineSpacing).isActive = true
        
        
        // 위치
        self.addSubview(locationIconView)
        locationIconView.translatesAutoresizingMaskIntoConstraints = false
        locationIconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        locationIconView.topAnchor.constraint(equalTo: typeDetailLabel.bottomAnchor, constant: categoryLineSpacing).isActive = true
        locationIconView.widthAnchor.constraint(equalToConstant: iconViewWidth).isActive = true
        locationIconView.heightAnchor.constraint(equalTo: locationIconView.widthAnchor, multiplier: 1).isActive = true
        
        self.addSubview(locationInfoLabel)
        locationInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        locationInfoLabel.leadingAnchor.constraint(equalTo: locationIconView.trailingAnchor, constant: sideMargin/2).isActive = true
        locationInfoLabel.bottomAnchor.constraint(equalTo: locationIconView.bottomAnchor).isActive = true
        
        self.addSubview(locationInfoDetailLabel)
        locationInfoDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        locationInfoDetailLabel.leadingAnchor.constraint(equalTo: locationInfoLabel.leadingAnchor).isActive = true
        locationInfoDetailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin).isActive = true
        locationInfoDetailLabel.topAnchor.constraint(equalTo: locationInfoLabel.bottomAnchor, constant: textLineSpacing).isActive = true
        
        // 청결도
        self.addSubview(cleanIconView)
        cleanIconView.translatesAutoresizingMaskIntoConstraints = false
        cleanIconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        cleanIconView.topAnchor.constraint(equalTo: locationInfoDetailLabel.bottomAnchor, constant: categoryLineSpacing).isActive = true
        cleanIconView.widthAnchor.constraint(equalToConstant: iconViewWidth).isActive = true
        cleanIconView.heightAnchor.constraint(equalTo: cleanIconView.widthAnchor, multiplier: 1).isActive = true
        
        self.addSubview(cleanLabel)
        cleanLabel.translatesAutoresizingMaskIntoConstraints = false
        cleanLabel.leadingAnchor.constraint(equalTo: cleanIconView.trailingAnchor, constant: sideMargin/2).isActive = true
        cleanLabel.bottomAnchor.constraint(equalTo: cleanIconView.bottomAnchor).isActive = true
        
        self.addSubview(cleanDetailLabel)
        cleanDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        cleanDetailLabel.leadingAnchor.constraint(equalTo: cleanLabel.leadingAnchor).isActive = true
        cleanDetailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin).isActive = true
        cleanDetailLabel.topAnchor.constraint(equalTo: cleanLabel.bottomAnchor, constant: textLineSpacing).isActive = true
        
        // 호스트 정보
        self.addSubview(hostInfoIconView)
        hostInfoIconView.translatesAutoresizingMaskIntoConstraints = false
        hostInfoIconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        hostInfoIconView.topAnchor.constraint(equalTo: cleanDetailLabel.bottomAnchor, constant: categoryLineSpacing).isActive = true
        hostInfoIconView.widthAnchor.constraint(equalToConstant: iconViewWidth).isActive = true
        hostInfoIconView.heightAnchor.constraint(equalTo: hostInfoIconView.widthAnchor, multiplier: 1).isActive = true
        
        self.addSubview(hostInfoLabel)
        hostInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        hostInfoLabel.leadingAnchor.constraint(equalTo: hostInfoIconView.trailingAnchor, constant: sideMargin/2).isActive = true
        hostInfoLabel.bottomAnchor.constraint(equalTo: hostInfoIconView.bottomAnchor).isActive = true
        
        self.addSubview(hostInfoDetailLabel)
        hostInfoDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        hostInfoDetailLabel.topAnchor.constraint(equalTo: hostInfoLabel.bottomAnchor, constant: textLineSpacing).isActive = true
        hostInfoDetailLabel.leadingAnchor.constraint(equalTo: hostInfoLabel.leadingAnchor).isActive = true
        hostInfoDetailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin).isActive = true
        
        // 숙소
        self.addSubview(checkInIconView)
        checkInIconView.translatesAutoresizingMaskIntoConstraints = false
        checkInIconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        checkInIconView.topAnchor.constraint(equalTo: hostInfoDetailLabel.bottomAnchor, constant: categoryLineSpacing).isActive = true
        checkInIconView.widthAnchor.constraint(equalToConstant: iconViewWidth).isActive = true
        checkInIconView.heightAnchor.constraint(equalToConstant: iconViewWidth).isActive = true
        
        self.addSubview(checkInLabel)
        checkInLabel.translatesAutoresizingMaskIntoConstraints = false
        checkInLabel.leadingAnchor.constraint(equalTo: checkInIconView.trailingAnchor, constant: sideMargin/2).isActive = true
        checkInLabel.bottomAnchor.constraint(equalTo: checkInIconView.bottomAnchor).isActive = true
        
        self.addSubview(checkInDetailLabel)
        checkInDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        checkInDetailLabel.topAnchor.constraint(equalTo: checkInLabel.bottomAnchor, constant: textLineSpacing).isActive = true
        checkInDetailLabel.leadingAnchor.constraint(equalTo: checkInLabel.leadingAnchor).isActive = true
        checkInDetailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin).isActive = true
        checkInDetailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -StandardUIValue.shared.houseDetailTopBottomMargin).isActive = true
        
    }
    
    private func configureViewsOptions() {
        self.backgroundColor = .white
        
        typeTopLabel.text = "아파트 전체"
        typeTopLabel.font = .systemFont(ofSize: 12, weight: .bold)
        typeTopLabel.textColor = StandardUIValue.shared.colorBrown
        
        nameLabel.text = "Casavathel1 Athens Center Apartment"
        nameLabel.configureMainTableViewCellsTitle()
        
        locationLabel.text = "아테네, Attica, 그리스"
        setDetailText(locationLabel)
        
        hostNameLabel.text = "호스트: Thelma님"
        setDetailText(hostNameLabel)
        
        hostImageView.image = UIImage(named: "hostSample1")
        hostImageView.contentMode = .scaleAspectFill
        hostImageView.clipsToBounds = true
//        hostImageView.layer.cornerRadius = 40
        
//        typeIconView.backgroundColor = .yellow
        typeIconView.image = UIImage(named: "houseTypeIcon")
        typeIconView.contentMode = .scaleAspectFit
        
        // 유형
        typeLabel.text = "아파트 전체"
        setMainText(typeLabel)
        typeLabel.font = UIFont(name: "AirbnbCerealApp-Bold", size: 14)
        typeLabel.setLineSpacing(lineSpacing: 3.0)
        
        typeDetailLabel.text = "인원 4명 ・ 침실 2개 ・ 침대 2개 ・ 욕실 1개"
        setDetailText(typeDetailLabel)
        typeDetailLabel.font = UIFont(name: "AirbnbCerealApp-Book", size: 13)
        typeDetailLabel.setLineSpacing(lineSpacing: 3.0)
        
        // 위치
//        locationIconView.backgroundColor = .yellow
        locationIconView.image = UIImage(named: "houseLocationIcon")
        locationIconView.contentMode = .scaleAspectFit
        
        locationInfoLabel.text = "훌륭한 숙소 위치"
        setMainText(locationInfoLabel)
        locationInfoLabel.font = UIFont(name: "AirbnbCerealApp-Bold", size: 14)
        locationInfoLabel.setLineSpacing(lineSpacing: 3.0)
        
        locationInfoDetailLabel.text = "최근 숙박한 게스트 중 100%가 위치에 별점 5점을 준 숙소입니다."
        setDetailText(locationInfoDetailLabel)
        locationInfoDetailLabel.font = UIFont(name: "AirbnbCerealApp-Book", size: 13)
        locationInfoDetailLabel.setLineSpacing(lineSpacing: 3.0)
        
        // 청결
//        cleanIconView.backgroundColor = .yellow
        cleanIconView.image = UIImage(named: "houseCleanIcon")
        cleanIconView.contentMode = .scaleAspectFit
        
        cleanLabel.text = "높은 청결도"
        setMainText(cleanLabel)
        cleanLabel.font = UIFont(name: "AirbnbCerealApp-Bold", size: 14)
        cleanLabel.setLineSpacing(lineSpacing: 3.0)
        
        cleanDetailLabel.text = "최근 게스트 13명이 이 숙소가 티 없이 깨끗하다고 후기를 남겼습니다"
        setDetailText(cleanDetailLabel)
        cleanDetailLabel.font = UIFont(name: "AirbnbCerealApp-Book", size: 13)
        cleanDetailLabel.setLineSpacing(lineSpacing: 3.0)
        
        // 호스트 정보
//        hostInfoIconView.backgroundColor = .yellow
        hostInfoIconView.image = UIImage(named: "houseHostInfoIcon")
        hostInfoIconView.contentMode = .scaleAspectFit
        
        hostInfoLabel.text = "Thelma님은 슈퍼호스트입니다"
        setMainText(hostInfoLabel)
        hostInfoLabel.font = UIFont(name: "AirbnbCerealApp-Bold", size: 14)
        hostInfoLabel.setLineSpacing(lineSpacing: 3.0)
        
        hostInfoDetailLabel.text = "슈퍼호스트는 풍부한 경험과 높은 평점을 자랑하며 게스트가 숙소에서 편안히 머무를 수 있도록 최선을 다하는 호스트입니다."
        setDetailText(hostInfoDetailLabel)
        hostInfoDetailLabel.font = UIFont(name: "AirbnbCerealApp-Book", size: 13)
        hostInfoDetailLabel.setLineSpacing(lineSpacing: 3.0)
        
        // 체크인
//        checkInIconView.backgroundColor = .yellow
        checkInIconView.image = UIImage(named: "houseCheckInIcon")
        checkInIconView.contentMode = .scaleAspectFit
        
        checkInLabel.text = "순조로운 체크인 과정"
        setMainText(checkInLabel)
        checkInLabel.font = UIFont(name: "AirbnbCerealApp-Bold", size: 14)
        checkInLabel.setLineSpacing(lineSpacing: 3.0)
        
        checkInDetailLabel.text = "최근 숙박한 게스트 중 100%가 체크인 과정에 별점 5점을 준 숙소입니다."
        setDetailText(checkInDetailLabel)
        checkInDetailLabel.font = UIFont(name: "AirbnbCerealApp-Book", size: 13)
        checkInDetailLabel.setLineSpacing(lineSpacing: 3.0)
        
    }
    
    private func setMainText(_ label: UILabel) {
        label.textColor = StandardUIValue.shared.colorRegularText
        label.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private func setDetailText(_ label: UILabel) {
        label.textColor = StandardUIValue.shared.colorRegularText
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
    }
    
    func setData(type: String, name: String, state: String, hostName: String, hostImage: UIImage?, capacity: Int, bedroom: Int, bathroom: Int) {
        typeTopLabel.text = type
        nameLabel.text = name
        locationLabel.text = "\(state), South Korea"
        hostNameLabel.text = "호스트: \(hostName)님"
        hostImageView.image = hostImage ?? UIImage(named: "hostSample2")
        typeLabel.text = type
        typeDetailLabel.text = "인원 \(capacity)명 ・ 침실 \(bedroom)개 ・ 침대 \(bedroom)개 ・ 욕실 \(bathroom)개"
    }
}
