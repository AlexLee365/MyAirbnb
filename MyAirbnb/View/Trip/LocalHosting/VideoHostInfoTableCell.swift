//
//  VideoHostInfoTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 30/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class VideoHostInfoTableCell: UITableViewCell {
    static let identifier = "VideoHostInfoTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "호스트"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 25)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let hostImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "videoHost")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        return image
    }()
    
    let hostNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Jill & Javier"
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 25)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = """
        We have been leading community-based tourism efforts for 10 years here in the Galapagos Islands.
        
        Since starting our local Slow Food chapter and connecting with Airbnb at Terra Madre in Italy, we have developed a Slow Food- inspired multi-day experience that allows you to make a positive impact during your visit to the islands by supporting local farms and the restaurants and hotels that encourage sustainable practices.
        
        We are always looking for unique experiences so our guests can have an authentic connection with nature, the culture, and the people..and what better way than through food?
        """
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 3)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 15)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let contactHostBtn: UIButton = {
        let button = UIButton()
        button.setTitle(" 호스트에게 연락하기 ", for: .normal)
        button.setTitleColor(StandardUIValue.shared.colorBlueGreen, for: .normal)
        button.titleLabel?.font = UIFont(name: "AirbnbCerealApp-Book", size: 16)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2.0
        button.layer.borderColor = StandardUIValue.shared.colorBlueGreen.cgColor
        return button
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
        contentView.addSubview(hostImage)
        contentView.addSubview(hostNameLabel)
        contentView.addSubview(descLabel)
        
        contactHostBtn.addTarget(self, action: #selector(contactHostBtnDidTap(_:)), for: .touchUpInside)
        contentView.addSubview(contactHostBtn)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.leading.equalTo(20)
        }
        
        hostImage.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(20)
            make.width.height.equalTo(100)
        }
        
        hostNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(hostImage.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(hostNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        contactHostBtn.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(50)
            make.bottom.equalTo(-20)
        }
    }
    
    @objc private func contactHostBtnDidTap(_ sender: UIButton) {
        
    }
}
