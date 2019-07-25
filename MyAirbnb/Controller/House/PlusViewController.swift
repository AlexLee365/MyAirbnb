//
//  PlusViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 25/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class PlusViewController: UIViewController {

    let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "roomSample3")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let topView: TableviewTopView = {
        let view = TableviewTopView()
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(PlusIntroTableCell.self, forCellReuseIdentifier: PlusIntroTableCell.identifier)
        tableView.register(BrowsePhotosTableCell.self, forCellReuseIdentifier: BrowsePhotosTableCell.identifier)
        tableView.register(FacilityTableCell.self, forCellReuseIdentifier: FacilityTableCell.identifier)
        return tableView
    }()
    
    let bottomView: BottomInfoView = {
        let view = BottomInfoView()
        view.backColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.barStyle = .blackTranslucent
    }

    
    private func configure() {
        let imageViewHeight = view.frame.height * 0.7
        
        tableView.dataSource = self
        tableView.delegate = self
        headerImageView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: imageViewHeight)
        tableView.tableHeaderView = headerImageView
        view.addSubview(tableView)
        
        topView.delegate = self
        view.addSubview(topView)
        
        view.addSubview(bottomView)
    }
    
    private func setAutolayout() {
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.snp.height).multipliedBy(0.12)
        }
    }
}

// MARK: - UITableViewDataSource

extension PlusViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let introCell = tableView.dequeueReusableCell(withIdentifier: PlusIntroTableCell.identifier, for: indexPath) as! PlusIntroTableCell
            return introCell
        case 1:
            let browsePhotosCell = tableView.dequeueReusableCell(withIdentifier: BrowsePhotosTableCell.identifier, for: indexPath) as! BrowsePhotosTableCell
            return browsePhotosCell
        case 2:
            let facilityCell = tableView.dequeueReusableCell(withIdentifier: FacilityTableCell.identifier, for: indexPath) as! FacilityTableCell
            return facilityCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension PlusViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let becomeWhiteEndPoint = tableView.tableHeaderView!.frame.height - topView.frame.height
        let becomeWhiteStartPoint = becomeWhiteEndPoint - 70
        
        let opacity = ( scrollView.contentOffset.y - becomeWhiteStartPoint ) / (becomeWhiteEndPoint - becomeWhiteStartPoint)
        
        if scrollView.contentOffset.y > becomeWhiteStartPoint {
            navigationController?.view.backgroundColor = UIColor.white.withAlphaComponent(opacity)
            topView.backgroundColor = UIColor.white.withAlphaComponent(opacity)
            topView.backButton.setImage(UIImage(named: "backBlack"), for: .normal)
            topView.heartButton.setImage(UIImage(named: "heartBlack"), for: .normal)
            topView.shareButton.setImage(UIImage(named: "shareBlack"), for: .normal)
            
            navigationController?.navigationBar.barStyle = .default
            
        } else {
            navigationController?.view.backgroundColor = UIColor.white.withAlphaComponent(opacity)
            topView.backgroundColor = UIColor.white.withAlphaComponent(opacity)
            topView.backButton.setImage(UIImage(named: "backWhite"), for: .normal)
            topView.heartButton.setImage(UIImage(named: "heartWhite"), for: .normal)
            topView.shareButton.setImage(UIImage(named: "shareWhite"), for: .normal)
            
            navigationController?.navigationBar.barStyle = .blackTranslucent
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }
}

// MARK: - TableviewTopViewDelegate

extension PlusViewController: TableviewTopViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
