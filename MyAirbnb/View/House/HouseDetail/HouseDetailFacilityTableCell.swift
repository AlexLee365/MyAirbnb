//
//  HouseDetailFacilityTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 19/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseDetailFacilityTableCell: UITableViewCell {
    
    let titleLabel = UILabel()
    
    let layout = UICollectionViewFlowLayout()
    lazy var CollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
