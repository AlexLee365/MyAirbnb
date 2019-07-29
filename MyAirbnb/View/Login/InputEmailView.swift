//
//  InputEmailView.swift
//  MyAirbnb
//
//  Created by 김광준 on 29/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import UIKit



class InputEmailView: UIView {
    
    let titleLbl = UILabel()
    let inputEmailTxtField = UITextField()
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
        self.addSubview(inputEmailTxtField)
        self.addSubview(underLine)
    }
    
    private func setupLayout() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        inputEmailTxtField.translatesAutoresizingMaskIntoConstraints = false
        underLine.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLblWidth = self.frame.width - (self.frame.width - 100)
        let underLineHeight = self.frame.height - (self.frame.height - 2)
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: self.topAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLbl.widthAnchor.constraint(equalToConstant: titleLblWidth),
            
            inputEmailTxtField.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 15),
            inputEmailTxtField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            inputEmailTxtField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            
            underLine.topAnchor.constraint(equalTo: inputEmailTxtField.bottomAnchor, constant: 10),
            underLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            underLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            underLine.heightAnchor.constraint(equalToConstant: underLineHeight),
            ])
    }
    
    private func setupConfigure() {
        
        titleLbl.text = "이메일 주소"
        titleLbl.textColor = .white
        titleLbl.font = UIFont.boldSystemFont(ofSize: 15)
        
        inputEmailTxtField.font = UIFont.systemFont(ofSize: 28)
        inputEmailTxtField.textColor = .white
        inputEmailTxtField.textAlignment = .left
        inputEmailTxtField.backgroundColor = .clear
        
        underLine.backgroundColor = .white
    }
}
