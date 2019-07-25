//
//  PlusIntroTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 25/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class PlusIntroTableCell: UITableViewCell {
    static let identifier = "PlusIntroTableCell"
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "plusLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let houseTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "부다페스트(BUDAPEST)의 아파트 전체"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Apartment in a Historic Building next to the Great Synagogue"
        label.font = UIFont.systemFont(ofSize: 30)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        return stackView
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
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(houseTypeLabel)
        contentView.addSubview(titleLabel)
    }
    
    private func setAutolayout() {
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.leading.equalTo(20)
            make.width.equalTo(100)
            make.height.equalTo(70)
        }
        
        houseTypeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(5)
            make.leading.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(houseTypeLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-35)
            make.bottom.equalTo(-20)
        }
    }
}
