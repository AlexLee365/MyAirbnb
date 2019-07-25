//
//  BrowsePhotosTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 25/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class BrowsePhotosTableCell: UITableViewCell {
    static let identifier = "BrowsePhotosTableCell"
    
    private enum UI {
        static let itemsInLine: CGFloat = 3
        static let linesOnScreen: CGFloat = 4
        static let lineSpacing: CGFloat = 20.0
        static let itemSpacing: CGFloat = 13.0
        static let footerViewHeight: CGFloat = 50
        static let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이 아파트 둘러보기"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(
            BrowsePhotosCollectionCell.self, forCellWithReuseIdentifier: BrowsePhotosCollectionCell.identifier)
        collectionView.register(
            FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterView.identifier)
        return collectionView
    }()
    
    let seeAllBtn: UIButton = {
        let button = UIButton()
        button.setTitle("사진 23장 모두 보기", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 0.9406838613), for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    let browseImageArray = ["kitchen1", "kitchen2", "kitchen3"]
    let footerKeysArray = [("주방", ""), ("침실", "· 킹사이즈 침대 · 싱글 침대"), ("욕실", ""), ("출입문", "")]
    
    
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
        
        contentView.addSubview(titleLabel)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = UI.lineSpacing
        layout.minimumInteritemSpacing = UI.itemSpacing
        layout.footerReferenceSize = CGSize(width: 50, height: 50)
        
        collectionView.contentInset = UI.edgeInsets
        contentView.addSubview(collectionView)
        
        contentView.addSubview(seeAllBtn)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.leading.equalTo(20)
        }
        
        let collectionViewCellWidth: CGFloat =
            ( UIScreen.main.bounds.width - 40 - UI.itemSpacing * (UI.itemsInLine - 1) ) / UI.itemsInLine
        
        let collectionViewHeight: CGFloat =
            collectionViewCellWidth * 4 + UI.footerViewHeight * 4
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(collectionViewHeight)
        }
        
        seeAllBtn.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.equalTo(20)
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension BrowsePhotosTableCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let browseCell = collectionView.dequeueReusableCell(withReuseIdentifier: BrowsePhotosCollectionCell.identifier, for: indexPath) as! BrowsePhotosCollectionCell
        browseCell.browseImageView.image = UIImage(named: browseImageArray[indexPath.row])
        
        return browseCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterView.identifier, for: indexPath) as! FooterView
            
            footer.configure(title: footerKeysArray[indexPath.section].0, extra: footerKeysArray[indexPath.section].1)
            
            return footer
        }
        
        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BrowsePhotosTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpacing = UI.itemSpacing * (UI.itemsInLine - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        
        let horizontalSpacing = itemSpacing + horizontalInset
        let width = (collectionView.frame.width - horizontalSpacing) / UI.itemsInLine
        
        let roundedWidth = width.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedWidth)
    }
}
