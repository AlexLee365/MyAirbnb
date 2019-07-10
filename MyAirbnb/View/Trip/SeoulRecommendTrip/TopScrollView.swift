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
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let gradientView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var gradient = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var setLayout = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if setLayout {
            createGradient()
            gradient.frame = gradientView.bounds
            setLayout = false
        }
    }
    
    private func configure() {
        self.addSubview(topImageView)
        
        self.addSubview(gradientView)
        
        self.addSubview(categoryLabel)
        self.addSubview(titleLabel)
    }
    
    private func setAutolayout() {
        topImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        topImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        topImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        gradientView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -65).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        categoryLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    }
    
    private func createGradient() {
        
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.65, 1]
        gradientView.layer.mask = gradient
    }
}
