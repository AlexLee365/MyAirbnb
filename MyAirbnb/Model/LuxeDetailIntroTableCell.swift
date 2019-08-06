//
//  LuxeDetailIntroTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/06.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class LuxeDetailIntroTableCell: UITableViewCell {
    
    // MARK: - UI Properties
    let logoImageView = UIImageView()
    let roomTitleLabel = UILabel()
    let locationLabel = UILabel()
    
//    let introTitleLable = UILabel()
    let descriptionLabel = UILabel()
    let geustNumberLabel = UILabel()
    let hospitalityByLuxuryRetreatsImageView = UIImageView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureViewsOptions() {
        
    }
    
    private func setAutoLayout() {
        
    }

}
