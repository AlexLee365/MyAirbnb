//
//  TripAllViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 28/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class TripAllViewController: UIViewController {

    private enum UI {
        static let itemsInLine: CGFloat = 2
        static let linesOnScreen: CGFloat = 1
        static let lineSpacing: CGFloat = 23.0
        static let itemSpacing: CGFloat = 13.0
        static let edgeInsets = UIEdgeInsets(top: 30, left: 20, bottom: 40, right: 20)
        
        static let nextOffset: CGFloat = 90
    }
    
    let searchBarView: SearchBarView = {
        let view = SearchBarView()
        view.searchImageBtn.setImage(UIImage(named: "back33"), for: .normal)
        return view
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(TripInfoCollectionViewCell.self, forCellWithReuseIdentifier: TripInfoCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setAutolayout()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        view.addSubview(searchBarView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = UI.lineSpacing
        layout.minimumInteritemSpacing = UI.itemSpacing
        
        collectionView.contentInset = UI.edgeInsets
        view.addSubview(collectionView)
    }
    
    private func setAutolayout() {
        let guide = view.safeAreaLayoutGuide
        
        searchBarView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(guide)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBarView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(guide)
            make.bottom.equalToSuperview()
        }
    }
}


// MARK: - UICollectionViewDataSource

extension TripAllViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seoulRecommendedTripDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TripInfoCollectionViewCell.identifier, for: indexPath) as! TripInfoCollectionViewCell
        
        cell.imageView.image = UIImage(named: seoulRecommendedTripDatas[indexPath.row].image)
        cell.categoryLabel.text = seoulRecommendedTripDatas[indexPath.row].category
        cell.titleLabel.text = seoulRecommendedTripDatas[indexPath.row].title
        cell.descLabel.text = seoulRecommendedTripDatas[indexPath.row].desc
        cell.languageLabel.text = seoulRecommendedTripDatas[indexPath.row].lang
        
        if seoulRecommendedTripDatas[indexPath.row].rate != nil {
            cell.starImage.image = UIImage(named: "star")
            cell.rateLabel.text = String(seoulRecommendedTripDatas[indexPath.row].rate!)
            cell.noOfReviewLabel.text = "(\(seoulRecommendedTripDatas[indexPath.row].noOfReview!))"
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TripAllViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lineSpacing = UI.lineSpacing
        let itemSpacing = UI.itemSpacing * (UI.itemsInLine - 1)
        
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        let verticalInset = UI.edgeInsets.top + UI.edgeInsets.bottom
        
        let horizontalSpacing = itemSpacing + horizontalInset
        let verticalSpacing = lineSpacing + verticalInset + UI.nextOffset
        
        let cellWidth: CGFloat = ((collectionView.frame.width - horizontalSpacing) / UI.itemsInLine)
        let cellHeight = collectionView.frame.height - verticalSpacing
        
        let roundedWidth = cellWidth.rounded(.down)
        let roundedHeight = cellHeight.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}

