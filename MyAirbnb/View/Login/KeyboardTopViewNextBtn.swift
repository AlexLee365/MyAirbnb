//
//  KeyboardTopViewNextBtn.swift
//  MyAirbnb
//
//  Created by 김광준 on 29/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardTopViewNextBtnDelegate: class {
    func pushView()
}

class KeyboardTopViewNextBtn: UIView {
    
    weak var delegate: KeyboardTopViewNextBtnDelegate?
    
    let nextBtn = UIButton(type: .custom)
    let statusChangeBtn = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.backgroundColor = .init(patternImage: UIImage.init(named: "nextBtn_Background")!)
        setupButtons()
        setupLayout()
        setupConfigure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        self.addSubview(nextBtn)
    }
    
    private func setupLayout() {
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        let btnHeight = self.frame.height - (self.frame.height - 80)
        let btnWidth = self.frame.width - (self.frame.width - 80)
        
        NSLayoutConstraint.activate([
            nextBtn.topAnchor.constraint(equalTo: self.topAnchor),
            nextBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nextBtn.widthAnchor.constraint(equalToConstant: btnWidth),
            nextBtn.heightAnchor.constraint(equalToConstant: btnHeight),
            ])
        
        //        오토레이아웃 테스트용
        //        statusChangeBtn.backgroundColor = .black
        //        nextBtn.backgroundColor = .black
    }
    
    private func setupConfigure() {
        nextBtn.setTitle("다음", for: .normal)
        nextBtn.setTitleColor(.lightGray, for: .normal)
        nextBtn.setTitleColor(.white, for: .selected)
        nextBtn.addTarget(self, action: #selector(didTapNextBtn(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapNextBtn(_ sender: UIButton) {
        delegate?.pushView()
    }
}

