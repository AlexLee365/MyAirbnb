//
//  BottomInfoView.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 25/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class BottomInfoView: UIView {
    
    var backColor: UIColor = .black {
        didSet {
            self.backgroundColor = backColor
            
            if backColor == .black {
                layer.shadowColor = UIColor.white.cgColor
            } else {
                layer.shadowColor = UIColor.gray.cgColor
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
    
    func makeShadow() {
        layer.masksToBounds = false
        
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
    }
    
    private func configure() {
        self.backColor = .black
        
        makeShadow()
    }
    
    private func setAutolayout() {
        
    }
}
