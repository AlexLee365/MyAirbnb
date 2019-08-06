//
//  LoginTestViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class LoginTestViewController: UIViewController {
    
    let noticeLabel = UILabel()
    let presentLoginTestPageBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setLoginPageBtn()
    }
    
    private func setLoginPageBtn() {
        view.addSubview(noticeLabel)
        noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        noticeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noticeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        
        noticeLabel.text = "This is testPage for connecting LoginPage"
        noticeLabel.font = .systemFont(ofSize: 14, weight: .bold)
        noticeLabel.textColor = .black
        
        view.addSubview(presentLoginTestPageBtn)
        presentLoginTestPageBtn.translatesAutoresizingMaskIntoConstraints = false
        presentLoginTestPageBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentLoginTestPageBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        presentLoginTestPageBtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        presentLoginTestPageBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
//        presentLoginTestPageBtn.setTitle("Go to LoginPage", for: .normal)
        presentLoginTestPageBtn.setTitle("LogOut Button", for: .normal)
        presentLoginTestPageBtn.setTitleColor(.red, for: .normal)
        presentLoginTestPageBtn.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        presentLoginTestPageBtn.addTarget(self, action: #selector(presentLoginTestPageBtnDidTap(_:)), for: .touchUpInside)
    }
    
    @objc func presentLoginTestPageBtnDidTap(_ sender: UIButton) {
        print("buttonDidTap")
        
        UserDefaults.standard.set(false, forKey: SingletonCommonData.userDefaultLoginStateKey)
        
        let signUpMainVC = SignUpMainViewController()
        let naviController = UINavigationController(rootViewController: signUpMainVC)
        
        present(naviController, animated: true)
    }
    
    
    

 

}
