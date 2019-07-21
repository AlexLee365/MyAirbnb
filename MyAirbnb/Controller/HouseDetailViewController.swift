//
//  HouseDetailViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 17/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setAutoLayout()
        configureViewsOptions()
    }
    
    private func setAutoLayout() {
        let safeGuide = view.safeAreaLayoutGuide
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
    }
    
    private func configureViewsOptions() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HouseDetailPicturesTableCell.self, forCellReuseIdentifier: HouseDetailPicturesTableCell.identifier)
        tableView.register(HouseDetailBasicInfoTableCell.self, forCellReuseIdentifier: HouseDetailBasicInfoTableCell.identifier)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.allowsSelection = false
        
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    


}

extension HouseDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let houseDetailPicturesTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailPicturesTableCell.identifier, for: indexPath) as! HouseDetailPicturesTableCell
            
            return houseDetailPicturesTableCell
        case 1:
            let houseDetailBasicInfoTableCell = tableView.dequeueReusableCell(withIdentifier: HouseDetailBasicInfoTableCell.identifier, for: indexPath) as! HouseDetailBasicInfoTableCell
            
            return houseDetailBasicInfoTableCell
        default : break
        }
        
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 1 {
//            return 800
//        }
//        return UITableView.automaticDimension
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
        let contentY = scrollView.contentOffset.y
        print(contentY)
        
        if contentY < 0 {     //
            let scaleValue = ( -(contentY)/300 ) + 1
//            print(scaleValue)
            
            let houseDetailPictureCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! HouseDetailPicturesTableCell
            houseDetailPictureCell.scrollView.transform = CGAffineTransform(scaleX: scaleValue, y: scaleValue)
    
//            houseDetailPictureCell.scrollView.transform = CGAffineTransform(scaleX: 0, y: contentY)
            
//            houseDetailPictureCell.pictureViews.first?.transform = CGAffineTransform(scaleX: 0, y: contentY)
//            houseDetailPictureCell.pictureViews.first?.transform = CGAffineTransform(scaleX: scaleValue, y: scaleValue)
        }
    }
    
    
}
