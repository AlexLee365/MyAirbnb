//
//  HouseLuxeTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 14/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseLuxeTableCell: UITableViewCell {
    static let identifier = "houseLuxeTableCell"
    
    let titleLabel = UILabel()
    let detailTitleLabel = UILabel()
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    let seeMoreBtn = UIButton()
    
    let notiCenter = NotificationCenter.default
    
    var collectionViewCellWidth: CGFloat = UIScreen.main.bounds.width * 0.6
    lazy var collectionViewCellHeight: CGFloat = collectionViewCellWidth * 1.2
    
    var luxeHouseDataArray = [HouseLuxeDataInList]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setAutoLayout() {
        let topBottomMargin: CGFloat = 50
        let sideMargin: CGFloat = 20
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topBottomMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin*2).isActive = true
        
        self.addSubview(detailTitleLabel)
        detailTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        detailTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        detailTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin*2).isActive = true
        
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: detailTitleLabel.bottomAnchor, constant: 25).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewCellHeight+1).isActive = true
        
        self.addSubview(seeMoreBtn)
        seeMoreBtn.translatesAutoresizingMaskIntoConstraints = false
        seeMoreBtn.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0).isActive = true
        seeMoreBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        seeMoreBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin).isActive = true
        seeMoreBtn.heightAnchor.constraint(equalTo: seeMoreBtn.widthAnchor, multiplier: 0.13).isActive = true
        seeMoreBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
    }
    
    private func configureViewsOptions() {
        self.selectionStyle = .none
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainLuxeHouseCollectCell.self, forCellWithReuseIdentifier: MainLuxeHouseCollectCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: StandardUIValue.shared.mainViewSideMargin, bottom: 0, right: 0)
        
        
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        
        titleLabel.configureMainTableViewCellsTitle()
        titleLabel.text = "에어비앤비 Luxe를 만나보세요."
        titleLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        titleLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        
        detailTitleLabel.configureMainTableViewCellsTitleDetails()
        detailTitleLabel.text = "모든 것이 5성급인 특별한 숙소"
        detailTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        detailTitleLabel.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        
        seeMoreBtn.setTitle("에어비앤비 Luxe숙소 모두 보기", for: .normal)
        seeMoreBtn.setTitleColor(UIColor(red:0.20, green:0.00, blue:0.47, alpha:1.0), for: .normal)
        seeMoreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        seeMoreBtn.layer.cornerRadius = 2
        seeMoreBtn.clipsToBounds = true
        seeMoreBtn.titleLabel?.textAlignment = .center
        seeMoreBtn.layer.borderColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        seeMoreBtn.layer.borderWidth = 0.5

    }
    
}

extension HouseLuxeTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return luxeHouseDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainLuxeHouseCollectCell.identifier, for: indexPath) as! MainLuxeHouseCollectCell
        
        cell.setData(luxeHouseData: luxeHouseDataArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionView Cell didSelect \(indexPath.item)")
        
//        notiCenter.post(name: .moveToHouseDetailView, object: nil,
//                        userInfo: ["roomID": data.id, "type": data.houseType, "houseName": data.houseName])
    }
}
