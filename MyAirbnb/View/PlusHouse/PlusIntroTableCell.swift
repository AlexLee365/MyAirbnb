//
//  PlusIntroTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 25/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class PlusIntroTableCell: UITableViewCell {
    static let identifier = "PlusIntroTableCell"
    
    private enum UI {
        static let itemsInLine: CGFloat = 1
        static let linesOnScreen: CGFloat = 4
        static let lineSpacing: CGFloat = 0.0
        static let itemSpacing: CGFloat = 0.0
        static let edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        static let nextOffset: CGFloat = 100
    }
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "plusLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let houseTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "부다페스트(BUDAPEST)의 아파트 전체"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Apartment in a Historic Building next to the Great Synagogue"
        label.font = UIFont.systemFont(ofSize: 30)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(PlusIntroCollectionCell.self, forCellWithReuseIdentifier: PlusIntroCollectionCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "Wake up in this bright apartment located right in the heart of historical Budapest. The rooms are decorated with unique accents, including submarine lighting, a bright blue barn door leading into the bedroom, and a mantle made from reclaimed wood."
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 18)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 3.0)
        return label
    }()
    
    let hostImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "hana")
        imageView.layer.cornerRadius = 32
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let superHostIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "superhostIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let hostNameLabel: UILabel = {
        let label = UILabel()
        label.text = "호스트: László님"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let infoLabelData = ["인원 3명", "침실 1개", "침대 2개", "욕실 1개"]
    
    
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
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(houseTypeLabel)
        contentView.addSubview(titleLabel)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = UI.lineSpacing
        layout.minimumInteritemSpacing = UI.itemSpacing
        
        collectionView.contentInset = UI.edgeInsets
        contentView.addSubview(collectionView)
        
        contentView.addSubview(descLabel)
        contentView.addSubview(hostImageView)
        contentView.addSubview(superHostIcon)
        contentView.addSubview(hostNameLabel)
    }
    
    private func setAutolayout() {
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.leading.equalTo(20)
            make.width.equalTo(100)
            make.height.equalTo(70)
        }
        
        houseTypeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(5)
            make.leading.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(houseTypeLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-35)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(27)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
            make.bottom.equalTo(descLabel.snp.top).offset(-20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.trailing.equalTo(-40)
        }
        
        hostImageView.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(25)
            make.leading.equalTo(20)
            make.width.height.equalTo(64)
            make.bottom.equalTo(-40)
        }
        
        superHostIcon.snp.makeConstraints { (make) in
            make.bottom.equalTo(hostImageView.snp.bottom)
            make.trailing.equalTo(hostImageView.snp.trailing).offset(4)
            make.width.height.equalTo(25)
        }
        
        hostNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(hostImageView)
            make.leading.equalTo(hostImageView.snp.trailing).offset(10)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension PlusIntroTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let plusInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PlusIntroCollectionCell.identifier, for: indexPath) as! PlusIntroCollectionCell
        plusInfoCell.infoLabel.text = infoLabelData[indexPath.row]
        return plusInfoCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PlusIntroTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lineSpacing = UI.lineSpacing * (UI.linesOnScreen - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right + UI.nextOffset
        
        let horizontalSpacing = lineSpacing + horizontalInset
        let cellWidth: CGFloat = ((collectionView.frame.width - horizontalSpacing) / UI.linesOnScreen)
        let cellHeight = collectionView.frame.height * 0.9
        
        let roundedWidth = cellWidth.rounded(.down)
        let roundedHeight = cellHeight.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}
