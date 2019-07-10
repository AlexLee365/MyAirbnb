//
//  TableviewTopView.swift
//  MyAirbnb
//
//  Created by Solji Kim on 09/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

protocol TableviewTopViewDelegate: class {
    func viewDismiss()
}

class TableviewTopView: UIView {
    
    weak var delegate: TableviewTopViewDelegate?
    
    let backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "backWhite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let heartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "heartWhite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "shareWhite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        backButton.addTarget(self, action: #selector(backButtonDidTap(_:)), for: .touchUpInside)
        self.addSubview(backButton)
        
        self.addSubview(shareButton)
        
        self.addSubview(heartButton)
    }
    
    @objc private func backButtonDidTap(_ sender: UIButton) {
        delegate?.viewDismiss()
    }
    
    private func setAutolayout() {
//        backButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
//        heartButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        heartButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        heartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        heartButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        heartButton.heightAnchor.constraint(equalToConstant: 20).isActive = true

//        shareButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor, constant: -30).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
