//
//  CouponTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

protocol CouponTableCellDelegate: class {
    func presentCouponVC()
}

class CouponTableCell: UITableViewCell {
    static let identifier = "CouponTableCell"
    
    weak var delegate: CouponTableCellDelegate?
    
    let couponIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "couponIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "쿠폰 적용"
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 17)
        return label
    }()
    
    let greaterThanImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "greaterThan")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let clearBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        return btn
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
        
        contentView.addSubview(couponIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(greaterThanImage)
        
        clearBtn.addTarget(self, action: #selector(addCouponBtnDidTap(_:)), for: .touchUpInside)
        contentView.addSubview(clearBtn)
    }
    
    @objc private func addCouponBtnDidTap(_ sender: UIButton) {
        delegate?.presentCouponVC()
    }
    
    private func setAutolayout() {
        couponIcon.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
            make.width.equalTo(40)
            make.height.equalTo(25)
            make.bottom.equalTo(-20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(couponIcon.snp.centerY)
            make.leading.equalTo(couponIcon.snp.trailing).offset(20)
        }
        
        greaterThanImage.snp.makeConstraints { (make) in
            make.trailing.equalTo(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
        }
        
        clearBtn.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
