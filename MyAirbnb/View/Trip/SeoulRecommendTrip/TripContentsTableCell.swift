//
//  TripContentsTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 27/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class TripContentsTableCell: UITableViewCell {
    static let identifier = "TripContentsTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.configureTripDetailTitle()
        label.text = "트립 내용"
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.configureTripDetailDesc()
        label.text = """
        비건 재료로 배쓰밤 세 개를 함께 만들어 봐요!
        
        # 배쓰밤
        # 색채놀이
        # 아로마테라피
        # 동물실험반대
        
        내가 쓰는 입욕제, 어떻게 만들어지는지 궁금하신가요?
        
        가장 먼저, 비건 재료들에 대해 소개하고 다함께 컨셉을 찾고 배쓰밤을 디자인할거예요! 개인적인 경험이나 스토리를 담아서 만든다면 더욱 의미가 있삽니다 :)
        
        그 다음, 다양한 아로마 오일을 맡아 나만의 추향에 꼭 맞는 향기를 찾도록 도와드릴 거예요. 향과 색을 내 개성에 맞게 골라 이 세상에 단 하나뿐인 비건 배쓰밤을 만들어 봅시다.
        
        만들기가 끝난 뒤엔 다함께 비건 디저트를 먹으며 오늘의 경험에 대해 소소한 대화를 나눠봐요 :)
        """
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
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.leading.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-20)
        }
    }
}
