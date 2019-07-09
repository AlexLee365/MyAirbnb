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
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.opacity = 0
        view.translatesAutoresizingMaskIntoConstraints = false
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
        
        view.addSubview(bottomView)
    }
    
    private func setAutolayout() {
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        bottomView.heightAnchor.constraint(equalToConstant: 100).isActive = true
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
        
        if indexPath.row == 0 {
            let seoulRecommendCell = tableView.dequeueReusableCell(withIdentifier: SeoulRecommendTableViewCell.identifier, for: indexPath) as! SeoulRecommendTableViewCell
            seoulRecommendCell.backgroundColor = .black
            return seoulRecommendCell
            
        } else {
            return UITableViewCell()
        }
        
    }
}

// MARK: - UITableViewDelegate

extension SeoulRecommendedDetailViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        
        let cell = tableView.indexPath(for: SeoulRecommendTableViewCell())
        
        let becomeWhiteEndPoint = 500 - topView.frame.height
        let becomeWhiteStartPoint = becomeWhiteEndPoint - 100
        print("becomeWhiteEndPoint: ", becomeWhiteEndPoint, "/ becomeWhiteStartPoint: ", becomeWhiteStartPoint )
        
        if scrollView.contentOffset.y > becomeWhiteStartPoint {
            let opacity = ( scrollView.contentOffset.y - becomeWhiteStartPoint ) / (becomeWhiteEndPoint - becomeWhiteStartPoint)
            topView.layer.opacity = Float(opacity)
            isStatusBarWhite = false
        } else {
            topView.layer.opacity = 0
            isStatusBarWhite = true
        }
        setNeedsStatusBarAppearanceUpdate()
    }
}
