//
//  HouseDetailPicturesTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 17/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseDetailPicturesTableCell: UITableViewCell {
    static let identifier = "HouseDetailPicturesTableCell"
    
    // MARK: - UI Properties
    let scrollView = UIScrollView()
    let pageController = UIPageControl()
    
    
    // MARK: - Properties
//    var images = ["roomSample1", "roomSample2", "roomSample3", "roomSample4", "roomSample5"]
    var images = [UIImage]()
    var pictureViews = [AllHousesScrollImageView]()
    var tempHeight = (UIScreen.main.bounds.width - 40) * 0.62

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("--------------------------[HouseDetailPictures Table Cell]--------------------------")
        
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

    var setLayout = false
    override func layoutSubviews() {
        if setLayout == false {
            print("🔵🔵🔵 tableCell Frame: ", self.frame)
            tempHeight = self.frame.height
            
            
            createScrollViews()
            
            setLayout = true
        }
    }
    
    private func setAutoLayout() {
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        self.addSubview(pageController)
        pageController.translatesAutoresizingMaskIntoConstraints = false
        pageController.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8).isActive = true
        pageController.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        pageController.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func configureViewsOptions() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        
        pageController.pageIndicatorTintColor = .lightGray
        pageController.currentPageIndicatorTintColor = .white
    }
    
    private func createScrollViews() {
        let frame = UIScreen.main.bounds
        
        for i in 0..<images.count {
            let tempPoint = CGPoint(x: frame.width * CGFloat(i), y: 0)
            let tempSize = CGSize(width: frame.width, height: tempHeight)
            
            let tempFrame = CGRect(origin: tempPoint, size: tempSize)
            
            let pictureView = AllHousesScrollImageView(frame: tempFrame)
//            pictureView.imageView.image = UIImage(named: images[i])
            pictureView.imageView.image = images[i]
            
            
            scrollView.addSubview(pictureView)
            pictureViews.append(pictureView)
        }
        pageController.numberOfPages = images.count
        scrollView.contentSize = CGSize(width: (frame.size.width * CGFloat(images.count) ), height: tempHeight)
    }
}

extension HouseDetailPicturesTableCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let frame = UIScreen.main.bounds
        let page = (scrollView.contentOffset.x / frame.size.width)
        pageController.currentPage = Int(page)
    }
}
