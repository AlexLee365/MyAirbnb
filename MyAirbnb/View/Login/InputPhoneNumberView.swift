//
//  InputPhoneNumberView.swift
//  MyAirbnb
//
//  Created by 김광준 on 29/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import UIKit

protocol InputPhoneNumberViewDelegate: class {
    func presentView()
}

class InputPhoneNumberView: UIView {
    
    weak var delegate: InputPhoneNumberViewDelegate?
    
    let titleLbl = UILabel()
    let subTitleLbl = UILabel()
    let pickNationalNumberBtn = UIButton()
    let inputPhoneNumberTxtField = UITextField()
    let underLine = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        //        self.backgroundColor = .clear
        
        //        오토레이아웃 테스트용
        self.backgroundColor = .orange
        
        setupItems()
        setupLayout()
        setupConfigure()
        //        txtFieldSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupItems() {
        self.addSubview(titleLbl)
        self.addSubview(subTitleLbl)
        self.addSubview(pickNationalNumberBtn)
        self.addSubview(inputPhoneNumberTxtField)
        self.addSubview(underLine)
    }
    
    private func setupLayout() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        subTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        pickNationalNumberBtn.translatesAutoresizingMaskIntoConstraints = false
        inputPhoneNumberTxtField.translatesAutoresizingMaskIntoConstraints = false
        underLine.translatesAutoresizingMaskIntoConstraints = false
        
        let underLineHeight = self.frame.height - (self.frame.height - 2)
        let nationalBtnWidth = self.frame.width - (self.frame.width - 50)
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: self.topAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            subTitleLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 30),
            subTitleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subTitleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            pickNationalNumberBtn.topAnchor.constraint(equalTo: subTitleLbl.bottomAnchor, constant: 15),
            pickNationalNumberBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pickNationalNumberBtn.widthAnchor.constraint(equalToConstant: nationalBtnWidth),
            
            inputPhoneNumberTxtField.topAnchor.constraint(equalTo: subTitleLbl.bottomAnchor, constant: 15),
            inputPhoneNumberTxtField.leadingAnchor.constraint(equalTo: pickNationalNumberBtn.trailingAnchor, constant: 5),
            inputPhoneNumberTxtField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            underLine.topAnchor.constraint(equalTo: inputPhoneNumberTxtField.bottomAnchor, constant: 10),
            underLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            underLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            underLine.heightAnchor.constraint(equalToConstant: underLineHeight),
            ])
    }
    
    private func setupConfigure() {
        
        titleLbl.text = "전화번호를 입력하세요."
        titleLbl.textColor = .white
        titleLbl.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(7))
        
        subTitleLbl.text = "전화번호"
        subTitleLbl.textColor = .white
        subTitleLbl.font = UIFont.boldSystemFont(ofSize: 15)
        
        pickNationalNumberBtn.setTitle("+82", for: .normal)
        pickNationalNumberBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        pickNationalNumberBtn.setTitleColor(UIColor.init(displayP3Red: 0.238, green: 0.448, blue: 0.576, alpha: 1.0), for: .normal)
        pickNationalNumberBtn.titleLabel?.textAlignment = .center
        pickNationalNumberBtn.addTarget(self, action: #selector(didTapPickNationalNumberBtn(_:)), for: .touchUpInside)
        pickNationalNumberBtn.layer.cornerRadius = 5
        pickNationalNumberBtn.backgroundColor = .white
        
        inputPhoneNumberTxtField.font = UIFont.systemFont(ofSize: 28)
        inputPhoneNumberTxtField.textColor = .white
        inputPhoneNumberTxtField.textAlignment = .left
        inputPhoneNumberTxtField.backgroundColor = .clear
        
        underLine.backgroundColor = .white
    }
    
    @objc private func didTapPickNationalNumberBtn(_ sender: UIButton) {
        delegate?.presentView()
    }
}
