//
//  SeoulRecommendedDetailViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 08/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class SeoulRecommendedDetailViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let headerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 600)
        view.backgroundColor = .blue
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let categotyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let locationImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let timeImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let provideImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let provideLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let langImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let langLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.tableHeaderView = headerView
        
        view.addSubview(bottomView)
        
//        headerView.addSubview(categotyLabel)
//        headerView.addSubview(titleLabel)
//        headerView.addSubview(<#T##view: UIView##UIView#>)
//        headerView.addSubview(<#T##view: UIView##UIView#>)
//        headerView.addSubview(<#T##view: UIView##UIView#>)
//        headerView.addSubview(<#T##view: UIView##UIView#>)
    }
    
    private func setAutolayout() {
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        
//        bottomView.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}


// MARK: - UITableViewDataSource

extension SeoulRecommendedDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

// MARK: - UITableViewDelegate

extension SeoulRecommendedDetailViewController: UITableViewDelegate {
    
}
