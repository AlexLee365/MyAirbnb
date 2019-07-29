//
//  InfoCollectionCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 29/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class InfoCollectionCell: UICollectionViewCell {
    static let identifier = "InfoCollectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
    }
    
    private func setAutolayout() {
        
    }
}
