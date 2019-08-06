//
//  MyPageViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        tableView.register(ProfileInfoTableCell.self, forCellReuseIdentifier: ProfileInfoTableCell.identifier)
        tableView.register(EachRowTableCell.self, forCellReuseIdentifier: EachRowTableCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutolayout()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func setAutolayout() {
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


// MARK: - UITableViewDataSource
extension MyPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + myPageDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let profileCell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoTableCell.identifier, for: indexPath) as! ProfileInfoTableCell
            return profileCell
            
        case 1...myPageDatas.count:
            let eachRowTableCell = tableView.dequeueReusableCell(withIdentifier: EachRowTableCell.identifier, for: indexPath) as! EachRowTableCell
            
            eachRowTableCell.setData(myPageData: myPageDatas[indexPath.row - 1])
            
//            if indexPath.row == myPageDatas.count {
//                eachRowTableCell.separatorInset =
//                    UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
//            }
            
            return eachRowTableCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(myPageDatas[indexPath.row - 1].title)
        
        if myPageDatas[indexPath.row - 1].title == "로그아웃" {
            UserDefaults.standard.set(false, forKey: SingletonCommonData.userDefaultLoginStateKey)
            
            let signUpMainVC = SignUpMainViewController()
            let naviController = UINavigationController(rootViewController: signUpMainVC)
            
            present(naviController, animated: true)
        }
    }
}
