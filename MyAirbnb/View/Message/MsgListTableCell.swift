//
//  MsgListTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 24/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class MsgListTableCell: UITableViewCell {
    static let identifier = "MsgListTableCell"
    
    let hostImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hostImageForMsg")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let hostNameLabel: UILabel = {
        let label = UILabel()
        label.text = "K Family"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "오후 2:58"
        label.font = UIFont.systemFont(ofSize: 11.5)
        return label
    }()
    
    let nextImageLabel: UILabel = {
        let label = UILabel()
        label.text = "〉"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    let msgPreviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        label.text = "Dear Doyeong, Welcome to Japan. Yes the house is available. Thank you so much Dai and Hila"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [msgTypeLabel, separatorLabel, bookDateLabel])
        stackView.axis = .horizontal
        stackView.spacing = 3
        return stackView
    }()
    
    let msgTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "예약 문의"
        label.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.9096479024)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let separatorLabel: UILabel = {
        let label = UILabel()
        label.text = "·"
        label.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
//        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let bookDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2019. 8. 20. ~ 2019. 8. 22."
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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
        self.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        self.selectionStyle = .none
        
        contentView.addSubview(hostImageView)
        contentView.addSubview(hostNameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(nextImageLabel)
        contentView.addSubview(msgPreviewLabel)
        contentView.addSubview(stackView)
    }
    
    private func setAutolayout() {
        hostImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(50)
        }
        
        hostNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.leading.equalTo(hostImageView.snp.trailing).offset(15)
        }
        
        nextImageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.trailing.equalTo(nextImageLabel.snp.leading).offset(-5)
        }
        
        msgPreviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(hostNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(hostNameLabel)
            make.trailing.equalTo(timeLabel)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(msgPreviewLabel.snp.bottom).offset(3)
            make.leading.equalTo(hostNameLabel)
        }
    }
}
