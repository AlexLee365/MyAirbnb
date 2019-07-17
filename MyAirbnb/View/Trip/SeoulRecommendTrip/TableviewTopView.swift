//
//  TableviewTopView.swift
//  MyAirbnb
//
//  Created by Solji Kim on 09/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

protocol TableviewTopViewDelegate: class {
    func popView()
}

class TableviewTopView: UIView {
    
    weak var delegate: TableviewTopViewDelegate?
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backWhite"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heartWhite"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "shareWhite"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
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
        delegate?.popView()
    }
    
    private func setAutolayout() {

        backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        heartButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        heartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        heartButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        heartButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        shareButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
