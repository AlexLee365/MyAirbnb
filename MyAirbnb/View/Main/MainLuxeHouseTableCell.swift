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
    
    // MARK: - UI Properties
    let titleLabel = UILabel()
    let detailTitleLabel = UILabel()
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    let seeMoreBtn = UIButton()
    
    // MARK: - Properties
    var collectionViewCellWidth: CGFloat = UIScreen.main.bounds.width * 0.4
//    lazy var collectionViewCellHeight: CGFloat = collectionViewCellWidth * 1.25
    var collectionViewCellHeight: CGFloat = (UIScreen.main.bounds.width * 0.4) * 1.25
    
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

        // Configure the view for the selected state
    }
    
    private func setAutoLayout() {
        let topBottomMargin: CGFloat = 30
        let sideMargin: CGFloat = 20
        
        contentView.addSubview(titleLabel)
        let titleTextHeight:CGFloat = "가".size(withAttributes: [NSAttributedString.Key.font :
            UIFont.systemFont(ofSize: StandardUIValue.shared.sizeTitleBoldText, weight: .bold)]).height
        let titleLabelWidth: CGFloat = UIScreen.main.bounds.width - sideMargin*3
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topBottomMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideMargin*2).isActive = true
//        titleLabel.widthAnchor.constraint(equalToConstant: titleLabelWidth).isActive = true
//        titleLabel.heightAnchor.constraint(equalToConstant: titleTextHeight).isActive = true
        print("🔵🔵🔵 titleLabelHeight: ", titleTextHeight)
        
        contentView.addSubview(detailTitleLabel)
        let detailTitleTextHeight:CGFloat = "가".size(withAttributes: [NSAttributedString.Key.font :
            UIFont.systemFont(ofSize: StandardUIValue.shared.sizeSubTitleText, weight: .semibold)]).height
        let detailTitleLabelWidth: CGFloat = UIScreen.main.bounds.width - sideMargin*3
        detailTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        detailTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
//        detailTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideMargin*2).isActive = true
//        detailTitleLabel.widthAnchor.constraint(equalToConstant: detailTitleLabelWidth).isActive = true
//        detailTitleLabel.heightAnchor.constraint(equalToConstant: detailTitleTextHeight).isActive = true
        print("🔵🔵🔵 detailTitleLabelHeight: ", detailTitleTextHeight)
     
        
        
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: detailTitleLabel.bottomAnchor, constant: 25).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewCellHeight+1).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: seeMoreBtn.topAnchor, constant: 0).isActive = true
        
        contentView.addSubview(seeMoreBtn)
        let buttonWidth: CGFloat = UIScreen.main.bounds.width - sideMargin*2
        seeMoreBtn.translatesAutoresizingMaskIntoConstraints = false
        seeMoreBtn.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5).isActive = true
        seeMoreBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        seeMoreBtn.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        //        seeMoreBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideMargin).isActive = true
        seeMoreBtn.heightAnchor.constraint(equalTo: seeMoreBtn.widthAnchor, multiplier: 0.13).isActive = true
        seeMoreBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
       
    }
    
    private func configureViewsOptions() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainLuxeHouseCollectCell.self, forCellWithReuseIdentifier: MainLuxeHouseCollectCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: StandardUIValue.shared.mainViewSideMargin, bottom: 0, right: StandardUIValue.shared.mainViewSideMargin)
        
        
        
//        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        
        titleLabel.configureMainTableViewCellsTitle()
        titleLabel.text = "에어비앤비 Luxe를 만나보세요."
        titleLabel.sizeToFit()
        
        detailTitleLabel.configureMainTableViewCellsTitleDetails()
        detailTitleLabel.text = "모든 것이 5성급인 특별한 숙소"
        detailTitleLabel.sizeToFit()
        
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
    
}
