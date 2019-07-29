//
//  FindPassWordPageViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class FindPassWordPageViewController: UIViewController {
    
    let findPwScrollView = UIScrollView()
    
    let topBarItem = TopBarItemView()
    
    let inputEmailAndPhoneItem = InputEmailAndPhoneView()
    
    let findPassWordTitle = UILabel()
    let findPassWordSubTitle = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.init(patternImage: UIImage(named: "AirBnB-background")!)
        
        topBarItem.delegate = self
        inputEmailAndPhoneItem.delegate = self
        
        setupViews()
        setupLayout()
        setupConfigure()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(findPwScrollView)
        view.addSubview(topBarItem)
        findPwScrollView.addSubview(findPassWordTitle)
        findPwScrollView.addSubview(findPassWordSubTitle)
        findPwScrollView.addSubview(inputEmailAndPhoneItem)
    }
    
    private func setupLayout() {
        findPwScrollView.translatesAutoresizingMaskIntoConstraints = false
        topBarItem.translatesAutoresizingMaskIntoConstraints = false
        findPassWordTitle.translatesAutoresizingMaskIntoConstraints = false
        findPassWordSubTitle.translatesAutoresizingMaskIntoConstraints = false
        inputEmailAndPhoneItem.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = view.safeAreaLayoutGuide
        let topBarHeight = view.frame.height - (view.frame.height - 55)
        let labelWidth = view.frame.width - (20 * 2)
        let inputEmailAndPhoneItemHeight = view.frame.height - (view.frame.height - 100)
        
        NSLayoutConstraint.activate([
            findPwScrollView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 55),
            findPwScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            findPwScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            findPwScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            topBarItem.topAnchor.constraint(equalTo: guide.topAnchor),
            topBarItem.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            topBarItem.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            topBarItem.heightAnchor.constraint(equalToConstant: topBarHeight),
            
            findPassWordTitle.topAnchor.constraint(equalTo: findPwScrollView.topAnchor, constant: 20),
            findPassWordTitle.leadingAnchor.constraint(equalTo: findPwScrollView.leadingAnchor, constant: 20),
            findPassWordTitle.widthAnchor.constraint(equalToConstant: labelWidth),
            
            findPassWordSubTitle.topAnchor.constraint(equalTo: findPassWordTitle.bottomAnchor, constant: 10),
            findPassWordSubTitle.leadingAnchor.constraint(equalTo: findPwScrollView.leadingAnchor, constant: 20),
            findPassWordSubTitle.widthAnchor.constraint(equalToConstant: labelWidth),
            //30
            inputEmailAndPhoneItem.topAnchor.constraint(equalTo: findPassWordSubTitle.bottomAnchor, constant: 30),
            inputEmailAndPhoneItem.leadingAnchor.constraint(equalTo: findPwScrollView.leadingAnchor),
            inputEmailAndPhoneItem.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            inputEmailAndPhoneItem.heightAnchor.constraint(equalToConstant: inputEmailAndPhoneItemHeight),
            ])
        
    }
    
    private func setupConstraints() {
        findPwScrollView.contentSize.width = view.frame.width
        findPwScrollView.contentSize.height = view.frame.height + 10
    }
    
    private func setupConfigure() {
        
        //        오토레이아웃 테스트용
        //        findPwScrollView.backgroundColor = .orange
        findPwScrollView.backgroundColor = .clear
        
        findPassWordTitle.text = "비밀번호를 잊어버리셨나요?"
        findPassWordTitle.textColor = .white
        findPassWordTitle.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.init(rawValue:7))
        
        findPassWordSubTitle.text = "비밀번호를 다시 설정하려면 이메일을 입력하세요."
        findPassWordSubTitle.textColor = .white
        findPassWordSubTitle.font = UIFont.systemFont(ofSize: 17)
        
    }
    
}

extension FindPassWordPageViewController: TopBarItemViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}

extension FindPassWordPageViewController: InputEmailAndPhoneViewDelegate {
    func presentPickNationalNumberView() {
        let pickNationalNumberVC = PickNationalNumberViewController()
        
        present(pickNationalNumberVC, animated: true, completion: nil)
    }
}
