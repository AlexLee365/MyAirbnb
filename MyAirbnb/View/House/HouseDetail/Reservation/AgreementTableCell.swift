//
//  AgreementTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class AgreementTableCell: UITableViewCell {
    static let identifier = "AgreementTableCell"
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
        self.hideSeparator()
        
        descLabel.attributedText = attributedText(first: "숙소 이용규칙", second: ", ", third: "환불 정책", fourth: ", 및 ", fifth: "게스트 환불 정책", sixth: "에 동의합니다. 또한, 서비스 수수료를 표함하여 명시된 총 금액을 결제하는 데 동의합니다.")
        contentView.addSubview(descLabel)
    }
    
    private func setAutolayout() {
        descLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
            make.trailing.bottom.equalTo(-20)
        }
    }

    private func attributedText(first: String, second: String, third: String, fourth: String, fifth: String, sixth: String) -> NSAttributedString{
        let string = first + second + third + fourth + fifth + sixth as NSString
        let result = NSMutableAttributedString(string: string as String)
        
        let attributesForFirstWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Medium", size: 14) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        let attributesForSecondWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Book", size: 14) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        let attributesForThirdWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Medium", size: 14) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        let attributesForFourthWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Book", size: 14) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        let attributesForFifthWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Medium", size: 14) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        let attributesForSixthWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Book", size: 14) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        result.setAttributes(attributesForFirstWord, range: string.range(of: first))
        result.setAttributes(attributesForSecondWord, range: string.range(of: second))
        result.setAttributes(attributesForThirdWord, range: string.range(of: third))
        result.setAttributes(attributesForFourthWord, range: string.range(of: fourth))
        result.setAttributes(attributesForFifthWord, range: string.range(of: fifth))
        result.setAttributes(attributesForSixthWord, range: string.range(of: sixth))
        
        return NSAttributedString(attributedString: result)
    }
    
}
