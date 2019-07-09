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
    
    let infoDict: [String: String] = ["locationIcon": "Seoul", "timeIcon": "총 2시간", "serviceIcon": "음료, 입장권 1매, 장비", "langIcon": "영어, 한국어로 진행"]
    let keysArray = ["locationIcon", "timeIcon", "serviceIcon", "langIcon"]
    var createInfoViews = [InfoView]()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var images = ["bathbomb", "designownbathbomb", "shareyourconcept", "natural", "vegantherapy", "addcolors", "variousdesign", "perfectsouvenier"]

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
        
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(scrollView)
        
        let frame = UIScreen.main.bounds
        
        for i in 0..<images.count {
            
            let tempPoint = CGPoint(x: (frame.width * CGFloat(i)), y: 0)
            let tempSize = CGSize(width: frame.width, height: 520)
            
            let tempFrame = CGRect(origin: tempPoint, size: tempSize)
            
            let uiView = TopScrollView(frame: tempFrame)
            uiView.topImageView.image = UIImage(named: images[i])
            scrollView.addSubview(uiView)
        }
        
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(images.count), height: 520)
    }
    
    private func setAutolayout() {
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 520).isActive = true
    }
    
    private func createView() {
        for i in keysArray {
            let value = infoDict[i]
            
            guard value != nil else { continue }
            
            let tempView = InfoView()
            tempView.icon.image = UIImage(named: i)
            tempView.label.text = value
            createInfoViews.append(tempView)
            contentView.addSubview(tempView)
            
            tempView.translatesAutoresizingMaskIntoConstraints = false
            tempView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            tempView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
            tempView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
        }
        
        for (index, value) in createInfoViews.enumerated() {
            switch index {
            case 0:
                value.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5).isActive = true
            case (createInfoViews.count - 1):
                value.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
                fallthrough
            default:
                value.topAnchor.constraint(equalTo: createInfoViews[index - 1].bottomAnchor, constant: 20).isActive = true
            }
        }
    }
}
