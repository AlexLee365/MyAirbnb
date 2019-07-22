//
//  InputEmailAndPhoneView.swift
//  MyAirbnb
//
//  Created by 김광준 on 20/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

protocol InputEmailAndPhoneViewDelegate: class {
    func presentPickNationalNumberView()
}

class InputEmailAndPhoneView: UIView {
    
    weak var delegate: InputEmailAndPhoneViewDelegate?
    
    let titleLbl = UILabel()
    let inputPhoneNumberTxtField = UITextField()
    let underLine = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.backgroundColor = .clear
        
        //        오토레이아웃 테스트용
        //        self.backgroundColor = .orange
        
        setupItems()
        setupLayout()
        setupConfigure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupItems() {
        self.addSubview(titleLbl)
        self.addSubview(inputPhoneNumberTxtField)
        self.addSubview(underLine)
    }
    
    private func setupLayout() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        inputPhoneNumberTxtField.translatesAutoresizingMaskIntoConstraints = false
        underLine.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLblWidth = self.frame.width - (self.frame.width - 100)
        let underLineHeight = self.frame.height - (self.frame.height - 2)
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: self.topAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLbl.widthAnchor.constraint(equalToConstant: titleLblWidth),
            
            inputPhoneNumberTxtField.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 15),
            inputPhoneNumberTxtField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            inputPhoneNumberTxtField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            
            underLine.topAnchor.constraint(equalTo: inputPhoneNumberTxtField.bottomAnchor, constant: 10),
            underLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            underLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            underLine.heightAnchor.constraint(equalToConstant: underLineHeight),
            ])
    }
    
    private func setupConfigure() {
        
        titleLbl.text = "이메일 주소"
        titleLbl.textColor = .white
        titleLbl.font = UIFont.boldSystemFont(ofSize: 15)
        
        inputPhoneNumberTxtField.font = UIFont.systemFont(ofSize: 28)
        inputPhoneNumberTxtField.textColor = .white
        inputPhoneNumberTxtField.textAlignment = .left
        inputPhoneNumberTxtField.backgroundColor = .clear
        
        underLine.backgroundColor = .white
    }
    
    @objc private func didTapPickNationalNumberBtn(_ sender: UIButton) {
        delegate?.presentPickNationalNumberView()
    }
    
    
}
