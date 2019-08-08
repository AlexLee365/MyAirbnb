//
//  LikeListTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 08/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class LikeListTableCell: UITableViewCell {
    static let identifier = "LikeListTableCell"
    
    var imageSamples = ["roomSample3", "houseSample", "luxeSample", "MainFullImage", "categoryHouseImage"]
    var imageArray = [UIImage]()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let pageController = UIPageControl()
    
    let tempHeight = (UIScreen.main.bounds.width - 40) * 0.62
    
    let likeBtn = LikeButton(contentID: 0, contentType: .room)
    
    let houseTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 12)
        label.text = "아파트 전체 • 침대 1개"
        label.textColor = #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 1)
        return label
    }()
    
    let houseNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 16.5)
        label.text = "[NEW] Center of Seoul Gongdeok Joy's House"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 15)
        label.text = "₩61000 /박"
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        return label
    }()
    
    let ratingImageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.09, green:0.51, blue:0.54, alpha:1.0)
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.text = String(repeating: "★", count: 5)
        return label
    }()
    
    let ratingAndHostInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 11)
        label.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        label.text = "20 • 슈퍼호스트"
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Properties
    
    private func configure() {
        self.selectionStyle = .none
        
        scrollView.delegate = self
        contentView.addSubview(scrollView)
        
        createScrollViews()
        
        contentView.addSubview(likeBtn)
        
        contentView.addSubview(pageController)
        pageController.numberOfPages = imageSamples.count
        pageController.pageIndicatorTintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        pageController.currentPageIndicatorTintColor = .white
        
        contentView.addSubview(houseTypeLabel)
        contentView.addSubview(houseNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(ratingImageLabel)
        contentView.addSubview(ratingAndHostInfoLabel)
        
        likeBtn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    private func setAutolayout() {
        scrollView.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(tempHeight)
        }
       
        likeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.bottom).offset(5)
            make.trailing.equalTo(scrollView.snp.trailing).offset(-9)
            make.width.height.equalTo(35)
        }
        
        pageController.snp.makeConstraints { (make) in
            make.bottom.equalTo(scrollView.snp.bottom).offset(-8)
            make.height.equalTo(20)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
        
        houseTypeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.bottom).offset(10)
            make.leading.equalTo(20)
        }
        
        houseNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(houseTypeLabel.snp.bottom).offset(8)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(houseNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(20)
        }
        
        ratingImageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(15)
            make.leading.equalTo(20)
            make.bottom.equalTo(-20)
        }
        
        ratingAndHostInfoLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(ratingImageLabel.snp.centerY)
            make.leading.equalTo(ratingImageLabel.snp.trailing).offset(3)
        }
    }
    
    private func createScrollViews() {
        let frame = UIScreen.main.bounds
        
        for i in 0..<imageSamples.count {
            let tempPoint = CGPoint(x: ((frame.width - 40) * CGFloat(i)), y: 0)
            let tempSize = CGSize(width: (frame.width - 40), height: tempHeight)
            
            let tempFrame = CGRect(origin: tempPoint, size: tempSize)
            let uiView = AllHousesScrollImageView(frame: tempFrame)
            
            scrollView.addSubview(uiView)
//            imageViewArray.append(uiView.imageView)
        }
        scrollView.contentSize = CGSize(width: ((frame.size.width - 40) * CGFloat(imageSamples.count)), height: tempHeight-5)
//        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollViewDidTapGesture(_:))))
    }
    
//    @objc private func scrollViewDidTapGesture(_ sender: UITapGestureRecognizer) {
//        guard let houseVC = self.superview?.superview as? HouseView else { print("‼️ : "); return }
//        
//        notiCenter.post(name: .moveToHouseDetailView, object: nil,
//                        userInfo: ["roomID": houseData?.id,
//                                   "type": houseData?.roomType,
//                                   "houseName": houseData?.title,
//                                   SingletonCommonData.notiKeySearchBarUseCase: houseVC.useCase.0,
//                                   SingletonCommonData.notiKeySearchBarInController: houseVC.useCase.1])
//    }
    
//    func setData(houseData: HouseDataInList) {
//        self.houseData = houseData
//        houseTypeLabel.text = "\(houseData.roomType) ・ \(houseData.state)"
//        houseNameLabel.text = houseData.title
//        ratingImageLabel.text = houseData.drawStarsWithHouseRate()
//        ratingAndHostInfoLabel.text = "\(houseData.reservations) ・ \(houseData.superHost ?? "일반 호스트")"
//        imageStringArray = [houseData.image, houseData.image1, houseData.image2, houseData.image3, houseData.image4]
//        likeBtn.resetContentIDAndTypeAndHouseData(contentID: houseData.id, contentType: .room, houseData: houseData)
//
//        guard let url = URL(string: imageStringArray.first ?? "") else { print("‼️ setData url convert error "); return }
//        imageViewArray.first?.kf.setImage(with: url)
//        downLoadAllImages()
//    }
}


// MARK: - UIScrollViewDelegate

extension LikeListTableCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let frame = UIScreen.main.bounds
        let page = Int( (scrollView.contentOffset.x / (frame.size.width - 40)) )
        pageController.currentPage = page
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let frame = UIScreen.main.bounds
        let page = Int( (scrollView.contentOffset.x / (frame.size.width - 40)) )
        print(page)
    }
}

