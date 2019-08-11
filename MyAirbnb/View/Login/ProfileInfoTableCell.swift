//
//  ProfileInfoTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ProfileInfoTableCell: UITableViewCell {
    static let identifier = "ProfileInfoTableCell"
    
    let myNameLabel: UILabel = {
        let label = UILabel()
        label.text = SingletonCommonData.shared.userInfo?.username ?? "Doyeong"
        label.font = UIFont.boldSystemFont(ofSize: 29)
        label.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        return label
    }()
    
    let editLabel: UILabel = {
        let label = UILabel()
        label.text = "프로필 확인 및 수정"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        return label
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "userProfileImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    let transparentBtn: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let stageRemainsLabel: UILabel = {
        let label = UILabel()
        label.text = "4단계 완성"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        return label
    }()
    
    let statusViewContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        view.layer.cornerRadius = 4
        return view
    }()
    
    let fillContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        view.layer.cornerRadius = 4
        return view
    }()
    
    let recommendLabel: UILabel = {
        let label = UILabel()
        label.text = "에어비앤비는 모든 회원님께 여행 또는 호스팅 전에 몇 가지 내용을 자세히 작성해주실 것을 부탁드리고 있습니다. 지금 작성하시면 나중에 수고를 줄일 수 있어요."
        label.setLineSpacing(lineSpacing: 3.0)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        return label
    }()
    
    var separatorViewArray = [UIView]()
    
    
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
        
        contentView.addSubview(myNameLabel)
        contentView.addSubview(editLabel)
        contentView.addSubview(profileImage)
        contentView.addSubview(transparentBtn)
        contentView.addSubview(stageRemainsLabel)
        contentView.addSubview(statusViewContainerView)
        statusViewContainerView.addSubview(fillContainerView)
        contentView.addSubview(recommendLabel)
        
        if let url = URL(string: SingletonCommonData.shared.userInfo?.image ?? "") {
            profileImage.kf.setImage(with: url)            
        }
        
    }
    
    private func setAutolayout() {
        myNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(48)
            make.leading.equalTo(20)
        }
        
        editLabel.snp.makeConstraints { (make) in
            make.top.equalTo(myNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(20)
        }
        
        profileImage.snp.makeConstraints { (make) in
            make.top.equalTo(70)
            make.trailing.equalTo(-20)
            make.width.height.equalTo(60)
        }
        
        transparentBtn.snp.makeConstraints { (make) in
            make.top.equalTo(myNameLabel)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(profileImage.snp.bottom)
        }
        
        stageRemainsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(transparentBtn.snp.bottom).offset(25)
            make.leading.equalTo(20)
        }
        
        statusViewContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(stageRemainsLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(40)
        }
        
        fillContainerView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        createSeparatorView()
        
        //        let offset = ((UIScreen.main.bounds.width - 40) / 4) - 3
        //        separatorView.frame = CGRect(x: offset, y: 0, width: 3, height: 40)
        
        recommendLabel.snp.makeConstraints { (make) in
            make.top.equalTo(statusViewContainerView.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-20)
        }
    }
    
    private func createSeparatorView() {
        for _ in 1...3 {
            let separatorView: UIView = {
                let view = UIView()
                view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                return view
            }()
            separatorViewArray.append(separatorView)
        }
        
        var offset: CGFloat = 0
        
        for i in 0..<separatorViewArray.count {
            offset += ((UIScreen.main.bounds.width - 40 - 3) / 4)
            separatorViewArray[i].frame = CGRect(x: offset, y: 0, width: 3, height: 40)
            statusViewContainerView.addSubview(separatorViewArray[i])
        }
    }
}

