//
//  TaxInfoTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 31/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class TaxInfoTableCell: UITableViewCell {
    static let identifier = "TaxInfoTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "수수료 및 세금 정보"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 12)
        return label
    }()
    
    let infoBtn: UIButton = {
        let button = UIButton(type: .infoLight)
        button.setTitleColor(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), for: .normal)
        return button
    }()
    
    let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1).withAlphaComponent(0.4)
        return view
    }()
    
    let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "합계"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 18)
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
    var infoLabelArray = [UIView]()
    
    
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
        contentView.addSubview(infoBtn)
        contentView.addSubview(separatorLineView)
        contentView.addSubview(totalTitleLabel)
        contentView.addSubview(totalPriceLabel)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
        }
        
        infoBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
            make.width.height.equalTo(17)
        }
        
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
                    make.top.equalTo(titleLabel.snp.bottom).offset(15)
                }
            case infoLabelArray.count - 1:
                infoLabelArray[i].snp.makeConstraints { (make) in
                    make.bottom.equalTo(separatorLineView.snp.top).offset(-20)
                }
                fallthrough
            default:
                infoLabelArray[i].snp.makeConstraints { (make) in
                    make.top.equalTo(infoLabelArray[i-1].snp.bottom).offset(15)
                }
            }
        }
    }
}


class taxLabelView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 18)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(titleLabel)
        self.addSubview(priceLabel)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.trailing.bottom.equalToSuperview()
        }
    }
}
