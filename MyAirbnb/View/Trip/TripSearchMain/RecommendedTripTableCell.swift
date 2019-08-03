//
//  RecommendedTripTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class RecommendedTripTableCell: UITableViewCell {
    static let identifier = "RecommendedTripTableCell"
    
    private enum UI {
        static let itemsInLine: CGFloat = 1
        static let linesOnScreen: CGFloat = 2
        static let lineSpacing: CGFloat = 13.0
        static let itemSpacing: CGFloat = 0.0
        static let edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        static let nextOffset: CGFloat = 5
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "서울의 추천 트립"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 23)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(TripInfoCollectionViewCell.self, forCellWithReuseIdentifier: TripInfoCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let seeAllbtn: UIButton = {
        let button = UIButton()
        button.setTitle("서울의 트립 모두 보기", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.layer.borderColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        button.layer.borderWidth = 0.6
        button.clipsToBounds = true
        button.layer.cornerRadius = 3
        return button
    }()
    
    var recommendedTripArray = [BestTrip]()
    
    
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
        
        seeAllbtn.addTarget(self, action: #selector(seeAllBtnDidTap(_:)), for: .touchUpInside)
        contentView.addSubview(seeAllbtn)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = UI.lineSpacing
        layout.minimumInteritemSpacing = UI.itemSpacing
        
        collectionView.contentInset = UI.edgeInsets
        contentView.addSubview(collectionView)
    }
    
    @objc private func seeAllBtnDidTap(_ sender: UIButton) {
        
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.leading.equalTo(20)
        }
        
        let collectionHeight = UIScreen.main.bounds.height * 0.6
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(collectionHeight)
        }
        
        seeAllbtn.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(40)
            make.bottom.equalTo(-10)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension RecommendedTripTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedTripArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TripInfoCollectionViewCell.identifier, for: indexPath) as! TripInfoCollectionViewCell
        
        cell.setData(recommendedTripData: [recommendedTripArray])
        
//        cell.imageView.image = UIImage(named: seoulRecommendedTripDatas[indexPath.row].image)
//        cell.categoryLabel.text = seoulRecommendedTripDatas[indexPath.row].category
//        cell.titleLabel.text = seoulRecommendedTripDatas[indexPath.row].title
//        cell.descLabel.text = seoulRecommendedTripDatas[indexPath.row].desc
//        cell.languageLabel.text = seoulRecommendedTripDatas[indexPath.row].lang
//
//        if seoulRecommendedTripDatas[indexPath.row].rate != nil {
//            cell.starImage.image = UIImage(named: "star")
//            cell.rateLabel.text = String(seoulRecommendedTripDatas[indexPath.row].rate!)
//            cell.noOfReviewLabel.text = "(\(seoulRecommendedTripDatas[indexPath.row].noOfReview!))"
//        }

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension RecommendedTripTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension RecommendedTripTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lineSpacing = UI.lineSpacing * (UI.linesOnScreen - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        
        let horizontalSpacing = lineSpacing + horizontalInset + UI.nextOffset
        let cellWidth: CGFloat = ((collectionView.frame.width - horizontalSpacing) / UI.linesOnScreen)
        let cellHeight = collectionView.frame.height * 0.9
        
        let roundedWidth = cellWidth.rounded(.down)
        let roundedHeight = cellHeight.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}
