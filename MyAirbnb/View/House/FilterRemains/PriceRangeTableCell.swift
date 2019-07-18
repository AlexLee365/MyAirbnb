//
//  PriceRangeTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 18/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class PriceRangeTableCell: UITableViewCell {
    static let identifier = "PriceRangeTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.8, weight: .medium)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "가격 범위"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "요금을 확인하려면 여행 날짜를 입력하세요"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceRangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
//        label.text = "₩12,000 - ₩234,917"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let avrPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
//        label.text = "평균 1박 요금은 ₩114,043입니다"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sliderContainerView = UIView()
    
    let rangeSlider = PriceRangeSlider(frame: .zero)
    
    var isDateSelected = true
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
        
        if isDateSelected == true {
            showPriceSlider()
        }
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        
        contentView.addSubview(priceRangeLabel)
        contentView.addSubview(avrPriceLabel)
    }
    
    private func setAutolayout() {
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35).isActive = true
        subLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        let subLabelBottom = subLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -35)
        subLabelBottom.priority = UILayoutPriority(750)
        subLabelBottom.isActive = true
    }
    
    
    private func showPriceSlider() {
        subLabel.isHidden = true
    
        priceRangeLabel.text = "₩12,000 - ₩234,917"
        avrPriceLabel.text = "평균 1박 요금은 ₩114,043입니다"
        
        priceRangeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28).isActive = true
        priceRangeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        avrPriceLabel.topAnchor.constraint(equalTo: priceRangeLabel.bottomAnchor).isActive = true
        avrPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true

        contentView.addSubview(sliderContainerView)
        sliderContainerView.translatesAutoresizingMaskIntoConstraints = false
        sliderContainerView.topAnchor.constraint(equalTo: avrPriceLabel.bottomAnchor, constant: 15).isActive = true
        sliderContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        sliderContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        sliderContainerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let sliderContainerBottom = sliderContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        sliderContainerBottom.priority = UILayoutPriority(1000)
        sliderContainerBottom.isActive = true
        
        let sliderWidth: CGFloat = UIScreen.main.bounds.width - 40
        rangeSlider.frame = CGRect(x: 0, y: 10, width: sliderWidth, height: 30)
        rangeSlider.backgroundColor = .red
        sliderContainerView.addSubview(rangeSlider)
    }
}
