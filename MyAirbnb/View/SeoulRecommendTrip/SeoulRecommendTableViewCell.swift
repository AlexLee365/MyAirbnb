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
    
    let tempImageView = UIView()
    let dataDict: [String: String] = ["지역": "서울", "사용시간": "총 2시간", "서비스": "음료"]
    var createViews = [InfoView]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createView() {
        for (key, value) in dataDict {
            let tempView = InfoView()
            tempView.imageView.image = UIImage(named: key)
            tempView.label.text = value
            
            createViews.append(tempView)
        }
        
        for (index, value) in createViews.enumerated() {
            switch index {
            case 0:
                break
                value.topAnchor
            default:
                break
            }
        }
    }
}
