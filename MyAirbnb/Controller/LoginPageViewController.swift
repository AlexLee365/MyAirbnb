//
//  LoginPageViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    let loginScrollView = UIScrollView()
    let backBtn = UIButton(type: .custom)
    let findPwBtn = UIButton(type: .custom)
    let loginPageTitle = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        
        addViews()
        loginScrollViewLayout()
        loginPageItemsLayout()
        loginPageItemsConfigure()
    }
    
    private func addViews() {
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(backBtn)
        loginScrollView.addSubview(findPwBtn)
        loginScrollView.addSubview(loginPageTitle)
        
        
        
    }
    
    private func loginScrollViewLayout() {
        
        let guide = view.safeAreaLayoutGuide
        
        loginScrollView.backgroundColor = .init(patternImage: UIImage.init(named: "AirBnB-background")!)
        
        loginScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        loginScrollView.contentSize.width = view.frame.width
        loginScrollView.contentSize.height = view.frame.height + 10
        
        NSLayoutConstraint.activate([
            loginScrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            loginScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            ])
        loginScrollView.backgroundColor = .black
    }
    
    private func loginPageItemsLayout() {
        
        let guide = view.safeAreaLayoutGuide
        
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        findPwBtn.translatesAutoresizingMaskIntoConstraints = false
        loginPageTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let backBtnWidth = view.frame.width - (view.frame.width - 28)
        let findPwBtnHeight = view.frame.height - (view.frame.height - 28)
        let findPwBtnWidth = view.frame.width - (view.frame.width - 100)
        let labelWidth = view.frame.width - (20 * 2)
        
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: loginScrollView.topAnchor, constant: 10),
            backBtn.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor, constant: 20),
            backBtn.widthAnchor.constraint(equalToConstant: backBtnWidth),
            backBtn.heightAnchor.constraint(equalToConstant: backBtnWidth),
            
            findPwBtn.topAnchor.constraint(equalTo: loginScrollView.topAnchor, constant: 10),
            findPwBtn.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            findPwBtn.widthAnchor.constraint(equalToConstant: findPwBtnWidth),
            findPwBtn.heightAnchor.constraint(equalToConstant: findPwBtnHeight),
            
            loginPageTitle.topAnchor.constraint(equalTo: loginScrollView.topAnchor, constant: 70),
            loginPageTitle.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor, constant: 20),
            loginPageTitle.widthAnchor.constraint(equalToConstant: labelWidth),
            ])
        //        backBtn.backgroundColor = .white
        //        findPwBtn.backgroundColor = .white
        
    }
    
    private func loginPageItemsConfigure() {
        backBtn.backgroundColor = .init(patternImage: UIImage.init(named: "backBtnImage")!)
        backBtn.addTarget(self, action: #selector(didTapBackBtn(_:)), for: .touchUpInside)
        
        findPwBtn.setTitle("비밀번호 찾기", for: .normal)
        findPwBtn.setTitleColor(.white, for: .normal)
        findPwBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        findPwBtn.titleLabel?.textAlignment = .center
        
        findPwBtn.addTarget(self, action: #selector(didTapFindPwBtn(_:)), for: .touchUpInside)
        
        loginPageTitle.text = "로그인"
        loginPageTitle.textColor = .white
        loginPageTitle.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(7))
    }
    
    @objc private func didTapBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapFindPwBtn(_ sender: UIButton) {
        let findPwVC = FindPassWordPageViewController()
        navigationController?.pushViewController(findPwVC, animated: true)
    }
    
    
    
    
    
    
}
