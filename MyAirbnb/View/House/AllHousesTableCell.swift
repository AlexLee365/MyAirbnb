//
//  AllHousesTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 15/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class AllHousesTableCell: UITableViewCell {
    static let identifier = "AllHousesTableCell"
    
    var images = ["roomSample3", "houseSample", "luxeSample", "MainFullImage", "categoryHouseImage"]
    
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
    
    let likeBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let houseTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let houseNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16.5, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingImageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.09, green:0.51, blue:0.54, alpha:1.0)
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingAndHostInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = #colorLiteral(red: 0.3221844435, green: 0.3202747703, blue: 0.3236560524, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func configure() {
        scrollView.delegate = self
        contentView.addSubview(scrollView)
        
        createScrollViews()
        
        contentView.addSubview(likeBtn)
        
        contentView.addSubview(pageController)
        pageController.numberOfPages = images.count
        pageController.pageIndicatorTintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        pageController.currentPageIndicatorTintColor = .white
        
        contentView.addSubview(houseTypeLabel)
        contentView.addSubview(houseNameLabel)
        contentView.addSubview(ratingImageLabel)
        contentView.addSubview(ratingAndHostInfoLabel)
    }
    
    private func setAutolayout() {
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: tempHeight).isActive = true
        
        likeBtn.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        likeBtn.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15).isActive = true
        likeBtn.widthAnchor.constraint(equalToConstant: 25).isActive = true
        likeBtn.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        pageController.translatesAutoresizingMaskIntoConstraints = false
        pageController.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8).isActive = true
        pageController.heightAnchor.constraint(equalToConstant: 20).isActive = true
        pageController.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        houseTypeLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10).isActive = true
        houseTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        houseNameLabel.topAnchor.constraint(equalTo: houseTypeLabel.bottomAnchor, constant: 8).isActive = true
        houseNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        houseNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        ratingImageLabel.topAnchor.constraint(equalTo: houseNameLabel.bottomAnchor, constant: 15).isActive = true
        ratingImageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        ratingImageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        ratingAndHostInfoLabel.topAnchor.constraint(equalTo: houseNameLabel.bottomAnchor, constant: 15).isActive = true
        ratingAndHostInfoLabel.leadingAnchor.constraint(equalTo: ratingImageLabel.trailingAnchor, constant: 5).isActive = true
        ratingAndHostInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    private func createScrollViews() {
        let frame = UIScreen.main.bounds
        
        for i in 0..<images.count {
            let tempPoint = CGPoint(x: ((frame.width - 40) * CGFloat(i)), y: 0)
            let tempSize = CGSize(width: (frame.width - 40), height: tempHeight)
            
            let tempFrame = CGRect(origin: tempPoint, size: tempSize)
            
            let uiView = AllHousesScrollImageView(frame: tempFrame)
            uiView.imageView.image = UIImage(named: images[i])
            
            scrollView.addSubview(uiView)
        }
        scrollView.contentSize = CGSize(width: ((frame.size.width - 40) * CGFloat(images.count)), height: tempHeight-5)
    }
}

extension AllHousesTableCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let frame = UIScreen.main.bounds
        let page = (scrollView.contentOffset.x / (frame.size.width - 40))
        pageController.currentPage = Int(page)
    }
}
