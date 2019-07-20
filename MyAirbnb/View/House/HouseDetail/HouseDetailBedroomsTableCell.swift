//
//  HouseDetailBedroomsTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 19/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseDetailBedroomsTableCell: UITableViewCell {
    
    let titleLabel = UILabel()
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    private enum Metric {
        static let lineSpacing: CGFloat = 3
        static let itemSpacing: CGFloat = 3
        static let nextOffSet: CGFloat = 5
        
        static let numberOfLine: CGFloat = 2
        static let numberOfItem: CGFloat = 2
        
        static let inset: UIEdgeInsets = .init(top: 6, left: 6, bottom: 6, right: 6)
        
        static var horizontalPadding: CGFloat {
            return Metric.inset.left + Metric.inset.right
        }
        
        static var verticalPadding: CGFloat {
            return Metric.inset.top + Metric.inset.bottom
        }
        
        static var cellSize: CGSize {
            let lineSpacing = Metric.lineSpacing * (Metric.numberOfLine - 1)
            let horizontalPadding = Metric.inset.left + Metric.inset.right + Metric.nextOffSet
            
            let itemSpacing = Metric.itemSpacing * (Metric.numberOfItem - 1)
            let verticalPadding = Metric.inset.top + Metric.inset.bottom
            
//            let width = (collectionView.frame.width - lineSpacing - horizontalPadding) / Metric.numberOfLine
//            let height = (collectionView.frame.height - itemSpacing - verticalPadding) / Metric.numberOfItem
            
//            return CGSize(width: width.rounded(.down), height: height.rounded(.down))
            return CGSize.zero
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let topBottomMargin = StandardUIValue.shared.houseDetailTopBottomMargin
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topBottomMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        
        titleLabel.configureHouseDetailMainText()
        titleLabel.text = "침대/침구"
        
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topBottomMargin).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: sideMargin).isActive = true
//        collectionView.heightAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutDimension>#>, constant: <#T##CGFloat#>)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
