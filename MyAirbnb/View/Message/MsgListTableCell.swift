//
//  MsgListTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 24/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class MsgListTableCell: UITableViewCell {
    static let identifier = "MsgListTableCell"
    
    let otherPartysImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hostSample2")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let otherPartysLabel: UILabel = {
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
    
    var chatRoomData: ChatRoom?
    var isHostMode = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    private func configure() {
        self.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        self.selectionStyle = .none
        
        contentView.addSubview(otherPartysImageView)
        contentView.addSubview(otherPartysLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(nextImageLabel)
        contentView.addSubview(msgPreviewLabel)
        contentView.addSubview(stackView)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        //        msgPreviewLabel.text = "Dear \(SingletonCommonData.shared.userInfo?.username ?? "") Welcome to \(chatRoomData?.room.title ?? "")"
        
//        msgPreviewLabel.text = chatRoomData?.messages.text ?? ""
//        timeLabel.text = getMessagesLastTime()
//
//        let startDate = chatRoomData?.startDate.replacingOccurrences(of: "-", with: ".") ?? ""
//        let endDate = chatRoomData?.endDate.replacingOccurrences(of: "-", with: ".") ?? ""
//        bookDateLabel.text = "\(startDate) ~ \(endDate)"
//
//
//        if isHostMode {
//            hostNameLabel.text = chatRoomData?.messages.author.username ?? ""
//            hostImageView.image = UIImage(named: "userProfileImage")
//        } else {
//             hostNameLabel.text = chatRoomData?.room.host.username
//            guard let imageUrl = URL(string: chatRoomData?.room.host.image ?? "") else { return }
//            hostImageView.kf.setImage(with: imageUrl)
//        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        msgPreviewLabel.text = chatRoomData?.messages.text ?? ""
//        timeLabel.text = getMessagesLastTime()
    }
    
    private func setAutolayout() {
        otherPartysImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(50)
        }
        
        otherPartysLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.leading.equalTo(otherPartysImageView.snp.trailing).offset(15)
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
            make.top.equalTo(otherPartysLabel.snp.bottom).offset(5)
            make.leading.equalTo(otherPartysLabel)
            make.trailing.equalTo(-30)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(msgPreviewLabel.snp.bottom).offset(3)
            make.leading.equalTo(otherPartysLabel)
        }
    }
    
    func getMessagesLastTime(chatRoom: ChatRoom) -> String {
        
        let lastTimeString = chatRoom.messages.created
//        print("lastTimeString: ", lastTimeString)
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateformatter.date(from: lastTimeString) else { print("‼️ dateformmater error "); return ""}
        dateformatter.dateFormat = "a h:mm"
        dateformatter.locale = Locale(identifier: "ko")
//        dateformatter.amSymbol = "오전"
//        dateformatter.pmSymbol = "오후"
        
        let lastTimeAfterConvert = dateformatter.string(from: date)
        return lastTimeAfterConvert
    }
    
    func setData(chatRoomData: ChatRoom, isHost: Bool) {
        
        msgPreviewLabel.text = chatRoomData.messages.text
        timeLabel.text = getMessagesLastTime(chatRoom: chatRoomData)
        
        let startDate = chatRoomData.startDate.replacingOccurrences(of: "-", with: ".")
        let endDate = chatRoomData.endDate.replacingOccurrences(of: "-", with: ".")
        bookDateLabel.text = "\(startDate) ~ \(endDate)"
        
        if isHost {
            otherPartysLabel.text = chatRoomData.messages.author.username
            otherPartysImageView.image = UIImage(named: "userProfileImage")    // 유저 이미지: Placeholder Image
        } else {
            otherPartysLabel.text = chatRoomData.room.host.username
            guard let imageUrl = URL(string: chatRoomData.room.host.image ?? "") else {
                otherPartysImageView.image = UIImage(named: "hostSample2")
                return
            }
            otherPartysImageView.kf.setImage(with: imageUrl)
        }
    }
}
