//
//  FacilityTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 25/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class FacilityTableCell: UITableViewCell {
    static let identifier = "FacilityTableCell"
    
    private enum UI {
        static let itemsInLine: CGFloat = 3
        static let linesOnScreen: CGFloat = 3
        static let lineSpacing: CGFloat = 10.0
        static let itemSpacing: CGFloat = 10.0
        static let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "편의시설"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "회원님이 이용하실 수 있는 편의시설입니다."
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let basicLabel: UILabel = {
        let label = UILabel()
        label.text = "기본"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(FacilityCollectionCell.self, forCellWithReuseIdentifier: FacilityCollectionCell.identifier)
        return collectionView
    }()
    
    let amenitiesArray = ["셀프 체크인", "주방", "무선 인터넷", "TV", "욕실 용품", "편안한 침구", "커피메이커", "헤어드라이어", "다리미"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(basicLabel)
        
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
            make.top.equalTo(40)
            make.leading.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(20)
        }
        
        basicLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
        
        let collectionViewCellWidth: CGFloat =
            ( UIScreen.main.bounds.width - 40 - UI.lineSpacing * (UI.linesOnScreen - 1) ) / UI.linesOnScreen
        
        let collectionViewHeight: CGFloat =
            (collectionViewCellWidth * 3 + UI.itemSpacing * (UI.itemsInLine - 1)) * 1.1
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(basicLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(collectionViewHeight)
            make.bottom.equalTo(-20)
        }
    }
    
    private func setAmenityImage(amenity: String) -> UIImage {
        var imageString = ""
        
        switch amenity {
        case "셀프 체크인":
            imageString = "selfCheckIn"
        case "b":
            imageString = "imageName2"
        default: break
        }
        return UIImage(named: imageString) ?? UIImage()
    }
}


// MARK: - UICollectionViewDataSource

extension FacilityTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let facilityCell = collectionView.dequeueReusableCell(withReuseIdentifier: FacilityCollectionCell.identifier, for: indexPath) as! FacilityCollectionCell
        
        let data = amenitiesArray[indexPath.row]
        facilityCell.amenitiesImageView.image = setAmenityImage(amenity: data)
        
        return facilityCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FacilityTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpacing = UI.itemSpacing * (UI.itemsInLine - 1)
        let lineSpacing = UI.lineSpacing * (UI.linesOnScreen - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        let verticalInset = UI.edgeInsets.top + UI.edgeInsets.bottom
        
        let verticalSpacing = itemSpacing + verticalInset
        let horizontalSpacing = lineSpacing + horizontalInset
        
        let height = (collectionView.frame.height - verticalSpacing) / UI.itemsInLine
        let width = (collectionView.frame.width - horizontalSpacing) / UI.linesOnScreen
        
        let roundedHeight = height.rounded(.down)
        let roundedWidth = width.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}



