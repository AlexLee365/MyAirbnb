//
//  HouseView.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 17/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HouseView: UIView {
    
    // MARK: - UI Properties
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let noResultLabel = UILabel()
    
    // MARK: - Properties
    let notiCenter = NotificationCenter.default
    var houseViewDatas = [HouseViewData]()
    var normalHouseDataArray = [HouseDataInList]()
    
    var useCase: (UseCase, UIViewController) = (.inHouseVC, UIViewController())
    
    var flag = false {
        didSet {
            if flag == false {
                if let data = ( houseViewDatas.filter{$0.cellStyle == .normalHouse}.map{ $0.data }.first ?? [] ) as? [HouseDataInList] {
                    normalHouseDataArray = data
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.noResultLabel.isHidden = (self.normalHouseDataArray.count == 0) ? false : true
                }
                
                flag = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if flag == false {
            if let data = ( houseViewDatas.filter{$0.cellStyle == .normalHouse}.map{ $0.data }.first ?? [] ) as? [HouseDataInList] {
                normalHouseDataArray = data
            }
            tableView.reloadData()
            noResultLabel.isHidden = (normalHouseDataArray.count == 0) ? false : true
            
            flag = true
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
       
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HouseTopLabelTableCell.self, forCellReuseIdentifier: HouseTopLabelTableCell.identifier)
        tableView.register(HouseLuxeTableCell.self, forCellReuseIdentifier: HouseLuxeTableCell.identifier)
        tableView.register(HousePlusTableCell.self, forCellReuseIdentifier: HousePlusTableCell.identifier)
        tableView.register(AllHouseLabelTableCell.self, forCellReuseIdentifier: AllHouseLabelTableCell.identifier)
        tableView.register(AllHousesTableCell.self, forCellReuseIdentifier: AllHousesTableCell.identifier)
        
        noResultLabel.isHidden = true
        noResultLabel.text = "검색 결과가 없습니다."
        noResultLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        noResultLabel.textColor = StandardUIValue.shared.colorRegularText
    }
    
    private func setAutolayout() {
        self.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.addSubview(noResultLabel)
        noResultLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-70)
        }
    }
}


// MARK: - UITableViewDataSource
extension HouseView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (houseViewDatas.count - 1) + normalHouseDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0..<houseViewDatas.count-1:
            let houseData = houseViewDatas[indexPath.row]
            
            switch houseData.cellStyle {
            case .introLabel:
                if let introLabelData = houseData.data as? [HouseIntroLabelDataInList] {
                    let topLabelCell = tableView.dequeueReusableCell(withIdentifier: HouseTopLabelTableCell.identifier, for: indexPath) as! HouseTopLabelTableCell
                    topLabelCell.setData(introData: introLabelData.first ?? HouseIntroLabelDataInList(intro: "Default"))
                    
                    return topLabelCell
                } else {
                    print("TopLabelCell convert error")
                }
                
            case .luxe:
                if let luxeData = houseData.data as? [HouseLuxeDataInList] {
                    let luxeHouseCell = tableView.dequeueReusableCell(withIdentifier: HouseLuxeTableCell.identifier, for: indexPath) as! HouseLuxeTableCell
                    luxeHouseCell.luxeHouseDataArray = luxeData
                    return luxeHouseCell
                } else {
                    print("luxeHouseCell convert error")
                }
                
            case .plus:
                if let plusData = houseData.data as? [HousePlusDataInList] {
                    let plusHouseCell = tableView.dequeueReusableCell(withIdentifier: HousePlusTableCell.identifier, for: indexPath) as! HousePlusTableCell
                    plusHouseCell.plusHouseDataArray = plusData
                    
                    return plusHouseCell
                } else {
                    print("plusHouseCell convert error")
                }
                
            case .titleLabel:
                if let titleData = houseData.data as? [HouseTitleLabelDataInList] {
                    let allHouseLabelCell = tableView.dequeueReusableCell(withIdentifier: AllHouseLabelTableCell.identifier, for: indexPath) as! AllHouseLabelTableCell
                    allHouseLabelCell.setData(titleData: titleData.first ?? HouseTitleLabelDataInList(title: "Default"))
                    
                    return allHouseLabelCell
                } else {
                    print("titleLabelCell convert error")
                }
            default: break
            }
        default:
            let otherCellStylesCount = houseViewDatas.count - 1
            let houseData = normalHouseDataArray[indexPath.row - otherCellStylesCount]
            
            let allHousesCell
                = tableView.dequeueReusableCell(withIdentifier: AllHousesTableCell.identifier, for: indexPath) as! AllHousesTableCell
            allHousesCell.setData(houseData: houseData)
            allHousesCell.currentIndex = indexPath.row
            return allHousesCell
        }
        return UITableViewCell()
    }
}

// MARK: - UITabBarDelegate

extension HouseView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row >= houseViewDatas.count-1 else { return }
        let otherCellStylesCount = houseViewDatas.count - 1
        let houseData = normalHouseDataArray[indexPath.row - otherCellStylesCount]
        
        notiCenter.post(name: .moveToHouseDetailView, object: nil,
                        userInfo: ["roomID": houseData.id,
                                   "type": houseData.roomType,
                                   "houseName": houseData.title,
                                   SingletonCommonData.notiKeySearchBarUseCase: useCase.0,
                                   SingletonCommonData.notiKeySearchBarInController: useCase.1])
    }
}
