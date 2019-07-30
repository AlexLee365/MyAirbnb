//
//  SeoulRecommenedTripTableViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 07/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

protocol SeoulRecommenedTripTableViewCellDelegate: class {
    func pushVC()
    func pushVCForBtn()
}


class SeoulRecommenedTripTableViewCell: UITableViewCell {
    
    static let identifier = "seoulRecommenedTripTableViewCell"
    
    weak var delegate: SeoulRecommenedTripTableViewCellDelegate?
    
    private enum UI {
        static let itemsInLine: CGFloat = 1
        static let linesOnScreen: CGFloat = 2
        static let lineSpacing: CGFloat = 13.0
        static let itemSpacing: CGFloat = 0.0
        static let edgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        
        static let nextOffset: CGFloat = 5
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "서울의 추천 트립"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
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
        
        seeAllbtn.clipsToBounds = true
        seeAllbtn.layer.cornerRadius = 3
        seeAllbtn.addTarget(self, action: #selector(seeAllBtnDidTap(_:)), for: .touchUpInside)
        contentView.addSubview(seeAllbtn)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TripInfoCollectionViewCell.self, forCellWithReuseIdentifier: TripInfoCollectionViewCell.identifier)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = UI.lineSpacing
        layout.minimumInteritemSpacing = UI.itemSpacing
        
        collectionView.contentInset = UI.edgeInsets
        contentView.addSubview(collectionView)
    }
    
    @objc private func seeAllBtnDidTap(_ sender: UIButton) {
        delegate?.pushVCForBtn()
    }
    
    
    private func setAutolayout() {
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        seeAllbtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        seeAllbtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        seeAllbtn.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        seeAllbtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: seeAllbtn.topAnchor, constant: -15).isActive = true
    }
}

// MARK: - UICollectionViewDataSource

extension SeoulRecommenedTripTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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

// MARK: - UICollectionViewDelegate

extension SeoulRecommenedTripTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushVC()
        
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension SeoulRecommenedTripTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lineSpacing = UI.lineSpacing * (UI.linesOnScreen - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        
        let horizontalSpacing = lineSpacing + horizontalInset + UI.nextOffset
        let cellWidth: CGFloat = ((collectionView.frame.width - horizontalSpacing) / UI.linesOnScreen)
        let cellHeight = collectionView.frame.height * 0.95
        
        let roundedWidth = cellWidth.rounded(.down)
        let roundedHeight = cellHeight.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}
