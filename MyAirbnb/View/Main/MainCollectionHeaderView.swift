//
//  MainCollectionHeaderView.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 09/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class MainCollectionHeaderView: UICollectionReusableView {
    // 메인에 보여지는 collectionView(Horizontal 스크롤방향만 해당)
    static let identifier = "MainCollectionHeaderView"
    
    let spaceView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSpaceView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSpaceView() {
        self.addSubview(spaceView)
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        spaceView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        spaceView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        spaceView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        spaceView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        spaceView.backgroundColor = .clear
    }
}
