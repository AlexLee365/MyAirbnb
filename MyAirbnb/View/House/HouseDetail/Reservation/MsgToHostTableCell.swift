//
//  MsgToHostTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class MsgToHostTableCell: UITableViewCell {
    static let identifier = "MsgToHostTableCell"
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        textView.font = UIFont(name: "AirbnbCerealApp-Book", size: 17)
        textView.autocorrectionType = .no
        return textView
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
        self.hideSeparator()
        
        textView.delegate = self
        contentView.addSubview(textView)
    }
    
    private func setAutolayout() {
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.4)
        }
    }
}

// MARK: - UITextViewDelegate

extension MsgToHostTableCell: UITextViewDelegate {
    
}
