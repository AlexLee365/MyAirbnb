//
//  FindPassWordPageViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class FindPassWordPageViewController: UIViewController {
    
    let findScrollView = UIScrollView()
    let backBtn = UIButton(type: .custom)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupViews()
        setupConstraints()
        setupConfigure()
    }
    
    private func setupViews() {
        view.addSubview(findScrollView)
        findScrollView.addSubview(backBtn)
    }
    
    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        findScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        findScrollView.contentSize.width = view.frame.width
        findScrollView.contentSize.height = view.frame.height + 10
        
        findScrollView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        findScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        findScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        findScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        
        findScrollView.backgroundColor = .orange
        
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        let backBtnWidth = self.view.frame.width - (self.view.frame.width - 28)
        
        backBtn.topAnchor.constraint(equalTo: findScrollView.topAnchor, constant: 10).isActive = true
        backBtn.leadingAnchor.constraint(equalTo: findScrollView.leadingAnchor, constant: 20).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: backBtnWidth).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: backBtnWidth).isActive = true
    }
    
    private func setupConfigure() {
        backBtn.backgroundColor = .init(patternImage: UIImage(named: "backBtnImage")!)
        backBtn.addTarget(self, action: #selector(didTapBackBtn(_:)) , for: .touchUpInside)
    }
    
    @objc private func didTapBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
