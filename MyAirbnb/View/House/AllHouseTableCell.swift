//
//  AllHouseTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 14/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class AllHouseTableCell: UITableViewCell {
    static let identifier = "AllHouseTableCell"
    
    private enum UI {
        static let itemsInLine: CGFloat = 1
        static let linesOnScreen: CGFloat = 1
        static let lineSpacing: CGFloat = 0
        static let itemSpacing: CGFloat = 30.0
        static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "300개 이상의 숙소 모두 둘러보기"
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .blue
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
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
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AllHouseCollectionCell.self, forCellWithReuseIdentifier: AllHouseCollectionCell.identifier)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = UI.lineSpacing
        layout.minimumInteritemSpacing = UI.itemSpacing
        
        collectionView.contentInset = UI.edgeInsets
        contentView.addSubview(collectionView)
    }
    
    private func setAutolayout() {
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}


// MARK: - UICollectionViewDataSource

extension AllHouseTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllHouseCollectionCell.identifier, for: indexPath) as! AllHouseCollectionCell
        cell.backgroundColor = .yellow
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension AllHouseTableCell: UICollectionViewDelegate {
    
}


// MARK: - UICollectionViewDelegateFlowLayout

extension AllHouseTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lineSpacing = UI.lineSpacing * (UI.linesOnScreen)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        let itemSpacing = UI.itemSpacing * (UI.itemsInLine - 1)
        let verticalInset = UI.edgeInsets.top + UI.edgeInsets.bottom
        
        let horizontalSpacing = lineSpacing + horizontalInset
        let cellWidth: CGFloat = ((collectionView.frame.width - horizontalSpacing) / UI.linesOnScreen)
        
        let verticalSpacing = itemSpacing + verticalInset
        let cellHeight = (collectionView.frame.height - verticalSpacing) / UI.itemsInLine
        
        let roundedWidth = cellWidth.rounded(.down)
        let roundedHeight = cellHeight.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}
