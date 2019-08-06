//
//  TripDetailReviewViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class TripDetailReviewViewController: UIViewController {
    let topView: TableviewTopView = {
        let view = TableviewTopView()
        view.backgroundColor = .white
        view.backButton.setImage(UIImage(named: "close"), for: .normal)
        view.shareButton.isHidden = true
        view.heartButton.isHidden = true
        
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        view.layer.shadowRadius = 0
        view.layer.shadowColor = UIColor.gray.cgColor
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ReviewTableCell.self, forCellReuseIdentifier: ReviewTableCell.identifier)
        
        return tableView
    }()

    var reviewCount = 0
    var reviewArray = [TripReview]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        topView.delegate = self
        view.addSubview(topView)
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func setAutolayout() {
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}


// MARK: - UITableViewDataSource

extension TripDetailReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + reviewCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            titleCell.textLabel?.text = "후기 \(reviewCount)개"
            titleCell.textLabel?.font = UIFont(name: "AirbnbCerealApp-Bold", size: 28)
            titleCell.textLabel?.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            titleCell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            return titleCell
            
        } else {
            let reviewTableCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableCell.identifier, for: indexPath) as! ReviewTableCell
            
            reviewTableCell.userProfileImage.image = UIImage(named: "userProfileImage")
            reviewTableCell.userNameLabel.text = reviewArray[indexPath.row - 1].userSet
            
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateformatter.date(from: reviewArray[indexPath.row - 1].createdAt) ?? Date()
            
            let reviewDate = Calendar.current.dateComponents([.year, .month], from: date)
            
            reviewTableCell.dateLabel.text = "\(reviewDate.year ?? 0)년 \(reviewDate.month ?? 0)월"
            reviewTableCell.reviewLabel.text = reviewArray[indexPath.row - 1].tripReviewDescription

            reviewTableCell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            
            return reviewTableCell
        }
    }
}

// MARK: - UITableViewDelegate

extension TripDetailReviewViewController: UITableViewDelegate {
    
}

// MARK: - TableviewTopViewDelegate

extension TripDetailReviewViewController: TableviewTopViewDelegate {
    func popView() {
        dismiss(animated: true)
    }
}
