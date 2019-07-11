//
//  LoginPageViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    let findPassWordBtn = UIBarButtonItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        findPassWordBtnConfiguration()
        
    }
    
    private func findPassWordBtnConfiguration() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.tintColor = .white
        
        navigationItem.rightBarButtonItem = findPassWordBtn
        
        findPassWordBtn.title = "비밀번호찾기"
        findPassWordBtn.style = .done
        findPassWordBtn.target = self
        findPassWordBtn.action = #selector(didTapfindPassWordBtn(_:))
    }
    
    @objc private func didTapfindPassWordBtn(_ sender: UIBarButtonItem) {
        let findPassWordVC = FindPassWordPageViewController()
        
        navigationController?.pushViewController(findPassWordVC, animated: true)
    }
    
    
    
    
    
}
