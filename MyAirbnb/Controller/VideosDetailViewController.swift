//
//  VideosDetailViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 15/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class VideosDetailViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let topView = TableviewTopView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barStyle = .default
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VideosDetailTableCell.self, forCellReuseIdentifier: VideosDetailTableCell.identifier)
        view.addSubview(tableView)
        
        view.addSubview(topView)
    }
    
    private func setAutolayout() {
        let guide = view.safeAreaLayoutGuide
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
}

// MARK: - UITableViewDataSource

extension VideosDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let videoCell = tableView.dequeueReusableCell(withIdentifier: VideosDetailTableCell.identifier, for: indexPath) as! VideosDetailTableCell
            return videoCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension VideosDetailViewController: UITableViewDelegate {
}

