//
//  LuxeDetailBasicServiceTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/07.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class LuxeDetailBasicServiceTableCell: UITableViewCell {
    static let identifier = "LuxeDetailBasicServiceTableCell"
    
    // MARK: - UI Properties
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    let bottomLabelIconView = UIImageView()
    let bottomLabel = UILabel()
    let bottomMessageBtn = UIButton()
    
    // MARK: - Properties
    private enum Metric {
        // Horizontal일때: 옆으로 갈수록 line증가  /  Vertical일때: 옆으로 갈수록 Item증가
        static let lineSpacing: CGFloat = 25
        static let itemSpacing: CGFloat = 12
        static let nextOffSet: CGFloat = 0
        
        static var numberOfLine: CGFloat = 2
        static let numberOfItem: CGFloat = 2
        
        static let inset: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        static var horizontalPadding: CGFloat {
            return Metric.inset.left + Metric.inset.right
        }
        
        static var verticalPadding: CGFloat {
            return Metric.inset.top + Metric.inset.bottom
        }
    }
    
    var luxeData: HouseDetailData?
    var facilitiesArray = [[String]]()
    
    var data = [String]() {
        didSet {
            Metric.numberOfLine = CGFloat(data.count / 2) + ( (data.count % 2 == 1) ? 1 : 0 )
            print("Metric numberOfLine changed: ", Metric.numberOfLine)
        }
    }
    var seeBottomButton = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        print("--------------------------[didMoveTo Superview]--------------------------")
        print("Number Line: ", Metric.numberOfLine)
        
        setAutoLayout()
        collectionView.reloadData()
    }
    
    private func setAutoLayout() {
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(50)
            make.leading.equalTo(sideMargin)
        }
        
        self.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalTo(sideMargin)
            make.trailing.equalTo(-sideMargin)
        }
        
        let cellWidth = (UIScreen.main.bounds.width - 40 - Metric.itemSpacing) / Metric.numberOfItem
        let cellHeight = cellWidth * 0.9
        let collectionViewHeight: CGFloat = Metric.numberOfLine * cellHeight + Metric.lineSpacing * (Metric.numberOfLine - 1) + 40
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalTo(sideMargin)
            make.trailing.equalTo(-sideMargin)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            make.height.equalTo(collectionViewHeight)
        }
        
        switch seeBottomButton {
        case true:
            self.addSubview(bottomLabelIconView)
            bottomLabelIconView.snp.makeConstraints { (make) in
                make.leading.equalTo(sideMargin)
                make.top.equalTo(collectionView.snp.bottom).offset(0)
                make.height.equalTo(15)
                make.width.height.equalTo(25)
            }
            
            self.addSubview(bottomLabel)
            bottomLabel.snp.makeConstraints { (make) in
                make.leading.equalTo(bottomLabelIconView.snp.trailing).offset(3)
                make.trailing.equalTo(-sideMargin)
                make.top.equalTo(bottomLabelIconView.snp.top).offset(-2)
            }
            
            self.addSubview(bottomMessageBtn)
            bottomMessageBtn.snp.makeConstraints { (make) in
                make.leading.equalTo(sideMargin)
                make.trailing.equalTo(-sideMargin)
                make.top.equalTo(bottomLabel.snp.bottom).offset(10)
                make.height.equalTo(bottomMessageBtn.snp.width).multipliedBy(0.13)
                make.bottom.equalToSuperview().offset(-50)
            }
            
        case false:  
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
//            subtitleLabel.text = ""
        }
    }
    
    private func configureViewsOptions() {
        self.selectionStyle = .none
        
        titleLabel.text = "Title"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 22)
        
//        subtitleLabel.text = "숙소 예약 후에도 필요하신 모든 추가 서비스의 예약을 여행 디자이너가 도와드립니다."
        subtitleLabel.textColor = .black
        subtitleLabel.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 15)
        subtitleLabel.setLineSpacing(lineSpacing: 8, lineHeightMultiple: 1)
        subtitleLabel.numberOfLines = 0
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LuxeDetailServicesCollectCell.self, forCellWithReuseIdentifier: LuxeDetailServicesCollectCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Metric.lineSpacing
        layout.minimumInteritemSpacing = Metric.itemSpacing
        
        bottomLabelIconView.image = UIImage(named: "MessageIcon")
        bottomLabelIconView.contentMode = .scaleAspectFit
        
        bottomLabel.text = "여행과 관련된 모든 것을 여행 디자이너에게 맡겨보세요."
        bottomLabel.textColor = .black
//        bottomLabel.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 16)
        bottomLabel.font = .systemFont(ofSize: 15, weight: .regular)
        bottomLabel.setLineSpacing(lineSpacing: 5, lineHeightMultiple: 1)
        bottomLabel.numberOfLines = 0
        
        bottomMessageBtn.setTitle("메세지 보내기", for: .normal)
        bottomMessageBtn.setTitleColor(StandardUIValue.shared.colorPurple, for: .normal)
        bottomMessageBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        bottomMessageBtn.layer.borderColor = StandardUIValue.shared.colorPurple.cgColor
        bottomMessageBtn.layer.borderWidth = 1
        bottomMessageBtn.layer.cornerRadius = 5
        bottomMessageBtn.clipsToBounds = true
        
    }
}


extension LuxeDetailBasicServiceTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LuxeDetailServicesCollectCell.identifier, for: indexPath) as! LuxeDetailServicesCollectCell
//        cell.titleLabel.text = data[indexPath.row]
        cell.setData(facility: facilitiesArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lineSpacing = Metric.lineSpacing * (Metric.numberOfLine - 1)
        let horizontalPadding = Metric.inset.left + Metric.inset.right + Metric.nextOffSet
        
        let itemSpacing = Metric.itemSpacing * (Metric.numberOfItem - 1)
        let verticalPadding = Metric.inset.top + Metric.inset.bottom
        
        let width = (collectionView.frame.width - itemSpacing - horizontalPadding) / Metric.numberOfItem
        let height = width * 0.9
//        let height = (collectionView.frame.height - lineSpacing - verticalPadding) / Metric.numberOfLine
        
        return CGSize(width: width.rounded(.down), height: height.rounded(.down))
    }
    
}
