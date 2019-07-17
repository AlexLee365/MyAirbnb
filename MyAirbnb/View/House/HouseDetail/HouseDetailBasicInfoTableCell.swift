//
//  HouseDetailBasicInfoTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 17/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseDetailBasicInfoTableCell: UITableViewCell {
    
    // MARK: - UI Properties
    let typeTopLabel = UILabel()
    let nameLabel = UILabel()
    
    let locationLabel = UILabel()
    let hostNameLabel = UILabel()
    let hostImageView = UIImageView()
    
    let typeIconeView = UIImageView()
    let typeLabel = UILabel()
    let typeDetailLabel = UILabel()
    
    let cleanIconImageView = UIImageView()
    let cleanLabel = UILabel()
    let cleanDetailLabel = UILabel()
    
    let hostInfoIconView = UIImageView()
    let hostInfoLabel = UILabel()
    let hostInfoDetailLabel = UILabel()
    
    let checkInIconView = UIView()
    let checkInLabel = UILabel()
    let checkInDetailLabel = UILabel()
    
    
    
    
    // MARK: - Properties
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setAutoLayout() {
        
    }
    
    private func configureViewsOptions() {
        
    }
    
//    private func set
}
