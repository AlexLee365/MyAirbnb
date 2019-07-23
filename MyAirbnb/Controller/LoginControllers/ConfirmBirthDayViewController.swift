//
//  ConfirmBirthDayViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 20/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class ConfirmBirthDayViewController: UIViewController {
    
    let dismissBtn = UIButton()
    
    let descriptionLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let guide = view.safeAreaLayoutGuide
        
        view.backgroundColor = .orange
        
        view.addSubview(dismissBtn)
        
        dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        dismissBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        dismissBtn.addTarget(self, action: #selector(didTapDismissBtn(_:)), for: .touchUpInside)
        
        dismissBtn.setTitle("dismiss Btn", for: .normal)
        dismissBtn.setTitleColor(.black, for: .normal)
        dismissBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        view.addSubview(descriptionLbl)
        
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.topAnchor.constraint(equalTo:dismissBtn.bottomAnchor, constant: 20).isActive = true
        descriptionLbl .centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionLbl.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        descriptionLbl.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        
        descriptionLbl.text = "생년월일 확인 뷰, 회원가입 버튼을 누르면 메인 뷰로 이동"
        
        
    }
    
    @objc private func didTapDismissBtn(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
        
    }
}
