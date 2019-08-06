//
//  ChatTableViewCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    static let identifier = "ChatTableViewCell"
    
    
    @IBOutlet weak var contentStackView: UIStackView!
//    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageBubbleView: UIView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageInfoLabel: UILabel!
    let myImageView = UIImageView()
    let hostImageView = UIImageView()
    
    enum MessageType {
        case hosts
        case guests
    }
    
    var messageType: MessageType = .hosts
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setAutoLayout()
        configureViewsOptions()
    }
    
    private func setAutoLayout() {
        self.addSubview(myImageView)
        myImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(messageBubbleView.snp.trailing).offset(5)
            make.bottom.equalTo(messageBubbleView.snp.bottom)
            make.width.height.equalTo(40)
        }
        
        self.addSubview(hostImageView)
        hostImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(messageBubbleView.snp.leading).offset(-5)
            make.bottom.equalTo(messageBubbleView.snp.bottom)
            make.width.height.equalTo(40)
        }
    }
    
    private func configureViewsOptions() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        messageBubbleView.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        messageBubbleView.layer.cornerRadius = 5
        
        messageTextView.text = "default"
        messageTextView.textColor = StandardUIValue.shared.colorRegularText
//        messageTextView.font = .systemFont(ofSize: 16, weight: .regular)
        messageTextView.font = UIFont(name: StandardUIValue.shared.airbnbMediumFontString, size: 16)
        messageTextView.backgroundColor = .clear
        
        messageInfoLabel.text = "전송 완료 ・ 7월 4일"
//        messageInfoLabel.font = .systemFont(ofSize: 13, weight: .regular)
        messageInfoLabel.font = UIFont(name: StandardUIValue.shared.airbnbMediumFontString, size: 13)
        
        myImageView.contentMode = .scaleAspectFit
        myImageView.layer.cornerRadius = 20
        myImageView.clipsToBounds = true
        
        hostImageView.contentMode = .scaleAspectFit
        hostImageView.layer.cornerRadius = 20
        hostImageView.clipsToBounds = true
    }
    
    func setMessageType(sender: MessageType, othersName: String, amIHost: Bool, writeDate: String) {
        switch sender {
        case .hosts:
            contentStackView.alignment = .trailing
            messageBubbleView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            messageTextView.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 0.8847923801)
            
            messageInfoLabel.textColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
            messageInfoLabel.text = amIHost ? "전송완료 ・ \(writeDate)" : "\(othersName) ・ \(writeDate)"
            
            myImageView.isHidden = true
            hostImageView.isHidden = false
            
        case .guests:
            contentStackView.alignment = .leading
            messageBubbleView.backgroundColor = StandardUIValue.shared.colorBlueGreen
            messageTextView.textColor = .white
            
            messageInfoLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5335241866)
            messageInfoLabel.text = amIHost ? "\(othersName) ・ \(writeDate)" : "전송완료 ・ \(writeDate)"
            
            myImageView.isHidden = false
            hostImageView.isHidden = true
        }
    }

    
    
}
