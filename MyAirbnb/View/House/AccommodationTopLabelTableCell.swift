//
//  AccommodationTopLabelTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 14/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class AccommodationTopLabelTableCell: UITableViewCell {
    static let identifier = "accommodationTopLabelTableCell"
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(topLabel)
    }
    
    private func setAutolayout() {
        let topBottomMargin = StandardUIValue.shared.mainTableViewCellsTopBottomPadding
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        topLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topBottomMargin).isActive = true
        topLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideMargin).isActive = true
        topLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -sideMargin).isActive = true
    }
}
