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
        return label
    }()
    
    let itemsArray = ["", "", ""]
    var providesCount = 0
    
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
    
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        setItemsProvidedLabel()
//        print("providesCount: ", providesCount)
//    }
    
    private func configure() {
        self.selectionStyle = .none
        
        contentView.addSubview(titleLabel)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
        }
    }
    
    
    func configureImageForItem(item: String) -> UIImage {
        var imageString = ""
        
        switch item {
        case "음료":
            imageString = "trip_drinksIcon"
        case "입장권 1매":
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
        for _ in 0..<itemsArray.count {
//        for _ in 0..<providesCount {
            let itemLabel: UILabel = {
                let label = UILabel()
                label.configureTripDetailDesc()
                return label
            }()
            
            let itemImage: UIImageView = {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                return imageView
            }()
            
            let descLabel: UILabel = {
                let label = UILabel()
                label.configureTripDetailDesc()
                label.font = UIFont(name: "AirbnbCerealApp-Book", size: 14.5)
                return label
            }()
            
            labelConfigArray.append((itemLabel, itemImage, descLabel))
        }
        
        for i in 0..<labelConfigArray.count {
            contentView.addSubview(labelConfigArray[i].0)
            contentView.addSubview(labelConfigArray[i].1)
            contentView.addSubview(labelConfigArray[i].2)
            
//            labelConfigArray[i].0.backgroundColor = .blue
//            labelConfigArray[i].1.backgroundColor = .red
//            labelConfigArray[i].2.backgroundColor = .yellow
            
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
    

    func setData(itemProvidedData: TripDetail) {
        if !itemProvidedData.provides.isEmpty {
            titleLabel.text = "제공 항목"
            for i in 0..<itemProvidedData.provides.count {
                labelConfigArray[i].0.text = itemProvidedData.provides[i]?.provideSet
                labelConfigArray[i].1.image =
                    configureImageForItem(item: itemProvidedData.provides[i]?.provideSet ?? "")
                labelConfigArray[i].2.text = itemProvidedData.provides[i]?.provideDescription
            }
        }
    }
}
