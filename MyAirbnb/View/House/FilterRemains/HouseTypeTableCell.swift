//
//  HouseTypeTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 19/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseTypeTableCell: UITableViewCell {
    static let identifier = "HouseTypeTableCell"
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "숙소 유형"
        label.font = UIFont.systemFont(ofSize: 17.8, weight: .medium)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let wholeHouseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.5)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "집 전체"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "집 전체를 단독으로 사용합니다"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkBox = Checkbox()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.selectionStyle = .none
        
        contentView.addSubview(title)
        contentView.addSubview(wholeHouseLabel)
        contentView.addSubview(descLabel)
        
        checkBox.style = .tick
        checkBox.borderStyle = .roundedSquare(radius: 5)
        contentView.addSubview(checkBox)
    }
    
    private func setAutolayout() {
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        wholeHouseLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20).isActive = true
        wholeHouseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: wholeHouseLabel.bottomAnchor, constant: 10).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.topAnchor.constraint(equalTo: wholeHouseLabel.topAnchor).isActive = true
        checkBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        checkBox.widthAnchor.constraint(equalToConstant: 30).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
