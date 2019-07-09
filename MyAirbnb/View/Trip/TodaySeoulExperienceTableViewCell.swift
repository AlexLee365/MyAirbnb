//
//  TodaySeoulExperienceTableViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 08/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class TodaySeoulExperienceTableViewCell: UITableViewCell {
    static let identifier = "todaySeoulExperienceTableViewCell"
    
    private enum UI {
        static let itemsInLine: CGFloat = 2
        static let linesOnScreen: CGFloat = 2
        static let lineSpacing: CGFloat = 13.0
        static let itemSpacing: CGFloat = 30.0
        static let edgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘 서울에서 경험할 수 있는 트립"
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
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
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("모두보기(24개)", for: .normal)
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
        fatalError("init(coder: ) has not been implemented")
    }
    
    
    private func configure() {
        contentView.addSubview(titleLabel)
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 3
        contentView.addSubview(button)
        
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
    
    private func setAutolayout() {
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20).isActive = true
    }
}


// MARK: - UICollectionViewDataSource

extension TodaySeoulExperienceTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TripInfoCollectionViewCell.identifier, for: indexPath) as! TripInfoCollectionViewCell
        
        cell.imageView.image = UIImage(named: todaySeoulExperienceDatas[indexPath.row].image)
        cell.categoryLabel.text = todaySeoulExperienceDatas[indexPath.row].category
        cell.titleLabel.text = todaySeoulExperienceDatas[indexPath.row].title
        cell.descLabel.text = todaySeoulExperienceDatas[indexPath.row].desc
        cell.languageLabel.text = todaySeoulExperienceDatas[indexPath.row].lang
        
        if todaySeoulExperienceDatas[indexPath.row].rate != nil {
            cell.starImage.image = UIImage(named: "star")
            cell.rateLabel.text = String(todaySeoulExperienceDatas[indexPath.row].rate!)
            cell.noOfReviewLabel.text = "(\(todaySeoulExperienceDatas[indexPath.row].noOfReview!))"
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TodaySeoulExperienceTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lineSpacing = UI.lineSpacing * (UI.linesOnScreen - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        let itemSpacing = UI.itemSpacing * (UI.itemsInLine - 1)
        let verticalInset = UI.edgeInsets.top + UI.edgeInsets.bottom
        
        let horizontalSpacing = lineSpacing + horizontalInset
        let cellWidth: CGFloat = ((collectionView.frame.width - horizontalSpacing) / UI.linesOnScreen)

        let verticalSpacing = itemSpacing + verticalInset
        let cellHeight = (collectionView.frame.height - verticalSpacing) / UI.itemsInLine
        
        let roundedWidth = cellWidth.rounded(.down)
        let roundedHeight = cellHeight.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}
