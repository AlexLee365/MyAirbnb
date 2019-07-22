//
//  PasswordView.swift
//  MyAirbnb
//
//  Created by 김광준 on 22/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class PasswordView: UIView {
    
    let titleLbl = UILabel()
    //    let showBtn = UIButton()
    let inputPwTxtField = UITextField()
    let underLine = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        //        self.backgroundColor = .clear
        
        //        오토레이아웃 테스트용
        //                self.backgroundColor = .black
        
        setupItems()
        setupLayout()
        setupConfigure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupItems() {
        self.addSubview(titleLbl)
        self.addSubview(inputPwTxtField)
        self.addSubview(underLine)
    }
    
    private func setupLayout() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        inputPwTxtField.translatesAutoresizingMaskIntoConstraints = false
        underLine.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLblWidth = self.frame.width - (self.frame.width - 100)
        let underLineHeight = self.frame.height - (self.frame.height - 2)
        let inputPwTxtFiedlHeight = self.frame.height - (self.frame.height - 100)
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: self.topAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLbl.widthAnchor.constraint(equalToConstant: titleLblWidth),
            
            inputPwTxtField.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 15),
            inputPwTxtField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            inputPwTxtField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            //            inputPwTxtField.heightAnchor.constraint(equalToConstant: <#T##CGFloat#>)
            
            underLine.topAnchor.constraint(equalTo: inputPwTxtField.bottomAnchor, constant: 10),
            underLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            underLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            underLine.heightAnchor.constraint(equalToConstant: underLineHeight),
            ])
    }
    
    private func setupConfigure() {
        
        titleLbl.text = "비밀번호"
        titleLbl.textColor = .white
        titleLbl.font = UIFont.boldSystemFont(ofSize: 15)
        titleLbl.backgroundColor = .orange
        
        inputPwTxtField.font = UIFont.systemFont(ofSize: 28)
        inputPwTxtField.textColor = .white
        inputPwTxtField.textAlignment = .left
        inputPwTxtField.backgroundColor = .black
        
        underLine.backgroundColor = .white
        
    }
}
