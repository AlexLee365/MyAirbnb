//
//  HouseDetailBedroomsTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 19/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseDetailBedroomsTableCell: UITableViewCell {
    static let identifier = "HouseDetailBedroomsTableCell"
    
    let titleLabel = UILabel()
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    var bedRoomCount = 0
    
    private enum Metric {
        static let lineSpacing: CGFloat = 20
        static let itemSpacing: CGFloat = 0
        static let nextOffSet: CGFloat = 70
        
        static let numberOfLine: CGFloat = 2
        static let numberOfItem: CGFloat = 1
        
        static let inset: UIEdgeInsets = .init(top: 0, left: StandardUIValue.shared.mainViewSideMargin, bottom: 0, right: StandardUIValue.shared.mainViewSideMargin)
        
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
    
    private func setAutoLayout() {
        let topBottomMargin = StandardUIValue.shared.houseDetailTopBottomMargin
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topBottomMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        
        titleLabel.configureHouseDetailMainText()
        titleLabel.text = "침대/침구"
        
        self.addSubview(collectionView)
        let collectionViewWidth: CGFloat = (UIScreen.main.bounds.width - Metric.horizontalPadding - Metric.lineSpacing - Metric.nextOffSet) / Metric.numberOfLine
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topBottomMargin).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewWidth+1).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -topBottomMargin).isActive = true
    }
    
    private func configureViewsOptions() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HouseDetailBedRoomsCollectCell.self, forCellWithReuseIdentifier: HouseDetailBedRoomsCollectCell.identifier)
        collectionView.contentInset = Metric.inset
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Metric.lineSpacing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

extension HouseDetailBedroomsTableCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bedRoomCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HouseDetailBedRoomsCollectCell.identifier, for: indexPath) as! HouseDetailBedRoomsCollectCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lineSpacing = Metric.lineSpacing * (Metric.numberOfLine - 1)
        let horizontalPadding = Metric.inset.left + Metric.inset.right + Metric.nextOffSet
        
        let itemSpacing = Metric.itemSpacing * (Metric.numberOfItem - 1)
        let verticalPadding = Metric.inset.top + Metric.inset.bottom
        
        let width = (collectionView.frame.width - lineSpacing - horizontalPadding) / Metric.numberOfLine
        let height = width
        
        return CGSize(width: width.rounded(.down), height: height.rounded(.down))
    }
    
    
}
