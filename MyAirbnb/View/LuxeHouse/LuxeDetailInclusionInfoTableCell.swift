//
//  LuxeDetailInclusionInfoTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/07.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class LuxeDetailInclusionInfoTableCell: UITableViewCell {
    static let identifier = "LuxeDetailInclusionInfoTableCell"
    
    // MARK: - UI Properties
    let titleLabel = UILabel()
    
    let planImageView = UIImageView()
    let planLabel = UILabel()
    let planSubLabel = UILabel()
    
    let evaluationImageView = UIImageView()
    let evaluationLabel = UILabel()
    let evaluationSubLabel = UILabel()
    
    let supportImageView = UIImageView()
    let supportLabel = UILabel()
    let supportSubLabel = UILabel()
    
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
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.top.equalTo(40)
            make.trailing.equalTo(-sideMargin)
        }
        
        self.addSubview(planImageView)
        planImageView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(sideMargin)
            make.trailing.equalTo(-sideMargin)
            make.height.equalTo(planImageView.snp.width).multipliedBy(0.65)
        }
        
        self.addSubview(planLabel)
        planLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.top.equalTo(planImageView.snp.bottom).offset(15)
        }
        
        self.addSubview(planSubLabel)
        planSubLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.trailing.equalTo(-sideMargin)
            make.top.equalTo(planLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(evaluationImageView)
        evaluationImageView.snp.makeConstraints { (make) in
            make.top.equalTo(planSubLabel.snp.bottom).offset(40)
            make.leading.equalTo(sideMargin)
            make.trailing.equalTo(-sideMargin)
            make.height.equalTo(evaluationImageView.snp.width).multipliedBy(0.65)
        }
        
        self.addSubview(evaluationLabel)
        evaluationLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.top.equalTo(evaluationImageView.snp.bottom).offset(15)
        }
        
        self.addSubview(evaluationSubLabel)
        evaluationSubLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.trailing.equalTo(-sideMargin)
            make.top.equalTo(evaluationLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(supportImageView)
        supportImageView.snp.makeConstraints { (make) in
            make.top.equalTo(evaluationSubLabel.snp.bottom).offset(40)
            make.leading.equalTo(sideMargin)
            make.trailing.equalTo(-sideMargin)
            make.height.equalTo(supportImageView.snp.width).multipliedBy(0.65)
        }
        
        self.addSubview(supportLabel)
        supportLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.top.equalTo(supportImageView.snp.bottom).offset(15)
        }
        
        self.addSubview(supportSubLabel)
        supportSubLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.trailing.equalTo(-sideMargin)
            make.top.equalTo(supportLabel.snp.bottom).offset(10)
            make.bottom.equalTo(-40)
        }
        
    }
    
    private func configureViewsOptions() {
        self.selectionStyle = .none
        
        titleLabel.text = "모든 에어비앤비 Luxe 예약에 포함된 사항"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 22)
        titleLabel.numberOfLines = 0
        
        planImageView.image = UIImage(named: "planImage")
        planImageView.contentMode = .scaleAspectFill
        planImageView.clipsToBounds = true
        
        planLabel.text = "처음부터 끝까지 완벽한 여행 계획"
        planLabel.textColor = .black
        planLabel.font = UIFont(name: StandardUIValue.shared.airbnbMediumFontString, size: 15)
        
        
        planSubLabel.text = "여행 디자이너가 도착부터 출발까지 모든 것을 계획해드립니다."
        planSubLabel.textColor = .black
//        planSubLabel.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 15)
        planSubLabel.font = .systemFont(ofSize: 15, weight: .light)
        planSubLabel.setLineSpacing(lineSpacing: 3, lineHeightMultiple: 1)
        planSubLabel.numberOfLines = 0
        
        evaluationImageView.image = UIImage(named: "evaluationImage")
        evaluationImageView.contentMode = .scaleAspectFill
        evaluationImageView.clipsToBounds = true
        
        evaluationLabel.text = "300개 이상의 항목을 점검하는 방문 평가"
        evaluationLabel.textColor = .black
        evaluationLabel.font = UIFont(name: StandardUIValue.shared.airbnbMediumFontString, size: 15)
        
        evaluationSubLabel.text = "모든 Airbnb Luxe숙소는 최고 수준의 숙소 상태를 보장하기 위해 직접 확인하고 있습니다."
        evaluationSubLabel.textColor = .black
//        evaluationSubLabel.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 15)
        evaluationSubLabel.font = .systemFont(ofSize: 15, weight: .light)
        evaluationSubLabel.setLineSpacing(lineSpacing: 8, lineHeightMultiple: 1)
        evaluationSubLabel.numberOfLines = 0
        
        
        supportImageView.image = UIImage(named: "supportImage")
        supportImageView.contentMode = .scaleAspectFill
        supportImageView.clipsToBounds = true
        
        supportLabel.text = "연중무휴 여행 중 지원 서비스"
        supportLabel.textColor = .black
        supportLabel.font = UIFont(name: StandardUIValue.shared.airbnbMediumFontString, size: 15)
        
        supportSubLabel.text = "고객 요청에 따라 언제든 모든 문의에 대응하는 우선 지원 서비스"
        supportSubLabel.textColor = .black
//        supportSubLabel.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 15)
        supportSubLabel.font = .systemFont(ofSize: 15, weight: .light)
        supportSubLabel.setLineSpacing(lineSpacing: 8, lineHeightMultiple: 1)
        supportSubLabel.numberOfLines = 0
        
        
        
        
    }
}
