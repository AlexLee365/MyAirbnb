//
//  NoOfLikeListTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 08/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class NoOfLikeListTableCell: UITableViewCell {
    static let identifier = "NoOfLikeListTableCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "예약 가능 숙소 3개"
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 17.5)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
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
        
        contentView.addSubview(label)
    }
    
    private func setAutolayout() {
        label.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
            make.bottom.equalTo(-20)
        }
    }
    
    func setData(availableReservationCount: Int) {
        label.text = "예약 가능 숙소 \(availableReservationCount)개"
    }
}
