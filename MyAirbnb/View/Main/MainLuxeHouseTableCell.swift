//
//  MainLuxeHouseTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class MainLuxeHouseTableCell: UITableViewCell {
    static let identifier = "MainLuxeHouseTableCell"
    
    let titleLabel = UILabel()
    let detailTitleLabel = UILabel()
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    let seeMoreBtn = UIButton()
    
    
    let collectionViewCellWidth: CGFloat = UIScreen.main.bounds.width * 0.4

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

        // Configure the view for the selected state
    }
    
    private func setAutoLayout() {
        let topBottomMargin: CGFloat = 30
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
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewCellWidth * 1.25).isActive = true
        
        self.addSubview(seeMoreBtn)
        seeMoreBtn.translatesAutoresizingMaskIntoConstraints = false
        seeMoreBtn.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0).isActive = true
        seeMoreBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        seeMoreBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin).isActive = true
        seeMoreBtn.heightAnchor.constraint(equalTo: seeMoreBtn.widthAnchor, multiplier: 0.13).isActive = true
        seeMoreBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
    }
    
    private func configureViewsOptions() {
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
        
        detailTitleLabel.configureMainTableViewCellsTitleDetails()
        detailTitleLabel.text = "모든 것이 5성급인 특별한 숙소"
        
        seeMoreBtn.setTitle("에어비앤비 Luxe숙소 모두 보기", for: .normal)
        seeMoreBtn.setTitleColor(UIColor(red:0.20, green:0.00, blue:0.47, alpha:1.0), for: .normal)
        seeMoreBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        seeMoreBtn.layer.cornerRadius = 2
        seeMoreBtn.clipsToBounds = true
        seeMoreBtn.layer.borderWidth = 1
        seeMoreBtn.layer.borderColor = #colorLiteral(red: 0.4705680609, green: 0.4677750468, blue: 0.4727178216, alpha: 0.445499786)
    }

}

extension MainLuxeHouseTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainLuxeHouseCollectCell.identifier, for: indexPath) as! MainLuxeHouseCollectCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellWidth * 1.25)
    }
    
}
