//
//  SucessViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 29/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

// This VC will Delete
// This VC is only for sucess to login and get-token
class SucessViewController: UIViewController {
    
    let loginSucessTitle = UILabel()
    let dismissBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addViews()
        layout()
        configure()
    }
    
    private func addViews() {
        view.addSubview(loginSucessTitle)
        view.addSubview(dismissBtn)
    }
    
    private func layout() {
        loginSucessTitle.translatesAutoresizingMaskIntoConstraints = false
        dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginSucessTitle.widthAnchor.constraint(equalToConstant: 100),
            loginSucessTitle.heightAnchor.constraint(equalToConstant: 20),
            loginSucessTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginSucessTitle.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            ])
        
        NSLayoutConstraint.activate([
            dismissBtn.topAnchor.constraint(equalTo: loginSucessTitle.bottomAnchor, constant: 30),
            dismissBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dismissBtn.widthAnchor.constraint(equalToConstant: 100),
            dismissBtn.heightAnchor.constraint(equalToConstant: 70),
            ])
    }
    
    private func configure() {
        loginSucessTitle.text = "로그인 성공"
        loginSucessTitle.font = UIFont.boldSystemFont(ofSize: 20)
        loginSucessTitle.textColor = .black
        
        dismissBtn.setTitle("dismiss", for: .normal)
        dismissBtn.setTitleColor(.red, for: .normal)
        dismissBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        dismissBtn.addTarget(self, action: #selector(didTapDismissBtn(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapDismissBtn(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
}
