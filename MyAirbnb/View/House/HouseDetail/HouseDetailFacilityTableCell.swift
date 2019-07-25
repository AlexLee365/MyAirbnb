//
//  HouseDetailFacilityTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 19/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HouseDetailFacilityTableCell: UITableViewCell {
    static let identifier = "HouseDetailFacilityTableCell"
    
    let titleLabel = UILabel()
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    var facilitiesArray = [String]()
    
    private enum Metric {
        static let lineSpacing: CGFloat = 15
        static let itemSpacing: CGFloat = 0
        static let nextOffSet: CGFloat = 0
        
        static let numberOfLine: CGFloat = 2
        static let numberOfItem: CGFloat = 2
        
        static let inset: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        static var horizontalPadding: CGFloat {
            return Metric.inset.left + Metric.inset.right
        }
        
        static var verticalPadding: CGFloat {
            return Metric.inset.top + Metric.inset.bottom
        }
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        
        let topBottomMargin = StandardUIValue.shared.houseDetailTopBottomMargin
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(topBottomMargin)
            make.leading.equalTo(self).offset(sideMargin)
        }
        
        self.addSubview(collectionview)
        collectionview.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(sideMargin)
            make.trailing.equalTo(self).offset(-sideMargin)
            make.height.equalTo(40)
            make.bottom.equalTo(self).offset(-topBottomMargin)
        }
        
        
    }
    
    private func configureViewsOptions() {
        titleLabel.configureHouseDetailMainText()
        titleLabel.text = "편의시설"
        
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(HouseDetailFacilityCollectCell.self, forCellWithReuseIdentifier: HouseDetailFacilityCollectCell.identifier)
        collectionview.backgroundColor = .white
        collectionview.contentInset = Metric.inset
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Metric.lineSpacing
    }
}

extension HouseDetailFacilityTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return facilitiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HouseDetailFacilityCollectCell.identifier, for: indexPath) as! HouseDetailFacilityCollectCell
        
        cell.setData(facility: facilitiesArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lineSpacing = Metric.lineSpacing * (Metric.numberOfLine - 1)
        let horizontalPadding = Metric.inset.left + Metric.inset.right + Metric.nextOffSet
        
        let itemSpacing = Metric.itemSpacing * (Metric.numberOfItem - 1)
        let verticalPadding = Metric.inset.top + Metric.inset.bottom
        
        let width = (collectionView.frame.width - itemSpacing - horizontalPadding) / Metric.numberOfItem
        let height = (collectionView.frame.height - lineSpacing - verticalPadding) / Metric.numberOfLine
        
        print("🔵🔵🔵 collectionView Frame: ", collectionView.frame)
        print("cell width: ", width)
        
        return CGSize(width: width.rounded(.down)-10, height: height.rounded(.down))
    }
    
    
}
