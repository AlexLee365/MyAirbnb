//
//  TestMessageViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 18/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class TestMessageViewController: UIViewController {
    
      let noticeLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(noticeLabel)
        noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        noticeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noticeLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        
        noticeLabel.text = "This is testPage for MessagePage"
        noticeLabel.font = .systemFont(ofSize: 14, weight: .bold)
        noticeLabel.textColor = .black
    }
    

 

}
