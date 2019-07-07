//
//  SpecialTripTableViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class SpecialTripTableViewCell: UITableViewCell {
    
    static let identifier = "specialTripTableViewCell"
    
    private enum UI {
        static let itemsInLine: CGFloat = 1
        static let linesOnScreen: CGFloat = 1
        static let lineSpacing: CGFloat = 13.0
        static let itemSpacing: CGFloat = 0.0
        static let edgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 20, right: 20)
        
        static let nextOffset: CGFloat = 40
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "에어비앤비에서만 볼 수 있는 특별한 트립"
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
    
    let images = ["airbnb_adventure", "eat_trip", "cooking_class", "surfing", "special_concert", "착한 트립"]
    let titles = ["에어비앤비 어드벤처", "식도락 여행", "쿠킹 클래스", "서핑", "콘서트", "착한 트립"]
    let descriptions = ["호스트의 안내를 받아 특별한 장소로 떠나는 여행. 오셔서 즐기기만 하시면 됩니다.", "요리 전문가가 이끄는 투어로 전 세계 다향한 도시의 매력에 푹 빠져보세요.", "현지 전문가의 지도를 받아 내 손으로 직접 현지 음식을 만들고 맛보세요.", "세계서핑리그(WSL)가 선정하고 프로 서핑 선수가 진행하는 트립에 참여해 서핑을 즐겨보세요.", "독특한 공간에서 열리는 소규모 공연으로 리듬에 빠져들며 라이브 음악의 신세계를 경험하세요.", "좋은 일도 하고 새로운 경험도 하는 일석이조의 기회! 예약금 전액이 비영리 단체로 기부됩니다."]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configure() {
        contentView.addSubview(titleLabel)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SpecialTripCollectionViewCell.self, forCellWithReuseIdentifier: SpecialTripCollectionViewCell.identifier)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = UI.lineSpacing
        layout.minimumInteritemSpacing = UI.itemSpacing
        
        collectionView.contentInset = UI.edgeInsets
        contentView.addSubview(collectionView)
    }
    
    private func setAutolayout() {
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}


// MARK: - UICollectionViewDataSource

extension SpecialTripTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialTripCollectionViewCell.identifier, for: indexPath) as! SpecialTripCollectionViewCell
        
        cell.imageView.image = UIImage(named: images[indexPath.row])
        cell.titleLabel.text = titles[indexPath.row]
        cell.descLabel.text = descriptions[indexPath.row]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SpecialTripTableViewCell: UICollectionViewDelegateFlowLayout {
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
