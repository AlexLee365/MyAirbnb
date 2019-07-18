//
//  PickNationalNumberViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 18/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class PickNationalNumberViewController: UIViewController {
    
    let thisViewTitle = UILabel()
    let dismissBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addViews()
        layout()
        configure()
    }
    
    private func addViews() {
        view.addSubview(thisViewTitle)
        view.addSubview(dismissBtn)
    }
    
    private func layout() {
        thisViewTitle.translatesAutoresizingMaskIntoConstraints = false
        dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thisViewTitle.widthAnchor.constraint(equalToConstant: 300),
            thisViewTitle.heightAnchor.constraint(equalToConstant: 20),
            thisViewTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            thisViewTitle.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            ])
        
        NSLayoutConstraint.activate([
            dismissBtn.topAnchor.constraint(equalTo: thisViewTitle.bottomAnchor, constant: 30),
            dismissBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dismissBtn.widthAnchor.constraint(equalToConstant: 100),
            dismissBtn.heightAnchor.constraint(equalToConstant: 70),
            ])
    }
    
    private func configure() {
        thisViewTitle.text = "국가 전화번호, 지역 선택 뷰"
        thisViewTitle.font = UIFont.boldSystemFont(ofSize: 20)
        thisViewTitle.textColor = .black
        
        dismissBtn.setTitle("dismiss", for: .normal)
        dismissBtn.setTitleColor(.red, for: .normal)
        dismissBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        dismissBtn.addTarget(self, action: #selector(didTapDismissBtn(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapDismissBtn(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
}
