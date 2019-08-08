//
//  BillsTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 07/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

protocol BillsTableCellDelegate: class {
    func presentBillsVC()
}

class BillsTableCell: UITableViewCell {
    static let identifier = "BillsTableCell"
    
    weak var delegate: BillsTableCellDelegate?
    
    let clearBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        return btn
    }()
    
    let billImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bill")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let billTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "영수증"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 17)
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
        
        contentView.addSubview(billImage)
        contentView.addSubview(billTitleLabel)
        contentView.addSubview(greaterThanImage)
        
        clearBtn.addTarget(self, action: #selector(showBillsBtnDidTap), for: .touchUpInside)
        contentView.addSubview(clearBtn)
    }
    
    @objc private func showBillsBtnDidTap(_ sender: UIButton) {
        delegate?.presentBillsVC()
    }
    
    private func setAutolayout() {
        billImage.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.leading.equalTo(20)
            make.width.height.equalTo(30)
            make.bottom.equalTo(-30)
        }
        
        billTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(billImage.snp.centerY)
            make.leading.equalTo(billImage.snp.trailing).offset(15)
        }
        
        greaterThanImage.snp.makeConstraints { (make) in
            make.trailing.equalTo(-20)
            make.centerY.equalTo(billImage.snp.centerY)
            make.width.height.equalTo(15)
        }
        
        clearBtn.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
