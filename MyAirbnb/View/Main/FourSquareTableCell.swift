//
//  FourSquareTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class FourSquareTableCell: UITableViewCell {
    static let identifier = "FourSquareTableCell"
    
    // MARK: - UI Properties
    let titleLabel = UILabel()
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    let seeMoreBtn = UIButton()
    
    // MARK: - Properties
    let notiCenter = NotificationCenter.default
    let collectionViewCellWidth: CGFloat = ( UIScreen.main.bounds.width - (StandardUIValue.shared.mainViewSideMargin * 2) - 15 ) / 2
    var normalHouseDataArray = [HouseDataInList]()
    
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
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: StandardUIValue.shared.mainTableViewCellsTopBottomPadding).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewCellWidth*1.25*2 + 20).isActive = true
        // cell넓이 * 1.25 = cell높이 => cell높이 * 2 + 20 (중간 space)
//        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
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
        collectionView.register(FourSquareCollectCell.self, forCellWithReuseIdentifier: FourSquareCollectCell.identifier)
//        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: StandardUIValue.shared.mainViewSideMargin, bottom: 0, right: 0)
        
        
        
//        layout.minimumInteritemSpacing = 15
//        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        
        titleLabel.configureMainTableViewCellsTitle()
        
        seeMoreBtn.setTitle("모두 보기(2000개 이상)", for: .normal)
        seeMoreBtn.setTitleColor(UIColor(red:0.09, green:0.51, blue:0.54, alpha:1.0), for: .normal)
        seeMoreBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        seeMoreBtn.layer.cornerRadius = 2
        seeMoreBtn.clipsToBounds = true
        seeMoreBtn.layer.borderWidth = 1
        seeMoreBtn.layer.borderColor = UIColor(red:0.09, green:0.51, blue:0.54, alpha:0.5).cgColor
    }
    

}

extension FourSquareTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FourSquareCollectCell.identifier, for: indexPath) as! FourSquareCollectCell
        
        let titleText = ["Villa San Gennariello B&B", "Villa Amonteera, Luxury with Fantastic Ocean Vision", "Amazing and Extremely Central Flat", "Unique Cave House"]
        cell.houseNameLabel.text = titleText[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellWidth * 1.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        notiCenter.post(name: .moveToHouseDetailView, object: nil)
    }
    
    
}
