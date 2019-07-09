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
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
//    let topView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.layer.opacity = 0
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    let topView = TableviewTopView()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    var isStatusBarWhite = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isStatusBarWhite {
            return .lightContent
        } else {
            return .default
        }
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SeoulRecommendTableViewCell.self, forCellReuseIdentifier: SeoulRecommendTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        view.addSubview(tableView)
        
        view.addSubview(topView)
//        topView.backgroundColor = .blue
        
        view.addSubview(bottomView)
    }
    
    private func setAutolayout() {
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        bottomView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.bringSubviewToFront(topView)
    }
}


// MARK: - UITableViewDataSource

extension SeoulRecommendedDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let seoulRecommendCell = tableView.dequeueReusableCell(withIdentifier: SeoulRecommendTableViewCell.identifier, for: indexPath) as! SeoulRecommendTableViewCell
            seoulRecommendCell.backgroundColor = .black
            seoulRecommendCell.selectionStyle = .none
            return seoulRecommendCell
            
        } else {
            return UITableViewCell()
        }
        
    }
}

// MARK: - UITableViewDelegate

extension SeoulRecommendedDetailViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) else { return }
        
        let becomeWhiteEndPoint = cell.frame.height - topView.frame.height
        let becomeWhiteStartPoint = becomeWhiteEndPoint - 100
        
        if scrollView.contentOffset.y > becomeWhiteStartPoint {
            let opacity = ( scrollView.contentOffset.y - becomeWhiteStartPoint ) / (becomeWhiteEndPoint - becomeWhiteStartPoint)
            topView.layer.opacity = Float(opacity)
            topView.backButton.setImage(UIImage(named: "backBlack"), for: .normal)
            topView.heartButton.setImage(UIImage(named: "heartBlack"), for: .normal)
            topView.shareButton.setImage(UIImage(named: "shareBlack"), for: .normal)
            isStatusBarWhite = false
        } else {
            topView.layer.opacity = 0
//            topView.backgroundColor = .white
            isStatusBarWhite = true
        }
        setNeedsStatusBarAppearanceUpdate()
    }
}

extension SeoulRecommendedDetailViewController: TableviewTopViewDelegate {
    func viewDismiss() {
        dismiss(animated: false, completion: nil)
    }
}
