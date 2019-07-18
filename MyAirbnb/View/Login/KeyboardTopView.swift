//
//  KeyboardTopView.swift
//  MyAirbnb
//
//  Created by 김광준 on 18/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardTopViewDelegate: class {
    func pushView()
}

class KeyboardTopView: UIView {
    
    weak var delegate: KeyboardTopViewDelegate?
    
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
        self.addSubview(statusChangeBtn)
    }
    
    private func setupLayout() {
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        statusChangeBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let btnHeight = self.frame.height - (self.frame.height - 80)
        let btnWidth = self.frame.width - (self.frame.width - 80)
        let statusBtnWidth = self.frame.width - (self.frame.width - 120)
        
        NSLayoutConstraint.activate([
            nextBtn.topAnchor.constraint(equalTo: self.topAnchor),
            nextBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nextBtn.widthAnchor.constraint(equalToConstant: btnWidth),
            nextBtn.heightAnchor.constraint(equalToConstant: btnHeight),
            
            statusChangeBtn.topAnchor.constraint(equalTo: self.topAnchor),
            statusChangeBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            statusChangeBtn.widthAnchor.constraint(equalToConstant: statusBtnWidth),
            statusChangeBtn.heightAnchor.constraint(equalToConstant: btnHeight),
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
        
        statusChangeBtn.setTitle("이메일 주소 사용", for: .normal)
        statusChangeBtn.setTitle("전화번호", for: .selected)
        statusChangeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        statusChangeBtn.setTitleColor(.white, for: .normal)
        statusChangeBtn.setTitleColor(.white, for: .selected)
        statusChangeBtn.titleLabel?.textAlignment = .center
        statusChangeBtn.addTarget(self, action: #selector(didTapStatusChangeBtn(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapNextBtn(_ sender: UIButton) {
        delegate?.pushView()
    }
    
    @objc private func didTapStatusChangeBtn(_ sender: UIButton) {
        print("토글 버튼 만들어서 사용해야 됨")
    }
    
}
