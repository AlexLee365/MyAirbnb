//
//  AddPaymentTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

protocol AddPaymentTableCellDelegate: class {
    func presentSelectPayVC()
}

class AddPaymentTableCell: UITableViewCell {
    static let identifier = "AddPaymentTableCell"
    
    weak var delegate: AddPaymentTableCellDelegate?
    
    let clearBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        return btn
    }()
    
    let plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.textAlignment = .center
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 15)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 0.849796661)
        label.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 0.849796661)
        label.layer.borderWidth = 1.5
        label.layer.cornerRadius = 3
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "결제 수단 추가"
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 17)
        return label
    }()
    
    let greaterThanImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "greaterThan")
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        
        contentView.addSubview(plusLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(greaterThanImage)
        
        clearBtn.addTarget(self, action: #selector(addCardBtnDidTap(_:)), for: .touchUpInside)
        contentView.addSubview(clearBtn)
    }
    
    @objc private func addCardBtnDidTap(_ sender: UIButton) {
        delegate?.presentSelectPayVC()
    }
    
    private func setAutolayout() {
        plusLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
            make.width.equalTo(40)
            make.height.equalTo(23)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(plusLabel.snp.trailing).offset(15)
        }
        
        greaterThanImage.snp.makeConstraints { (make) in
            make.trailing.equalTo(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
        }
        
        clearBtn.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}
