//
//  MainCategoryTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 08/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

protocol MainCategoryTableCellDelegate: class {
    func pushView()
}

class MainCategoryTableCell: UITableViewCell {
    static let identifier = "mainCategoryTableCell"
    
    // MARK: - UI Properties
    let titleLabel = UILabel()
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    // MARK: - Properties
    let collectionViewCellWidth: CGFloat = UIScreen.main.bounds.width * 0.35
    
    weak var delegate: MainCategoryTableCellDelegate?
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: MainCategoryTableCell.identifier)
        
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var setLayout = false
    override func layoutSubviews() {
        if setLayout == false {
            setLayout = true
        }
    }
    
    private func setAutoLayout() {
        let topBottomMargin = StandardUIValue.shared.mainTableViewCellsTopBottomPadding
        let sideMargin = StandardUIValue.shared.mainViewSideMargin

        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topBottomMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin*2).isActive = true
        
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewCellWidth).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    private func configureViewsOptions() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCategoryCollectCell.self, forCellWithReuseIdentifier: MainCategoryCollectCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: StandardUIValue.shared.mainViewSideMargin, bottom: 0, right: StandardUIValue.shared.mainViewSideMargin)
        
        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        
        titleLabel.configureMainTableViewCellsTitle()
//        titleLabel.font = .systemFont(ofSize: 21, weight: .bold)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension MainCategoryTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoryCollectCell.identifier, for: indexPath) as! MainCategoryCollectCell
        
        cell.mainImageView.image = UIImage(named: "categoryImage")
        cell.titleLabel.text = "숙소"
        cell.detailLabel.text = "숙소"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            guard let collectCell = collectionView.cellForItem(at: indexPath) as? MainCategoryCollectCell else {
//                print("error")
//                return
//            }
            self.delegate?.pushView()
//        }
    }
}
