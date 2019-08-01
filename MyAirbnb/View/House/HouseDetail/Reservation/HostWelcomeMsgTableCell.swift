//
//  HostWelcomeMsgTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HostWelcomeMsgTableCell: UITableViewCell {
    static let identifier = "HostWelcomeMsgTableCell"
    
    let stepLabel: UILabel = {
        let label = UILabel()
        label.text = "2/3단계"
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 16)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Clara님에게 회원님의 여행에 대해 알려주세요"
        label.numberOfLines = 0
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 27)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.text = "여행 계획 세부사항을 공유하면 호스트가 회원님의 숙박을 준비하는 데 도움이 됩니다."
        label.numberOfLines = 0
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 15)
        label.setLineSpacing(lineSpacing: 3.0)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let hostImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.image = #imageLiteral(resourceName: "hostSample1")
        return imageView
    }()
    
    let msgView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.5977900257)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let hostMsgLabel: UILabel = {
        let label = UILabel()
        label.text = "예약해 주셔서 감사합니다. 궁금한 점이 있으면 저에게 연락하십시오. 도착 시간을 알려 주십시오."
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 14.5)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.numberOfLines = 0
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
        
        contentView.addSubview(stepLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        contentView.addSubview(msgView)
        contentView.addSubview(hostImage)
        msgView.addSubview(hostMsgLabel)
    }
    
    private func setAutolayout() {
        stepLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(stepLabel.snp.bottom).offset(3)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        msgView.snp.makeConstraints { (make) in
            make.top.equalTo(subLabel.snp.bottom).offset(20)
            make.leading.equalTo(hostImage.snp.trailing).offset(3)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-20)
        }
        
        hostImage.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.bottom.equalTo(-20)
            make.width.height.equalTo(40)
        }
        
        hostMsgLabel.snp.makeConstraints { (make) in
            make.leading.top.equalTo(20)
            make.trailing.bottom.equalTo(-20)
        }
    }
}
