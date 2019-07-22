//
//  HouseDetailIntroductionTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 19/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseDetailIntroductionTableCell: UITableViewCell {
    static let identifier = "HouseDetailIntroductionTableCell"
    
     let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let topBottomMargin = StandardUIValue.shared.houseDetailTopBottomMargin
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: topBottomMargin).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -topBottomMargin).isActive = true
        
        label.configureHouseDetailSubText()
        label.text = """
        숙소· 1700 년의 화려한 베수비 아나 (Vesuviana)의 빌라에서 숙박 및 아침 식사. 로얄 버본 꿩 (RoyalBourbon Pheasantry), 로얄 팰리스 포르 티치 (RoyalPalace of Portici)의 일부입니다. 그것은 욕실, 와이파이 인터넷, 에어컨, 주차장과 3 개의 침실이 있습니다. 투숙객은 대형 정원, 골동품 가구가있는 객실, 지붕 일광 욕실을 이용하실 수 있습니다. B & B Villa SanGennariello는 폼페이 (Pompeii), 나폴리 (Naples),소렌토 (Sorrento), 카프리 (Capri) 및 이스 키아(Ichia)의 캠 피 플레 그레이 (Campi Flegrei) 여행에 이상적입니다. Herculaneum의 고고 학적 발굴은 도보 거리 (10 분) 내에 있습니다. Double Room 또는 Double Single Use : 크고 맑은 객실로 전용 욕실, 골동품 가구, 에어컨, wifi 인터넷, Tv-Dig / Sat, DVD. 킹 사이즈 침대 또는 트윈; 세 번째 참침대 추가 가능성. \n주니어 스위트 : 킹 사이즈 침대 / 트윈 침대, 더블 소파 침대 및 싱글 침대, 전용 욕실, 골동품 가구, 에어컨, wifi 인터넷, Tv-Dig / Sat, DVD. 가족 최대 5 인까지 투숙 할수 있습니다. \n독립성 : 개인 출입구가있는 평면, 더블 / 트윈 침대 및 싱글 침대가있는 객실, 전용 욕실, 정원 및 정원을 조망할 수있는 작은 테라스, 에어컨, TV - 토. 장기 투숙에 좋습니다.
        """
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
