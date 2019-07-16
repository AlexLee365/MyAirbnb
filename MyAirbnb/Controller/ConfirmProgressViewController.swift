//
//  ConfirmProgressViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 16/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class ConfirmProgressViewController: UIViewController {
    
    let dismissBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
        view.addSubview(dismissBtn)
        
        dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        dismissBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        dismissBtn.addTarget(self, action: #selector(didTapDismissBtn(_:)), for: .touchUpInside)
        
        dismissBtn.setTitle("dismiss", for: .normal)
        dismissBtn.setTitleColor(.black, for: .normal)
        dismissBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    @objc private func didTapDismissBtn(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}
