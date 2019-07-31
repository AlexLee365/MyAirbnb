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
    func pushAdventureVC()
}

class WorldAdventureTableCell: UITableViewCell {
    static let identifier = "WorldAdventureTableCell"
    
    private enum UI {
        static let itemsInLine: CGFloat = 2
        static let linesOnScreen: CGFloat = 2
        static let lineSpacing: CGFloat = 15.0
        static let itemSpacing: CGFloat = 13.0
        static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
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
            make.top.equalTo(30)
            make.leading.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        seeAllbtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(seeAllbtn.snp.top).offset(-10)
        }
    }
}


// MARK: - UICollectionViewDataSource

extension WorldAdventureTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let adventureCell = collectionView.dequeueReusableCell(withReuseIdentifier: WorldAdventureCollectionCell.identifier, for: indexPath) as! WorldAdventureCollectionCell

        adventureCell.imageView.image = UIImage(named: worldAdventureDatas[indexPath.row].image)
        adventureCell.categoryLabel.text = worldAdventureDatas[indexPath.row].category
        adventureCell.titleLabel.text = worldAdventureDatas[indexPath.row].title
        
        if worldAdventureDatas[indexPath.row].rate != 0 {
            adventureCell.starImage.image = UIImage(named: "star")
            adventureCell.rateLabel.text = String(worldAdventureDatas[indexPath.row].rate!)
            adventureCell.noOfReviewLabel.text = "(\(worldAdventureDatas[indexPath.row].noOfReview!))"
        }
        
        return adventureCell
    }
}

// MARK: - UICollectionViewDelegate

extension WorldAdventureTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushAdventureVC()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WorldAdventureTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lineSpacing = UI.lineSpacing * (UI.linesOnScreen - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        let itemSpacing = UI.itemSpacing * (UI.itemsInLine - 1)
        let verticalInset = UI.edgeInsets.top + UI.edgeInsets.bottom
        
        let horizontalSpacing = itemSpacing + horizontalInset
        let cellWidth: CGFloat = ((collectionView.frame.width - horizontalSpacing) / UI.itemsInLine)
        
        let verticalSpacing = lineSpacing + verticalInset
        let cellHeight = (collectionView.frame.height - verticalSpacing) / UI.linesOnScreen
        
        let roundedWidth = cellWidth.rounded(.down)
        let roundedHeight = cellHeight.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}

// MARK: - Struct

struct WorldAdventureData {
    var image: String
    var category: String
    var title: String
    var rate: Double?
    var noOfReview: Int?
}

let worldAdventureDatas: [WorldAdventureData] = [
    
    WorldAdventureData(image: "worldAdventure1", category: "6일 여행 코스 · 푸에르토아요라", title: "갈라파고스 슬로푸드 사파리", rate: 0, noOfReview: 0),
    WorldAdventureData(image: "worldAdventure2", category: "4일 여행 코스 · 뉘셰핑", title: "스웨덴의 섬에서 즐기는 카약과 맛있는 요리", rate: 0, noOfReview: 0),
    WorldAdventureData(image: "worldAdventure3", category: "6일 여행 코스 · PUERTO NATALES", title: "6 Days Accessible Experience Patagonia", rate: 0, noOfReview: 0),
    WorldAdventureData(image: "worldAdventure4", category: "1박 2일 여행 · 케이프타운", title: "The Vino Valleys Experience", rate: 4.96, noOfReview: 276)
]

