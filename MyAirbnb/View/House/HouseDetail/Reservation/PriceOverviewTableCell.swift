//
//  PriceOverviewTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class PriceOverviewTableCell: UITableViewCell {
    static let identifier = "PriceOverviewTableCell"

    let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1).withAlphaComponent(0.4)
        return view
    }()
    
    let totalTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "₩2,290,481"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 18)
        return label
    }()
    
    
    let infoArr = [("₩388,552 x 5박", "₩1,942,760"), ("청소비", "₩70,895"), ("서비스 수수료", "₩90,982"), ("숙박세와 수수료", "₩99,253")]
    var infoLabelArray = [taxLabelView]()
    
    
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
        
        contentView.addSubview(separatorLineView)
        
        totalTitleLabel.attributedText = attributedText(first: "합계 ", second: "(KRW)")
        contentView.addSubview(totalTitleLabel)
        contentView.addSubview(totalPriceLabel)
    }
    
    private func setAutolayout() {
        setInfoLabel()
        
        separatorLineView.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(0.35)
        }
        
        totalTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLineView.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
        
        totalPriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLineView.snp.bottom).offset(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-20)
        }
    }
    
    private func setInfoLabel() {
        for i in 0..<infoArr.count {
            let view = taxLabelView()
            
            view.titleLabel.text = infoArr[i].0
            view.priceLabel.text = infoArr[i].1
            
            infoLabelArray.append(view)
        }
        
        for i in 0..<infoLabelArray.count {
            contentView.addSubview(infoLabelArray[i])
            
            infoLabelArray[i].snp.makeConstraints { (make) in
                make.leading.equalTo(20)
                make.trailing.equalTo(-20)
            }
            
            switch i {
            case 0:
                infoLabelArray[i].snp.makeConstraints { (make) in
                    make.top.equalTo(20)
                }
            case infoLabelArray.count - 1:
                infoLabelArray[i].snp.makeConstraints { (make) in
                    make.bottom.equalTo(separatorLineView.snp.top).offset(-20)
                }
                fallthrough
            default:
                infoLabelArray[i].snp.makeConstraints { (make) in
                    make.top.equalTo(infoLabelArray[i-1].snp.bottom).offset(20)
                }
            }
        }
    }
    
    private func attributedText(first: String, second: String) -> NSAttributedString{
        let string = first + second as NSString
        let result = NSMutableAttributedString(string: string as String)
        let attributesForFirstWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Medium", size: 18) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        let attributesForSecondWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Medium", size: 18) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        result.setAttributes(attributesForFirstWord, range: string.range(of: first))
        result.setAttributes(attributesForSecondWord, range: string.range(of: second))
        
        return NSAttributedString(attributedString: result)
    }
    
    func setData(oneDayPrice: Int, stayDays: Int) {
        infoLabelArray[0].titleLabel.text = "₩ \(String(oneDayPrice).limitFractionDigits()) X \(stayDays)박"
        let stayDaysPrice = oneDayPrice * stayDays
        infoLabelArray[0].priceLabel.text = "₩ " + String(stayDaysPrice).limitFractionDigits()
        let cleanPrice = 10000 * stayDays
        infoLabelArray[1].priceLabel.text = "₩ \(cleanPrice)"
        let serviceTax = stayDaysPrice / 10
        infoLabelArray[2].priceLabel.text = "₩ \(serviceTax)"
        let stayTax = stayDaysPrice / 10
        infoLabelArray[3].priceLabel.text = "₩ \(stayTax)"
        
        let totalPrice = stayDaysPrice + cleanPrice + serviceTax + stayTax
        totalPriceLabel.text = "₩ \(totalPrice)"
        SingletonCommonData.shared.tempValue = totalPrice
    }
}
