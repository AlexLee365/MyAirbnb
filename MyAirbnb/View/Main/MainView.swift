//
//  MainView.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 08/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    // MARK: - UI Properties
    let mainTableView = UITableView()
    
    // MARK: - Properties
    let netWork = NetworkCommunicator()
    
    var mainViewDatas = [MainViewData]()
    var useCase: (UseCase, UIViewController) = (.inMainVC, UIViewController())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
    private func setAutoLayout() {
        self.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainTableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        //        mainTableView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        mainTableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        //        mainTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        //        mainTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    private func configureViewsOptions() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainCategoryTableCell.self, forCellReuseIdentifier: MainCategoryTableCell.identifier)
        mainTableView.register(MainRecommendHouseTableCell.self, forCellReuseIdentifier: MainRecommendHouseTableCell.identifier)
        mainTableView.register(MainFullImageTableCell.self, forCellReuseIdentifier: MainFullImageTableCell.identifier)
        mainTableView.register(MainLuxeHouseTableCell.self, forCellReuseIdentifier: MainLuxeHouseTableCell.identifier)
        mainTableView.register(FourSquareTableCell.self, forCellReuseIdentifier: FourSquareTableCell.identifier)
        mainTableView.allowsSelection = false
        mainTableView.separatorStyle = .none
        
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.estimatedRowHeight = 200
    }
    
}

extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let houseData = mainViewDatas[indexPath.row]
        
        switch houseData.cellStyle {
        case .category:
            if let categoryData = houseData.data as? [Category] {
                 let CategoryCell = tableView.dequeueReusableCell(withIdentifier: MainCategoryTableCell.identifier, for: indexPath) as! MainCategoryTableCell
                CategoryCell.categoryDataArray = categoryData

                return CategoryCell
            } else {
                print("CategoryCell convert error")
            }
        
        case .plus:
            if let plusHouseData = houseData.data as? [HousePlusDataInList] {
                let recommendHoseCell = tableView.dequeueReusableCell(withIdentifier: MainRecommendHouseTableCell.identifier, for: indexPath) as! MainRecommendHouseTableCell
                recommendHoseCell.plusHouseDataArray = plusHouseData
                
                return recommendHoseCell
            } else {
                print("recommendHouseCell convert error")
            }
           
        case .fullImage:
            if let fullImageData = houseData.data as? [HouseFullImagDataInList] {
                let fullImageCell = tableView.dequeueReusableCell(withIdentifier: MainFullImageTableCell.identifier, for: indexPath) as! MainFullImageTableCell
                fullImageCell.setData(fullImageData: fullImageData.first!)
                
                return fullImageCell
            } else {
                print("fullImageCell convert error")
            }
           
        case .luxe:
            if let luxeHouseData = houseData.data as? [HouseLuxeDataInList] {
                let luxeHouseCell = tableView.dequeueReusableCell(withIdentifier: MainLuxeHouseTableCell.identifier, for: indexPath) as! MainLuxeHouseTableCell
                luxeHouseCell.luxeHouseDataArray = luxeHouseData
                
                return luxeHouseCell
            } else {
                print("luxeHouseCell convert error")
            }
          
        case .fourSquare:
            if let normalHouseData = houseData.data as? [HouseDataInList] {
                let normalHouseSquareCell = tableView.dequeueReusableCell(withIdentifier: FourSquareTableCell.identifier, for: indexPath) as! FourSquareTableCell
                normalHouseSquareCell.normalHouseDataArray = normalHouseData
                
                return normalHouseSquareCell
            } else {
                print("normal Housedata convert error")
            }
        }
      return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if mainViewDatas[indexPath.row].cellStyle == .fullImage {
            let height = ( (UIScreen.main.bounds.width - 40) * 1.25 ) + 40
            return height
        } else {
            return UITableView.automaticDimension
        }
    }
    
    
}



