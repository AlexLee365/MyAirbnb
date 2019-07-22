//
//  CheckboxTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 19/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class CheckboxTableCell: UITableViewCell {
    static let identifier = "CheckboxTableCell"
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "편의시설"
        label.font = UIFont.systemFont(ofSize: 17.8, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
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
        
        contentView.addSubview(title)
        
        
    }
    
    
    private func setAutolayout() {
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        

    }
}

class checkBoxContainerView: UIView {
    let typeLabel1: UILabel = {
        let label = UILabel()
        label.text = "주방"
        label.font = UIFont.systemFont(ofSize: 17.5)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let typeLabel2: UILabel = {
        let label = UILabel()
        label.text = "샴푸"
        label.font = UIFont.systemFont(ofSize: 17.5)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let typeLabel3: UILabel = {
        let label = UILabel()
        label.text = "난방"
        label.font = UIFont.systemFont(ofSize: 17.5)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkBox1: UIButton = {
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
    
    let checkBox2: UIButton = {
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
    
    let checkBox3: UIButton = {
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
//        contentView.addSubview(typeLabel1)
//        contentView.addSubview(typeLabel2)
//        contentView.addSubview(typeLabel3)
//
//        checkBox1.addTarget(self, action: #selector(checkBoxBtnDidTap(_:)), for: .touchUpInside)
//        contentView.addSubview(checkBox1)
//
//        checkBox2.addTarget(self, action: #selector(checkBoxBtnDidTap(_:)), for: .touchUpInside)
//        contentView.addSubview(checkBox2)
//
//        checkBox3.addTarget(self, action: #selector(checkBoxBtnDidTap(_:)), for: .touchUpInside)
//        contentView.addSubview(checkBox3)
    }
    
//    @objc func checkBoxBtnDidTap(_ sender: UIButton) {
//        sender.isSelected.toggle()
//
//        if sender.isSelected {
//            sender.layer.borderColor = UIColor.clear.cgColor
//            sender.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
//        } else {
//            sender.layer.borderColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
//            sender.backgroundColor = .white
//        }
//    }

    
    private func setAutolayout() {
//        typeLabel1.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 28).isActive = true
//        typeLabel1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
//
//        checkBox1.topAnchor.constraint(equalTo: typeLabel1.topAnchor).isActive = true
//        checkBox1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
//        checkBox1.widthAnchor.constraint(equalToConstant: 27).isActive = true
//        checkBox1.heightAnchor.constraint(equalToConstant: 27).isActive = true
//
//        typeLabel2.topAnchor.constraint(equalTo: typeLabel1.bottomAnchor, constant: 28).isActive = true
//        typeLabel2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
//
//        checkBox2.topAnchor.constraint(equalTo: typeLabel2.topAnchor).isActive = true
//        checkBox2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
//        checkBox2.widthAnchor.constraint(equalToConstant: 27).isActive = true
//        checkBox2.heightAnchor.constraint(equalToConstant: 27).isActive = true
//
//        typeLabel3.topAnchor.constraint(equalTo: typeLabel2.bottomAnchor, constant: 28).isActive = true
//        typeLabel3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
//
//        checkBox3.topAnchor.constraint(equalTo: typeLabel3.topAnchor).isActive = true
//        checkBox3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
//        checkBox3.widthAnchor.constraint(equalToConstant: 27).isActive = true
//        checkBox3.heightAnchor.constraint(equalToConstant: 27).isActive = true
    }
}
