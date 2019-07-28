//
//  BedFilterTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 22/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class BedFilterTableCell: UITableViewCell {
    static let identifier = "BedFilterTableCell"
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "침실과 침대"
        label.font = UIFont.systemFont(ofSize: 17.8, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bedContainerView = BedContainerView()
    let bedroomContainerView = BedContainerView()
    let bathroomContainerView = BedContainerView()
    
    var selectedBed = (0, 0, 0)
    
    var bedCount = 0 {
        didSet {
            bedContainerView.countLabel.text = "\(bedCount)"

            guard bedCount > 0 else {
                bedContainerView.minusBtn.isEnabled = false
                return }
            
            bedContainerView.minusBtn.isEnabled = true
        }
    }
    
    var bedroomCount = 0 {
        didSet {
            bedroomContainerView.countLabel.text = "\(bedroomCount)"
           
            guard bedroomCount > 0 else {
                bedroomContainerView.minusBtn.isEnabled = false
                return }
            
            bedroomContainerView.minusBtn.isEnabled = true
        }
    }
    
    var bathroomCount = 0 {
        didSet {
            bathroomContainerView.countLabel.text = "\(bathroomCount)"
           
            guard bathroomCount > 0 else {
                bathroomContainerView.minusBtn.isEnabled = false
                return }
            
            bathroomContainerView.minusBtn.isEnabled = true
        }
    }
    
    let notiCenter = NotificationCenter.default
    
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
        
        bedContainerView.label.text = "침대 수"
        bedContainerView.minusBtn.isEnabled = false
        bedContainerView.minusBtn.addTarget(self, action: #selector(minusBtnDidTap(_:)), for: .touchUpInside)
        bedContainerView.minusBtn.tag = 1
        bedContainerView.plusBtn.addTarget(self, action: #selector(plusBtnDidTap(_:)), for: .touchUpInside)
        bedContainerView.plusBtn.tag = 1
        contentView.addSubview(bedContainerView)
        
        bedroomContainerView.label.text = "침실 수"
        bedroomContainerView.minusBtn.isEnabled = false
        bedroomContainerView.minusBtn.addTarget(self, action: #selector(minusBtnDidTap(_:)), for: .touchUpInside)
        bedroomContainerView.minusBtn.tag = 2
        bedroomContainerView.plusBtn.addTarget(self, action: #selector(plusBtnDidTap(_:)), for: .touchUpInside)
        bedroomContainerView.plusBtn.tag = 2
        contentView.addSubview(bedroomContainerView)
        
        bathroomContainerView.label.text = "욕실 수"
        bathroomContainerView.minusBtn.isEnabled = false
        bathroomContainerView.minusBtn.addTarget(self, action: #selector(minusBtnDidTap(_:)), for: .touchUpInside)
        bathroomContainerView.minusBtn.tag = 3
        bathroomContainerView.plusBtn.addTarget(self, action: #selector(plusBtnDidTap(_:)), for: .touchUpInside)
        bathroomContainerView.plusBtn.tag = 3
        contentView.addSubview(bathroomContainerView)
    }
    
    @objc func minusBtnDidTap(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            bedCount -= 1
        case 2:
            bedroomCount -= 1
        case 3:
            bathroomCount -= 1
        default:
            break
        }
        notiCenter.post(name: .bedroomsCountChanged, object: nil, userInfo: ["count": (bedCount, bedroomCount, bathroomCount)])
    }
    
    @objc func plusBtnDidTap(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            bedCount += 1
        case 2:
            bedroomCount += 1
        case 3:
            bathroomCount += 1
        default:
            break
        }
        notiCenter.post(name: .bedroomsCountChanged, object: nil, userInfo: ["count": (bedCount, bedroomCount, bathroomCount)])
    }
    
    
    private func setAutolayout() {
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        bedContainerView.translatesAutoresizingMaskIntoConstraints = false
        bedContainerView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 28).isActive = true
        bedContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        bedContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        bedroomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bedroomContainerView.topAnchor.constraint(equalTo: bedContainerView.bottomAnchor, constant: 28).isActive = true
        bedroomContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        bedroomContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        bathroomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bathroomContainerView.topAnchor.constraint(equalTo: bedroomContainerView.bottomAnchor, constant: 28).isActive = true
        bathroomContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        bathroomContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        bathroomContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
}


class BedContainerView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.5)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let minusBtn: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "minusIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let plusBtn: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plusIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 13.5)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.textAlignment = .center
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
        self.addSubview(label)
        self.addSubview(minusBtn)
        self.addSubview(countLabel)
        self.addSubview(plusBtn)
    }
    
    private func setAutolayout() {
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        plusBtn.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        plusBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        plusBtn.widthAnchor.constraint(equalToConstant: 33).isActive = true
        plusBtn.heightAnchor.constraint(equalToConstant: 33).isActive = true
        plusBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        countLabel.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: plusBtn.leadingAnchor, constant: -5).isActive = true
        countLabel.widthAnchor.constraint(equalToConstant: 33).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 33).isActive = true
        
        minusBtn.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        minusBtn.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -5).isActive = true
        minusBtn.widthAnchor.constraint(equalToConstant: 33).isActive = true
        minusBtn.heightAnchor.constraint(equalToConstant: 33).isActive = true
    }
}
