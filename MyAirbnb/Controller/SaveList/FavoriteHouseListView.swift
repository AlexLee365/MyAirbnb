//
//  FavoriteHouseListView.swift
//  MyAirbnb
//
//  Created by 김광준 on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import UIKit

class FavoriteHouseListView: UIView {
    
    let favoriteTableView = UITableView()
    var favoriteDatas = [FavoriteData]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeData()
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        self.addSubview(favoriteTableView)
        favoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        favoriteTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        favoriteTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        favoriteTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        favoriteTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    private func configureViewsOptions() {
        
        favoriteTableView.rowHeight = UITableView.automaticDimension
        
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.contentInsetAdjustmentBehavior = .never
        favoriteTableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
        favoriteTableView.register(OnePhotoCell.self, forCellReuseIdentifier: OnePhotoCell.identifier)
        favoriteTableView.register(ThreePhotoCell.self, forCellReuseIdentifier: ThreePhotoCell.identifier)
        
        
    }
    
    private func makeData() {
        let onephoto = OnePhoto(firstImage: UIImage(named: "house1")!)
        
        let threephoto = ThreePhoto(firstImage: UIImage(named: "house1") ?? UIImage(), secondImage: UIImage(named: "house2")!, thirdImage: UIImage(named: "house3")!)
        
        let title = TitleText(title: "저장 목록")
        
        
        favoriteDatas = [ FavoriteData(data: title, cellStyle: .title),
                          FavoriteData(data: onephoto, cellStyle: .one),
                          FavoriteData(data: threephoto, cellStyle: .three),
        ]
    }
}

extension FavoriteHouseListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteData = favoriteDatas[indexPath.row]
        
        switch favoriteData.cellStyle {
        case .title:
            if let titleTextData = favoriteData.data as? TitleText {
                let titleTextCell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: indexPath) as! TitleCell
                titleTextCell.setData(titleTextData: titleTextData)
                
                return titleTextCell
            }
        case .one:
            if let onePhotoData = favoriteData.data as? OnePhoto {
                let onePhotoCell = tableView.dequeueReusableCell(withIdentifier: OnePhotoCell.identifier, for: indexPath) as! OnePhotoCell
                onePhotoCell.setData(onePhotoData: onePhotoData)
                
                onePhotoCell.nationNameLable.text = "바르셀로나"
                onePhotoCell.descriptionLable.text = "숙소 1개"
                
                
                return onePhotoCell
            } else {
                print("onePhotoCell Convert Error")
            }
        case .three:
            if let threePhotoData = favoriteData.data as? ThreePhoto {
                let threePhotoCell = tableView.dequeueReusableCell(withIdentifier: ThreePhotoCell.identifier, for: indexPath) as! ThreePhotoCell
                threePhotoCell.setData(data: threePhotoData)
                
                threePhotoCell.nationNameLable.text = "아테네"
                threePhotoCell.descriptionLable.text = "숙소 3개"
                
                
                return threePhotoCell
            } else {
                print("threePhotoCell Convert Error")
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect")
        NotificationCenter.default.post(name: .moveToFavoriteHouseDetailVC, object: nil)
    }
    
    
}
