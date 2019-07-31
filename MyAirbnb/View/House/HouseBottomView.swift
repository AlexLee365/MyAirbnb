//
//  HouseBottomView.swift
//  MyAirbnb
//
//  Created by Solji Kim on 31/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HouseBottomView: UIView {
    
    // containerview contains info before selecting dates
    
    let beforeDateContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let priceLabelBefore: UILabel = {
        let label = UILabel()
        label.text = "요금을 확인하려면 날짜를 입력하세요."
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 12)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    let starLabelBefore: UILabel = {
        let label = UILabel()
        label.text = String(repeating: "★", count: 5)
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 13)
        label.textColor = StandardUIValue.shared.colorBlueGreen
        return label
    }()
    
    let noOfReviewLabelBefore: UILabel = {
        let label = UILabel()
        label.text = "172"
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 12)
        return label
    }()
    
    // containerview contains info after selecting dates
    
    let afterDateContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "₩40,000 /박"
        return label
    }()
    
    let starImageLabel: UILabel = {
        let label = UILabel()
        label.text = String(repeating: "★", count: 5)
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 12)
        label.textColor = StandardUIValue.shared.colorBlueGreen
        return label
    }()
    
    let noOfReviewLabel: UILabel = {
        let label = UILabel()
        label.text = "172"
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 12)
        return label
    }()
    
    let priceDetailBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("요금 내역", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
        button.setTitleColor(StandardUIValue.shared.colorBlueGreen, for: .normal)
        return button
    }()
    
    let reserveBtn: UIButton = {
        let button = UIButton()
        button.setTitle(" 날짜 입력 ", for: .normal)
        button.titleLabel?.font = UIFont(name: "AirbnbCerealApp-Bold", size: 14.5)
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = StandardUIValue.shared.colorPink
        return button
    }()
    
    var isDateSelected = false {
        didSet {
            switch isDateSelected {
            case true:
                print("didSet true")
                beforeDateContainerView.isHidden = true
                afterDateContainerView.isHidden = false
                reserveBtn.setTitle(" 예약 요청 ", for: .normal)
            case false:
                print("didSet false")
                beforeDateContainerView.isHidden = false
                afterDateContainerView.isHidden = true
                reserveBtn.setTitle(" 날짜 입력 ", for: .normal)
            }
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setAutolayout()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.backgroundColor = .white
        
        
        self.addSubview(reserveBtn)
        
        self.addSubview(beforeDateContainerView)
        beforeDateContainerView.addSubview(priceLabelBefore)
        beforeDateContainerView.addSubview(starLabelBefore)
        beforeDateContainerView.addSubview(noOfReviewLabelBefore)

        self.addSubview(afterDateContainerView)

        priceLabel.attributedText = attributedText(first: "₩40,000 ", second: "/박")
        afterDateContainerView.addSubview(priceLabel)
        afterDateContainerView.addSubview(starImageLabel)
        afterDateContainerView.addSubview(noOfReviewLabel)
        afterDateContainerView.addSubview(priceDetailBtn)
        
        beforeDateContainerView.isHidden = false
        afterDateContainerView.isHidden = true
        
        makeShadow()
    }
    
    private func setAutolayout() {
        
        reserveBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-20)
            make.height.equalToSuperview().multipliedBy(0.64)
            make.width.equalTo(150)
        }
        
        beforeDateContainerView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(25)
            make.trailing.equalTo(reserveBtn.snp.leading).offset(-30)
        }
        
        priceLabelBefore.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
        }
        
        starLabelBefore.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabelBefore.snp.bottom)
            make.leading.bottom.equalToSuperview()
        }
        
        noOfReviewLabelBefore.snp.makeConstraints { (make) in
            make.leading.equalTo(starLabelBefore.snp.trailing).offset(3)
            make.centerY.equalTo(starLabelBefore.snp.centerY)
        }

        afterDateContainerView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(25)
            make.trailing.equalTo(reserveBtn.snp.leading).offset(-30)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.leading.equalToSuperview()
        }
        
        starImageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom)
            make.leading.equalToSuperview()
        }
        
        noOfReviewLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(starImageLabel.snp.trailing).offset(3)
            make.centerY.equalTo(starImageLabel.snp.centerY)
        }
        
        priceDetailBtn.snp.makeConstraints { (make) in
            make.top.equalTo(starImageLabel.snp.bottom)
            make.leading.bottom.equalToSuperview()
        }
    }
    
    private func makeShadow() {
        layer.masksToBounds = false
        
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
        layer.shadowColor = UIColor.gray.cgColor
    }
    
    private func attributedText(first: String, second: String) -> NSAttributedString{
        let string = first + second as NSString
        let result = NSMutableAttributedString(string: string as String)
        let attributesForFirstWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Bold", size: 15) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        let attributesForSecondWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Book", size: 15) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        result.setAttributes(attributesForFirstWord, range: string.range(of: first))
        result.setAttributes(attributesForSecondWord, range: string.range(of: second))
        
        return NSAttributedString(attributedString: result)
    }
}
