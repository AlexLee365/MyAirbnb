//
//  ItemsProvidingTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 29/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class ItemsProvidingTableCell: UITableViewCell {
    static let identifier = "ItemsProvidingTableCell"
    
    private enum UI {
        static let itemsInLine: CGFloat = 1
        static let linesOnScreen: CGFloat = 1
        static let lineSpacing: CGFloat = 13.0
        static let itemSpacing: CGFloat = 0.0
        static let edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        static let nextOffset: CGFloat = 130
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제공 항목"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 25)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ProvidingItemsCollectionCell.self, forCellWithReuseIdentifier: ProvidingItemsCollectionCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let itemsImageArray = ["video_detail_food_icon",
                           "video_detail_accommodation_icon",
                           "video_detail_transport_icon",
                           "video_detail_tools_icon",
                           "video_detail_drinks_icon"]
    
    let itemsDescArray = [("음식", "5 점심식사, 3 아침식사, 3 저녁식사, 2 tasting menus, 간식"),
                          ("숙박", "호텔에서의 6박, 호스텔에서의 1박, 기타"),
                          ("교통편", "승용차 3회 탑승, 보트 3회 탑승, 버스 2회 탑승"),
                          ("장비", "스포츠 장비, 안전 장비, 야외 장비, 기타"), ("음료", "와인, 물, 칵테일, 주스")]
    
    
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
        
        contentView.addSubview(titleLabel)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = UI.lineSpacing
        layout.minimumInteritemSpacing = UI.itemSpacing
        
        collectionView.contentInset = UI.edgeInsets
        contentView.addSubview(collectionView)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.leading.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
            make.bottom.equalTo(-20)
        }
    }
    
    private func setItemImage(category: String) -> UIImage {
        var imageString = ""
        
        switch category {
        case "음식":
            imageString = "video_detail_food_icon"
        case "숙박":
            imageString = "video_detail_accommodation_icon"
        case "교통편": 
            imageString = "video_detail_transport_icon"
        case "장비":
            imageString = "video_detail_tools_icon"
        case "음료":
            imageString = "video_detail_drinks_icon"
        default: break
        }
        return UIImage(named: imageString)!
    }
}


// MARK: - UICollectionViewDataSource

extension ItemsProvidingTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsDescArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemsCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProvidingItemsCollectionCell.identifier, for: indexPath) as! ProvidingItemsCollectionCell
        
        itemsCell.itemImage.image = setItemImage(category: itemsDescArray[indexPath.row].0)
        itemsCell.titleLabel.text = itemsDescArray[indexPath.row].0
        itemsCell.descLabel.text = itemsDescArray[indexPath.row].1
        
        return itemsCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ItemsProvidingTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lineSpacing = UI.lineSpacing
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        
        let horizontalSpacing = lineSpacing + horizontalInset + UI.nextOffset
        let cellWidth: CGFloat = ((collectionView.frame.width - horizontalSpacing) / UI.linesOnScreen)
        let cellHeight = collectionView.frame.height * 0.9
        
        let roundedWidth = cellWidth.rounded(.down)
        let roundedHeight = cellHeight.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}
