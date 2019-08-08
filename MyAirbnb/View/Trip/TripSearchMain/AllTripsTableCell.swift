//
//  AllTripsTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class AllTripsTableCell: UITableViewCell {
    static let identifier = "AllTripsTableCell"
    
    private enum UI {
        static let itemsInLine: CGFloat = 2
        static let linesOnScreen: CGFloat = 1
        static let lineSpacing: CGFloat = 20.0
        static let itemSpacing: CGFloat = 13.0
        static let edgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "모든 트립"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 23)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(TripInfoCollectionViewCell.self, forCellWithReuseIdentifier: TripInfoCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    var allTripsArray = [BestTrip]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        print("allTripsArray.count: ", allTripsArray.count)
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        contentView.addSubview(titleLabel)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = UI.lineSpacing
        layout.minimumInteritemSpacing = UI.itemSpacing
        
        collectionView.contentInset = UI.edgeInsets
        contentView.addSubview(collectionView)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
        }
        
        let cellWidth = (UIScreen.main.bounds.width - 40 - 13) / 2
        let cellHeight = cellWidth * 2.3
        
        let lineCount = allTripsArray.count / 2
        var collectionHeight: CGFloat = 0
        
        if lineCount % 2 == 0 {
            let lineSpacings = CGFloat(20 * (lineCount - 1))
            collectionHeight = cellHeight * CGFloat(lineCount) + lineSpacings + 20 + 30
        } else {
            let lineSpacings = CGFloat(20 * ((lineCount + 1) - 1))
            collectionHeight = cellHeight * CGFloat(lineCount) + lineSpacings + 20 + 30
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(collectionHeight)
            make.bottom.equalTo(-10)
        }
    }
}


// MARK: - UICollectionViewDataSource

extension AllTripsTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allTripsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TripInfoCollectionViewCell.identifier, for: indexPath) as! TripInfoCollectionViewCell
        
        cell.setData(recommendedTripData: allTripsArray[indexPath.row])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AllTripsTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpacing = UI.itemSpacing * (UI.itemsInLine - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        let horizontalSpacing = itemSpacing + horizontalInset
        
        let cellWidth: CGFloat = ((collectionView.frame.width - horizontalSpacing) / UI.itemsInLine)
        let cellHeight = cellWidth * 2.3
        
        let roundedWidth = cellWidth.rounded(.down)
        let roundedHeight = cellHeight.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}
