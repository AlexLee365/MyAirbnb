//
//  LuxeDetailBedRoomsTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/07.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class LuxeDetailBedRoomsTableCell: UITableViewCell {
    static let identifier = "LuxeDetailBedRoomsTableCell"
    
    // MARK: - UI Properties
    let titleLabel = UILabel()
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    var luxeData: HouseDetailData?
    var imageStringArray = [String]()
    
    // MARK: - Properties
    private enum Metric {
        // Horizontal일때: 옆으로 갈수록 line증가  /  Vertical일때: 옆으로 갈수록 Item증가
        static let lineSpacing: CGFloat = 10
        static let itemSpacing: CGFloat = 0
        static let nextOffSet: CGFloat = 10
        
        static let numberOfLine: CGFloat = 2
        static let numberOfItem: CGFloat = 1
        
        static let inset: UIEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 20)
        
        static var horizontalPadding: CGFloat {
            return Metric.inset.left + Metric.inset.right
        }
        
        static var verticalPadding: CGFloat {
            return Metric.inset.top + Metric.inset.bottom
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAutoLayout()
        configureViewsOptions()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        imageStringArray = [luxeData?.bedImage0, luxeData?.bedImage1, luxeData?.bedImage2, luxeData?.bedImage3, luxeData?.bedImage4, luxeData?.bedImage5].compactMap{$0}
        print("🔵🔵🔵 Bedrooms TableCell count: ", imageStringArray)
        print(luxeData)
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(StandardUIValue.shared.mainViewSideMargin)
            make.top.equalTo(50)
        }
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.height.equalTo(collectionView.snp.width).multipliedBy(0.45)
            make.bottom.equalTo(-40)
        }
    }
    
    private func configureViewsOptions() {
        titleLabel.text = "침대/침구 유형"
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.textColor = .black
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LuxeDetailBedroomsCollectCell.self, forCellWithReuseIdentifier: LuxeDetailBedroomsCollectCell.identifier)
        collectionView.contentInset = Metric.inset
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        layout.minimumLineSpacing = Metric.lineSpacing
        layout.scrollDirection = .horizontal
    }

}

extension LuxeDetailBedRoomsTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageStringArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LuxeDetailBedroomsCollectCell.identifier, for: indexPath) as! LuxeDetailBedroomsCollectCell
        cell.setData(titleText: "침대 \(indexPath.row+1)", imageUrlString: imageStringArray[indexPath.row])
        
        return cell
        
//        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lineSpacing = Metric.lineSpacing * (Metric.numberOfLine - 1)
        let horizontalPadding = Metric.inset.left + Metric.inset.right + Metric.nextOffSet
        
        let itemSpacing = Metric.itemSpacing * (Metric.numberOfItem - 1)
        let verticalPadding = Metric.inset.top + Metric.inset.bottom
        
        let width = (collectionView.frame.width - lineSpacing - horizontalPadding) / Metric.numberOfLine
        let height = (collectionView.frame.height - itemSpacing - verticalPadding) / Metric.numberOfItem
        
        return CGSize(width: width.rounded(.down), height: height.rounded(.down))
    }

    
}
