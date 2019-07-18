//
//  FilterRemainsViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 16/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class FilterRemainsViewController: UIViewController {
    
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
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "필터"
        titleLabel.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let removeAllBtn = UIButton(type: .system)
        removeAllBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        removeAllBtn.titleLabel?.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        removeAllBtn.setTitle(" 모두 지우기 ", for: .normal)
        removeAllBtn.setTitleColor(.black, for: .normal)
        removeAllBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(removeAllBtn)
        
        removeAllBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        removeAllBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        removeAllBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       
        return view
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
        setAutolayout()
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InstantBookTableCell.self, forCellReuseIdentifier: InstantBookTableCell.identifier)
        tableView.register(QualifiedHouseTableCell.self, forCellReuseIdentifier: QualifiedHouseTableCell.identifier)
        tableView.register(PriceRangeTableCell.self, forCellReuseIdentifier: PriceRangeTableCell.identifier)
        view.addSubview(tableView)
        
        view.addSubview(topView)
    }
    
    private func setAutolayout() {
        let guide = view.safeAreaLayoutGuide
        topView.delegate = self
        topView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
    
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource

extension FilterRemainsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let instantBookCell = tableView.dequeueReusableCell(withIdentifier: InstantBookTableCell.identifier, for: indexPath) as! InstantBookTableCell
            return instantBookCell
        case 1:
            let qualifiedHouseCell = tableView.dequeueReusableCell(withIdentifier: QualifiedHouseTableCell.identifier, for: indexPath) as! QualifiedHouseTableCell
            return qualifiedHouseCell
        case 2:
            let priceRangeCell = tableView.dequeueReusableCell(withIdentifier: PriceRangeTableCell.identifier, for: indexPath) as! PriceRangeTableCell
            return priceRangeCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - TableviewTopViewDelegate

extension FilterRemainsViewController: UITableViewDelegate {
    
}

extension FilterRemainsViewController: TableviewTopViewDelegate {
    func popView() {
        dismiss(animated: true, completion: nil)
    }
}
