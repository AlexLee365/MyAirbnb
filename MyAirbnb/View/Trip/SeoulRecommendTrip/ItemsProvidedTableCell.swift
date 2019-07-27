//
//  ItemsProvidedTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 27/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class ItemsProvidedTableCell: UITableViewCell {
    static let identifier = "ItemsProvidedTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.configureTripDetailTitle()
        label.text = "제공 항목"
        return label
    }()
    
    let itemsArray = ["음료", "티켓", "장비"]
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureImageForItem(item: String) -> UIImage {
        var imageString = ""
        
        switch item {
        case "음료":
            imageString = "drinks"
        case "티켓":
            imageString = "ticket"
        case "장비":
            imageString = "tools"
        default: break
        }
        return UIImage(named: imageString) ?? UIImage()
    }
    
    private func setItemsProvidedLabel() {
        let itemLabel: UILabel = {
            let label = UILabel()
            return label
        }()
    }
    
    private func configure() {
        contentView.addSubview(titleLabel)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
        }
    }
}
