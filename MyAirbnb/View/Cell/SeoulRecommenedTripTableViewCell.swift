//
//  SeoulRecommenedTripTableViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 07/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class SeoulRecommenedTripTableViewCell: UITableViewCell {
    
    static let identifier = "seoulRecommenedTripTableViewCell"
    
    private enum UI {
        static let itemsInLine: CGFloat = 1
        static let linesOnScreen: CGFloat = 2
        static let lineSpacing: CGFloat = 13.0
        static let itemSpacing: CGFloat = 0.0
        static let edgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 5, right: 20)
        
        static let nextOffset: CGFloat = 8
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "서울의 추천 트립"
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("서울의 트립 모두 보기", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        button.titleLabel?.textAlignment = .center
        button.layer.borderColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        button.layer.borderWidth = 0.8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        contentView.addSubview(button)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TripInfoCollectionViewCell.self, forCellWithReuseIdentifier: TripInfoCollectionViewCell.identifier)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = UI.lineSpacing
        layout.minimumInteritemSpacing = UI.itemSpacing
        
        collectionView.contentInset = UI.edgeInsets
        contentView.addSubview(collectionView)
    }
    
    private func setAutolayout() {
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 15).isActive = true
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20).isActive = true
    }
}

// MARK: - UICollectionViewDataSource

extension SeoulRecommenedTripTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TripInfoCollectionViewCell.identifier, for: indexPath) as! TripInfoCollectionViewCell
        
        cell.backgroundColor = .yellow
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SeoulRecommenedTripTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lineSpacing = UI.lineSpacing * (UI.linesOnScreen - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        
        let horizontalSpacing = lineSpacing + horizontalInset + UI.nextOffset
        let cellWidth: CGFloat = ((collectionView.frame.width - horizontalSpacing) / UI.linesOnScreen)
        let cellHeight = collectionView.frame.height * 0.9
        
        let roundedWidth = cellWidth.rounded(.down)
        let roundedHeight = cellHeight.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}
