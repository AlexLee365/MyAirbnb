//
//  SeoulRecommendTableViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 09/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class SeoulRecommendTableViewCell: UITableViewCell {
    static let identifier = "seoulRecommendTableViewCell"
    
    var images = ["bathbomb", "designownbathbomb", "shareyourconcept", "natural", "vegantherapy", "addcolors", "variousdesign", "perfectsouvenier"]
    var categories = ["공예 클래스", nil, nil, nil, nil, nil, nil, nil]
    var titles = ["나만의 색과 향을 담은 배쓰밤을 만들어보세요!", "Design your own bath bomb", "Share your concepts", "Vegan & Natural Ingredients", "Vegan Therapy", "Add colors as you want", "Various design", "Perfect souvenirs from Korea:)"]

    let infoDict: [String: String] = ["locationIcon": "Seoul", "timeIcon": "총 2시간", "serviceIcon": "음료, 입장권 1매, 장비", "langIcon": "영어, 한국어로 진행"]
    let keysArray = ["locationIcon", "timeIcon", "serviceIcon", "langIcon"]
    var infoViewArray = [InfoView]()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let tempHeight = UIScreen.main.bounds.height * 0.8
    
    var offSet: CGFloat = 0
    var scrollingTimer = Timer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
        
        self.offSet = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(scrollView)
        
        createScrollViews()
        createInfoViews()
        
        scrollingTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(scrollAutomatically(_:)), userInfo: nil, repeats: true)
    }
    
    private func setAutolayout() {
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: tempHeight).isActive = true
    }

    private func createScrollViews() {
        let frame = UIScreen.main.bounds
        
        for i in 0..<images.count {
            let tempPoint = CGPoint(x: (frame.width * CGFloat(i)), y: 0)
            let tempSize = CGSize(width: frame.width, height: tempHeight)
            
            let tempFrame = CGRect(origin: tempPoint, size: tempSize)
            
            let uiView = TopScrollView(frame: tempFrame)
            uiView.topImageView.image = UIImage(named: images[i])
            
            if categories[i] != nil {
                uiView.categoryLabel.text = categories[i]
                uiView.titleLabel.text = titles[i]
            } else {
                uiView.titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                uiView.titleLabel.text = titles[i]
            }
            scrollView.addSubview(uiView)
        }
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(images.count), height: tempHeight-5)
    }
    
    private func createInfoViews() {
        for i in keysArray {
            let value = infoDict[i]
            
            guard value != nil else { continue }
            
            let tempView = InfoView()
            tempView.icon.image = UIImage(named: i)
            tempView.label.text = value
            infoViewArray.append(tempView)
            contentView.addSubview(tempView)
            
            tempView.translatesAutoresizingMaskIntoConstraints = false
            tempView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            tempView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
            tempView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        }
        
        for (index, value) in infoViewArray.enumerated() {
            switch index {
            case 0:
                value.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5).isActive = true
            case (infoViewArray.count - 1):
                value.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
                fallthrough
            default:
                value.topAnchor.constraint(equalTo: infoViewArray[index - 1].bottomAnchor, constant: 20).isActive = true
            }
        }
    }
    
    @objc private func scrollAutomatically(_ sender: Timer) {
        let totalPossibleOffset = CGFloat(images.count - 1) * UIScreen.main.bounds.size.width
        if offSet == totalPossibleOffset {
            offSet = 0 // come back to the first image after the last image
        } else {
            offSet += UIScreen.main.bounds.size.width
        }
        
        DispatchQueue.main.async() {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIView.AnimationOptions.curveLinear,
                           animations: {
                            self.scrollView.contentOffset.x = CGFloat(self.offSet) },
                           completion: nil)
        }
    }
}
