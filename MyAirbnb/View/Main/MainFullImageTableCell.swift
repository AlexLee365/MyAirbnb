//
//  MainFullImageTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 10/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class MainFullImageTableCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}
