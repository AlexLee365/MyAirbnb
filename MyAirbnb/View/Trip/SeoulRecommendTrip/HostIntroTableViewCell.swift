//
//  HostIntroTableViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 10/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HostIntroTableViewCell: UITableViewCell {
    static let identifier = "hostIntroTableViewCell"
    
    let hostIntroLabel: UILabel = {
        let label = UILabel()
        label.configureTripDetailTitle()
        label.text = "호스트 Hana님 소개"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "hana")
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let touchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let messageButton: UIButton = {
        let button = UIButton()
        button.setTitle("메시지", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let introBody: UILabel = {
        let label = UILabel()
        label.configureTripDetailDesc()
        label.numberOfLines = 0
        label.text =
        """
        안녕하세요. 저는 비건 화장품 '멜릭서’의 대표 이하나입니다.
        멜릭서는 100% 식물성 성분만을 사용하며, 화장품 동물실험에 반대하는 비건 화장품 브랜드입니다.
        
        "내가 매일 사용하는 화장품으로도 환경에 기여할 수있을까?"
        
        저는 지난 6년동안 화장품 회사에서 일을 하면서 수없이 생산되는 화장품들을 접했습니다. 오랜 시간에걸쳐 사람들이 조금 더 예뻐지기 위한 - 피부 미용을 위한 제품인 '화장품’의 생산 과정들을 알게 되었습니다.
        
        그 과정에서 발생하는 많은 플라스틱으로 인한 환경 파괴와 동물 학대에 대해 알게되었고, 비거니즘을 화장품에 적용하면 어떨까라는 생각을 했습니다. 그래서 동물의 희생도 줄이고 또 동시에 피부에도 좋은 비건 화장품 브랜드를 만들게 되었습니다.
        
        멜릭서는 비건이라는 생소한 분야를 알리고 비건 커뮤니티를 더 키워가고 싶어 이 클래스를 시작하였습니다 :)
        """
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.selectionStyle = .none
        
        contentView.addSubview(hostIntroLabel)
        contentView.addSubview(profileImage)
        contentView.addSubview(touchButton)
        contentView.addSubview(messageButton)
        contentView.addSubview(introBody)
    }

    
    private func setAutolayout() {
        
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        hostIntroLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        hostIntroLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        
        profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        profileImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideMargin).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        touchButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        touchButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        touchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        touchButton.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        messageButton.topAnchor.constraint(equalTo: hostIntroLabel.bottomAnchor, constant: 15).isActive = true
        messageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        
        introBody.topAnchor.constraint(equalTo: touchButton.bottomAnchor, constant: 5).isActive = true
        introBody.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        introBody.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideMargin).isActive = true
        introBody.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
    
    func setData(hostDetailData: TripDetail) {
        hostIntroLabel.text = "호스트 \(hostDetailData.host)님 소개"
        introBody.text = hostDetailData.hostAbout
    }
}
