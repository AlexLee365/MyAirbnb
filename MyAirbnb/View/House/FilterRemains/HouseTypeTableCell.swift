//
//  HouseTypeTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 19/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseTypeTableCell: UITableViewCell {
    static let identifier = "HouseTypeTableCell"
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "숙소 유형"
        label.font = UIFont.systemFont(ofSize: 17.8, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descLabelArray = [UILabel]()
    var checkBoxArray = [UIButton]()
    
    var houseDataArray = [(String, String)]()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
        createTypeData()
        createLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.selectionStyle = .none
        
        contentView.addSubview(title)
    }
    
    private func createTypeData() {
        houseDataArray = [("집 전체", "집 전체를 단독으로 사용합니다"), ("개인실", "침실은 단독으로 쓰고, 이외의 공간은 호스트나 다른 게스트와 함께 이용할 수도 있습니다."), ("호텔 객실", "부티크 호텔, 호스텔 등의 개인실이나 다인실을 이용합니다"), ("다인실", "사적 공간 없이, 침실이나 욕실 등을 호스트나 다른 게스트와 함께 이용합니다")]
    }
    
    private func createLabels() {
        
        for i in 0...3 {
            
            let typeLabel = UILabel()
            typeLabel.font = UIFont.systemFont(ofSize: 17.5)
            typeLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            typeLabel.text = houseDataArray[i].0
            contentView.addSubview(typeLabel)
            
            typeLabel.translatesAutoresizingMaskIntoConstraints = false
            (i == 0) ? (typeLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25).isActive = true) : (typeLabel.topAnchor.constraint(equalTo: descLabelArray.last!.bottomAnchor, constant: 25).isActive = true)
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            
            let descLabel = UILabel()
            descLabel.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
            descLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            descLabel.text = houseDataArray[i].1
            descLabel.numberOfLines = 0
            contentView.addSubview(descLabel)
            
            descLabel.translatesAutoresizingMaskIntoConstraints = false
            descLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 5).isActive = true
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            descLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
            (i == 3) ? (descLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25).isActive = true) : ()
            
            let checkBoxBtn = UIButton()
            checkBoxBtn.layer.borderWidth = 1
            checkBoxBtn.layer.borderColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
            checkBoxBtn.layer.cornerRadius = 4
            checkBoxBtn.setImage(UIImage(named: "filterTick"), for: .selected)
            checkBoxBtn.imageView?.contentMode = .scaleAspectFit
            checkBoxBtn.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 5, right: 3)
            checkBoxBtn.addTarget(self, action: #selector(checkBoxBtnDidTap(_:)), for: .touchUpInside)
            checkBoxBtn.tag = i
            contentView.addSubview(checkBoxBtn)
            
            checkBoxBtn.translatesAutoresizingMaskIntoConstraints = false
            checkBoxBtn.topAnchor.constraint(equalTo: typeLabel.topAnchor).isActive = true
            checkBoxBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
            checkBoxBtn.widthAnchor.constraint(equalToConstant: 27).isActive = true
            checkBoxBtn.heightAnchor.constraint(equalToConstant: 27).isActive = true
            
            descLabelArray.append(descLabel)
            checkBoxArray.append(checkBoxBtn)
        }
    }
    
    @objc private func checkBoxBtnDidTap(_ sender: UIButton) {
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
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    }
}
