//
//  TopScrollView.swift
//  MyAirbnb
//
//  Created by Solji Kim on 09/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class TopScrollView: UIView {
        
    let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let categotyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        self.addSubview(topImageView)
        self.addSubview(categotyLabel)
        self.addSubview(titleLabel)
    }
    
    private func setAutolayout() {
        topImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        topImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        topImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        categotyLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10).isActive = true
        categotyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    }
}
