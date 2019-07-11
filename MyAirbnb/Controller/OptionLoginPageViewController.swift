//
//  OptionLoginPageViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class OptionLoginPageViewController: UIViewController {
    
    let optionLoginTitle = UILabel()
    let dismissBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addViews()
        layout()
        configure()
    }
    
    private func addViews() {
        view.addSubview(optionLoginTitle)
        view.addSubview(dismissBtn)
    }
    
    private func layout() {
        optionLoginTitle.translatesAutoresizingMaskIntoConstraints = false
        dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            optionLoginTitle.widthAnchor.constraint(equalToConstant: 300),
            optionLoginTitle.heightAnchor.constraint(equalToConstant: 20),
            optionLoginTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            optionLoginTitle.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            ])
        
        NSLayoutConstraint.activate([
            dismissBtn.topAnchor.constraint(equalTo: optionLoginTitle.bottomAnchor, constant: 30),
            dismissBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dismissBtn.widthAnchor.constraint(equalToConstant: 100),
            dismissBtn.heightAnchor.constraint(equalToConstant: 70),
            ])
    }
    
    private func configure() {
        optionLoginTitle.text = "옵션 더 보기 눌렀을때 나오는 페이지"
        optionLoginTitle.font = UIFont.boldSystemFont(ofSize: 20)
        optionLoginTitle.textColor = .black
        
        dismissBtn.setTitle("dismiss", for: .normal)
        dismissBtn.setTitleColor(.red, for: .normal)
        dismissBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        dismissBtn.addTarget(self, action: #selector(didTapDismissBtn(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapDismissBtn(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
}
