//
//  CheckboxContainerView.swift
//  MyAirbnb
//
//  Created by Solji Kim on 22/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class CheckBoxContainerView: UIView {
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.5)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkBox: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        button.layer.cornerRadius = 4
        button.setImage(UIImage(named: "filterTick"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 5, right: 3)
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
        self.addSubview(typeLabel)
        
        checkBox.addTarget(self, action: #selector(checkBoxBtnDidTap(_:)), for: .touchUpInside)
        self.addSubview(checkBox)
    }
    
    @objc func checkBoxBtnDidTap(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            sender.layer.borderColor = UIColor.clear.cgColor
            sender.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        } else {
            sender.layer.borderColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
            sender.backgroundColor = .white
        }
    }
    
    private func setAutolayout() {
        typeLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        checkBox.topAnchor.constraint(equalTo: typeLabel.topAnchor).isActive = true
        checkBox.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        checkBox.widthAnchor.constraint(equalToConstant: 27).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 27).isActive = true
    }
}
