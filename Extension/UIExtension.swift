//
//  UIExtension.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 09/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

extension UILabel {
    func configureMainTableViewCellsTitle() {   // MainView의 TableViewCell들의 타이틀 텍스트 설정을 통일시켜주는 메소드
        self.font = .systemFont(ofSize: 19, weight: .bold)
        self.textAlignment = .left
        self.numberOfLines = 0
        self.textColor = #colorLiteral(red: 0.3221844435, green: 0.3202747703, blue: 0.3236560524, alpha: 1)
    }
    
    func configureMainTableViewCellsTitleDetails() {
        self.font = .systemFont(ofSize: 16, weight: .regular)
        self.textAlignment = .left
        self.numberOfLines = 0
        self.textColor = #colorLiteral(red: 0.3221844435, green: 0.3202747703, blue: 0.3236560524, alpha: 1)
    }
}
