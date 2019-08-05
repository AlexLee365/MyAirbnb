//
//  HostIntroTableViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 10/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HostIntroTableViewCell: UITableViewCell {
    static let identifier = "hostIntroTableViewCell"
    
    let hostIntroLabel: UILabel = {
        let label = UILabel()
        label.configureTripDetailTitle()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let touchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let messageButton: UIButton = {
        let button = UIButton()
        button.setTitle("메시지", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let introBody: UILabel = {
        let label = UILabel()
        label.configureTripDetailDesc()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
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
        
        contentView.addSubview(hostIntroLabel)
        contentView.addSubview(profileImage)
        contentView.addSubview(touchButton)
        contentView.addSubview(messageButton)
        contentView.addSubview(introBody)
    }

    
    private func setAutolayout() {
        
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        hostIntroLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        hostIntroLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        
        profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        profileImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideMargin).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        touchButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        touchButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        touchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        touchButton.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        messageButton.topAnchor.constraint(equalTo: hostIntroLabel.bottomAnchor, constant: 15).isActive = true
        messageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        
        introBody.topAnchor.constraint(equalTo: touchButton.bottomAnchor, constant: 5).isActive = true
        introBody.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        introBody.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideMargin).isActive = true
        introBody.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
    
    func setData(hostDetailData: TripDetail) {
        hostIntroLabel.text = "호스트 \(hostDetailData.host.username)님 소개"
        
        let imageUrl = URL(string: hostDetailData.host.image)
        
        profileImage.kf.setImage(with: imageUrl)
        introBody.text = hostDetailData.hostAbout
    }
}
