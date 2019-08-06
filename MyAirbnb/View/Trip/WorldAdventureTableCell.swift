//
//  WorldAdventureTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 30/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

protocol WorldAdventureTableCellDelegate: class {
    func pushAdventureVC(globalAdventureData: BestTrip)
}

class WorldAdventureTableCell: UITableViewCell {
    static let identifier = "WorldAdventureTableCell"
    
    private enum UI {
        static let itemsInLine: CGFloat = 2
        static let linesOnScreen: CGFloat = 2
        static let lineSpacing: CGFloat = 15.0
        static let itemSpacing: CGFloat = 13.0
        static let edgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 20)
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 23)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "전 세계의 에어비앤비 어드벤처"
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 15)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.setLineSpacing(lineSpacing: 3.0)
        label.numberOfLines = 0
        label.text = """
        숙소, 식사, 액티비티가 모두 준비되어 있어 계획을 전혀 세우지 않고도 완벽한 여행을 즐길 수 있습니다.
        """
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(WorldAdventureCollectionCell.self, forCellWithReuseIdentifier: WorldAdventureCollectionCell.identifier)
        
        return collectionView
    }()
    
    let seeAllbtn: UIButton = {
        let button = UIButton()
        button.setTitle("어드벤처 모두 보기", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.layer.borderColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        button.layer.borderWidth = 0.6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: WorldAdventureTableCellDelegate?
    var globalAdventureDataArray = [BestTrip]()
    
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
        
        contentView.addSubview(title)
        contentView.addSubview(descLabel)
        contentView.addSubview(seeAllbtn)
        
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
        title.snp.makeConstraints { (make) in
            make.top.equalTo(35)
            make.leading.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        seeAllbtn.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
            make.bottom.equalTo(-20)
        }
        
        let cellWidth = (UIScreen.main.bounds.width - 40 - 13) / 2
        let cellHeight = cellWidth * 1.9
        
        let collectionHeight = cellHeight + 15 + 5
//            ((cellHeight + 15) * CGFloat(globalAdventureDataArray.count / 2)) + 10
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(collectionHeight)
        }
    }
}


// MARK: - UICollectionViewDataSource

extension WorldAdventureTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return globalAdventureDataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let adventureCell = collectionView.dequeueReusableCell(withReuseIdentifier: WorldAdventureCollectionCell.identifier, for: indexPath) as! WorldAdventureCollectionCell

        adventureCell.setData(worldAdventureData: globalAdventureDataArray[indexPath.row])
        
        return adventureCell
    }
}

// MARK: - UICollectionViewDelegate

extension WorldAdventureTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushAdventureVC(globalAdventureData: globalAdventureDataArray[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WorldAdventureTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpacing = UI.itemSpacing * (UI.itemsInLine - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        let horizontalSpacing = itemSpacing + horizontalInset
        
        let cellWidth: CGFloat = ((collectionView.frame.width - horizontalSpacing) / UI.itemsInLine)
        let cellHeight = cellWidth * 1.9
        
        let roundedWidth = cellWidth.rounded(.down)
        let roundedHeight = cellHeight.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}
