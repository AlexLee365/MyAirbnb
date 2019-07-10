//
//  BottomView.swift
//  MyAirbnb
//
//  Created by Solji Kim on 10/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class BottomView: UIView {

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
        
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
        
        if self.backgroundColor == .black {
            layer.shadowColor = UIColor.white.cgColor
        } else {
            layer.shadowColor = UIColor.gray.cgColor
        }
    }
    
    private func configure() {
        self.backgroundColor = .black
        
        makeShadow()
    }
    
    private func setAutolayout() {
        
    }
}
