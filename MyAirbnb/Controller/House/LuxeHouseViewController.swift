//
//  LuxeHouseViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 27/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class LuxeHouseViewController: UIViewController {

    // MARK: - UI Properties
    let headerImageView = UIImageView()
    let tableView = UITableView()
    
    
    // MARK: - Properties
    var roomID = 0
    var roomTitle = ""
    var luxeHouseData: HouseLuxeDataInList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setAutolayout()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configure() {
        let headerWidth = UIScreen.main.bounds.width
        let headerHeight = UIScreen.main.bounds.height * 0.85
        headerImageView.frame = CGRect(x: 0, y: 0, width: headerWidth, height: headerHeight)
        headerImageView.image = UIImage(named: "luxeHouseSample4")
        if let url = URL(string: luxeHouseData?.image ?? "") {
            headerImageView.kf.setImage(with: url)
        }
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerImageView
        tableView.backgroundColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    private func setAutolayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(-80)
        }
    }
}

extension LuxeHouseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
