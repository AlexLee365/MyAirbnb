//
//  MemoTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 27/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class MemoTableCell: UITableViewCell {
    static let identifier = "MemoTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.configureTripDetailTitle()
        label.text = "메모"
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.configureTripDetailDesc()
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
        self.selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalTo(20)
            make.trailing.bottom.equalTo(-20)
        }
    }
    
    func setData(memoData: TripDetail) {
        descLabel.text = memoData.additionalCondition
    }
}
