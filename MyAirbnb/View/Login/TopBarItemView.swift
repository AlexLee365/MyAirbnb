//
//  TopBarItemView.swift
//  MyAirbnb
//
//  Created by 김광준 on 18/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import UIKit

protocol TopBarItemViewDelegate: class {
    func popView()
}

class TopBarItemView: UIView {
    
    weak var delegate: TopBarItemViewDelegate?
    
    let backBtn = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupView()
        setupConfigure()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(backBtn)
    }
    
    private func setupConfigure() {
        
        //        레이아웃 테스트용
        //        self.backgroundColor = .black
        
        self.backgroundColor = UIColor.init(displayP3Red: 0.238, green: 0.448, blue: 0.576, alpha: 1.0)
        
        backBtn.setImage(UIImage(named: "backBtnImage"), for: .normal)
        backBtn.addTarget(self, action: #selector(didTapBackBtn(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapBackBtn(_ sender: UIButton) {
        delegate?.popView()
    }
    
    private func setupLayout() {
        
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let backBtnWidth = self.frame.width - (self.frame.width - 28)
        let backBtnHeight = self.frame.height - (self.frame.height - 25)
        
        NSLayoutConstraint.activate([
            backBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            backBtn.widthAnchor.constraint(equalToConstant: backBtnWidth),
            backBtn.heightAnchor.constraint(equalToConstant: backBtnHeight),
            ])
    }
}
