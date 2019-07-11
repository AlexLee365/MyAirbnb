//
//  InputPhoneNumberViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class InputPhoneNumberViewController: UIViewController {
    
    let phoneNumberPageTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        addViews()
        layout()
        configure()
    }
    
    private func addViews() {
        view.addSubview(phoneNumberPageTitle)
    }
    
    private func layout() {
        phoneNumberPageTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            phoneNumberPageTitle.widthAnchor.constraint(equalToConstant: 200),
            phoneNumberPageTitle.heightAnchor.constraint(equalToConstant: 20),
            phoneNumberPageTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            phoneNumberPageTitle.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            ])
    }
    
    private func configure() {
        phoneNumberPageTitle.text = "전화번호입력페이지"
        phoneNumberPageTitle.font = UIFont.boldSystemFont(ofSize: 20)
        phoneNumberPageTitle.textColor = .white
    }
}
