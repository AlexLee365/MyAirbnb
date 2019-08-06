//
//  TitleCell.swift
//  MyAirbnb
//
//  Created by 김광준 on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import UIKit

class TitleCell: UITableViewCell {
    static let identifier = "TitleCell"
    
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TitleCell.identifier)
        
        setupLayout()
        setupConfigure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true
    }
    
    private func setupConfigure() {
        
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.init(7))
        titleLabel.textAlignment = .left
        titleLabel.sizeToFit()
        
    }
    
    func setData(titleTextData: TitleText) {
        titleLabel.text = titleTextData.title
    }
}
