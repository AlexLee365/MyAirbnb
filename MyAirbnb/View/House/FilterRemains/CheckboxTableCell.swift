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
        label.font = UIFont.systemFont(ofSize: 17.8, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seeAllBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override var isSelected: Bool {
        willSet {
            newValue ? isTrue() : isFalse()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var checkBoxViewArray = [CheckBoxContainerView]()
    
//    func setting(data: CheckBoxData) {
//        title.text = data.title
//        seeAllBtn.setTitle(data.buttonTitle, for: .normal)
//
//        for (_, value) in data.contentArray.enumerated() {
//            let customView = CheckBoxContainerView()
//
//            customView.typeLabel.text = value.type
//            checkBoxViewArray.append(customView)
//        }
//
//        showThreeCheckBox()
//    }
    
    var visibleCheckBox = [CheckBoxContainerView]()
    
    func setting(data: CheckBoxData) {
        title.text = data.title
        seeAllBtn.setTitle(data.buttonTitle, for: .normal)
        
        for (index, value) in data.contentArray.enumerated() {
            let customView = CheckBoxContainerView()
            
            guard index < 3 else { return }

            customView.typeLabel.text = value.type
            checkBoxViewArray.append(customView)
            
            contentView.addSubview(customView)
            
            customView.translatesAutoresizingMaskIntoConstraints = false
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
            
            switch index {
            case 0:
                customView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25).isActive = true
            case 2:
                customView.bottomAnchor.constraint(equalTo: seeAllBtn.topAnchor, constant: -25).isActive = true
                fallthrough
            default:
                customView.topAnchor.constraint(equalTo: checkBoxViewArray[index - 1].bottomAnchor, constant: 25).isActive = true
            }
        }
        
//        showThreeCheckBox()
    }
    
    
//    private func showThreeCheckBox() {
//        visibleCheckBox.removeAll()
//
//        for (index, view) in checkBoxViewArray.enumerated() {
//            guard index < 3 else { return }
//            visibleCheckBox.append(view)
//            contentView.addSubview(view)
//
//            switch index {
//            case 0:
//                view.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25).isActive = true
//            default:
//                view.topAnchor.constraint(equalTo: checkBoxViewArray[index - 1].bottomAnchor, constant: 25).isActive = true
//            }
//
//            view.translatesAutoresizingMaskIntoConstraints = false
//            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
//            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
//        }
//    }
    
//    private func showAllCheckBox() {
//        visibleCheckBox.removeAll()
//
//        for (index, view) in checkBoxViewArray.enumerated() {
//            contentView.addSubview(view)
//            visibleCheckBox.append(view)
//        }
//    }
    
    
    func isTrue() {
        for i in checkBoxViewArray {
            i.checkBox.layer.borderColor = UIColor.clear.cgColor
            i.checkBox.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        }
    }
    
    func isFalse() {
        for i in checkBoxViewArray {
            i.checkBox.layer.borderColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
            i.checkBox.backgroundColor = .white
        }
    }
    

    private func configure() {
        self.selectionStyle = .none
        
        contentView.addSubview(title)
        contentView.addSubview(seeAllBtn)
    }
    
    
    private func setAutolayout() {
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        seeAllBtn.translatesAutoresizingMaskIntoConstraints = false
        seeAllBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        seeAllBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        seeAllBtn.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
}


