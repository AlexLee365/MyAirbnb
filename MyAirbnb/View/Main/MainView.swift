//
//  MainView.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 08/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    // MARK: - UI Properties
    let mainTableView = UITableView()
    
    // MARK: - Properties
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        self.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

    }
    
    private func configureViewsOptions() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainCategoryTableCell.self, forCellReuseIdentifier: MainCategoryTableCell.identifier)
        
        
        mainTableView.rowHeight = 280
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
    }

}

extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberofrow")
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCategoryTableCell.identifier, for: indexPath) as! MainCategoryTableCell
        
        cell.titleLabel.text = "Jung Jin Alex님, 무엇을 찾고 계신가요?"
        
        return cell
    }
    
    
}
