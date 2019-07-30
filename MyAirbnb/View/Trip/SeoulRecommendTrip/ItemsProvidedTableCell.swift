//
//  ItemsProvidedTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 27/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class ItemsProvidedTableCell: UITableViewCell {
    static let identifier = "ItemsProvidedTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.configureTripDetailTitle()
        label.text = "제공 항목"
        return label
    }()
    
    let itemsArray = ["음료", "티켓", "장비"]
    let itemsDescArray = ["웰컴 커피와 비건 디저트", "포장박스, 비건 스티커 7종 쇼핑백", "1인당 비건 배쓰밤 3개 (size: 지름 7cm)"]
    
    var labelConfigArray = [(UILabel, UIImageView, UILabel)]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
        
        setItemsProvidedLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureImageForItem(item: String) -> UIImage {
        var imageString = ""
        
        switch item {
        case "음료":
            imageString = "trip_drinksIcon"
        case "티켓":
            imageString = "trip_ticketIcon"
        case "장비":
            imageString = "trip_toolsIcon"
        case "생수":
            imageString = "trip_drinksIcon"
        case "음식":
            imageString = "trip_snacksIcon"
        case "간식":
            imageString = "trip_snacksIcon"
        case "교통편":
            imageString = "trip_transportIcon"
        default: break
        }
        
        return UIImage(named: imageString) ?? UIImage()
    }
    
    private func setItemsProvidedLabel() {
        
        for i in 0..<itemsArray.count {
            let itemLabel: UILabel = {
                let label = UILabel()
                label.configureTripDetailDesc()
                label.text = itemsArray[i]
                return label
            }()
            
            let itemImage: UIImageView = {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                imageView.image = configureImageForItem(item: itemsArray[i])
                return imageView
            }()
            
            let descLabel: UILabel = {
                let label = UILabel()
                label.configureTripDetailDesc()
                label.font = UIFont(name: "AirbnbCerealApp-Book", size: 14.5)
                label.text = itemsDescArray[i]
                return label
            }()
            
            labelConfigArray.append((itemLabel, itemImage, descLabel))
        }
        
        for i in 0..<labelConfigArray.count {
            contentView.addSubview(labelConfigArray[i].0)
            contentView.addSubview(labelConfigArray[i].1)
            contentView.addSubview(labelConfigArray[i].2)
            
            labelConfigArray[i].0.snp.makeConstraints { (make) in
                make.leading.equalTo(20)
            }
            
            labelConfigArray[i].1.snp.makeConstraints { (make) in
                make.leading.equalTo(labelConfigArray[i].0.snp.trailing).offset(3)
                make.centerY.equalTo(labelConfigArray[i].0.snp.centerY)
            }
            
            labelConfigArray[i].2.snp.makeConstraints { (make) in
                make.top.equalTo(labelConfigArray[i].0.snp.bottom).offset(5)
                make.leading.equalTo(labelConfigArray[i].0.snp.leading)
            }
            
            switch i {
            case 0:
                labelConfigArray[i].0.snp.makeConstraints { (make) in
                    make.top.equalTo(titleLabel.snp.bottom).offset(25)
                }
                
                labelConfigArray[i].1.snp.makeConstraints { (make) in
                    make.top.equalTo(titleLabel.snp.bottom).offset(25)
                }
                
            case labelConfigArray.count - 1:
                labelConfigArray[i].2.snp.makeConstraints { (make) in
                    make.bottom.equalToSuperview().offset(-20)
                }
                fallthrough
                
            default:
                labelConfigArray[i].0.snp.makeConstraints { (make) in
                    make.top.equalTo(labelConfigArray[i-1].2.snp.bottom).offset(25)
                }
            }
        }
    }
    
    private func configure() {
        self.selectionStyle = .none
        
        contentView.addSubview(titleLabel)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
        }
    }
}
