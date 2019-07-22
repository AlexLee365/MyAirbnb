//
//  MakePwPageViewContorller.swift
//  MyAirbnb
//
//  Created by 김광준 on 20/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class MakePwPageViewContorller: UIViewController {
    
    let topBarItem = TopBarItemView()
    let keyboardTopViewItem = KeyboardTopView()
    let makePwScrollView = UIScrollView()
    let makePwTitleLbl = UILabel()
    let makePwSubTitleLbl = UILabel()
    let inputPwTxtField = UITextField()
    let underLine = UILabel()
    let keyboardNotiCenter = KeyboardNotiCenter()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBarItem.delegate = self
        keyboardTopViewItem.delegate = self
        
        
        setupItems()
        setupConstraint()
        setupConfigure()
        setupLayout()
        view.backgroundColor = .init(patternImage: UIImage(named: "AirBnB-background")!)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        keyboardNotiCenter.registForKeyboardNotification(self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.inputPwTxtField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        keyboardNotiCenter.unregistForKeyboardNotification(self)
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    private func setupItems() {
        view.addSubview(topBarItem)
        view.addSubview(makePwScrollView)
        
        makePwScrollView.addSubview(keyboardTopViewItem)
        makePwScrollView.addSubview(makePwTitleLbl)
        makePwScrollView.addSubview(makePwSubTitleLbl)
        makePwScrollView.addSubview(inputPwTxtField)
        makePwScrollView.addSubview(underLine)
    }
    
    private func setupLayout() {
        
        let topBarHeight = view.frame.height - (view.frame.height - 55)
        let labelWidth = view.frame.width - (20 * 2)
        let makePwSubTitleHeight = view.frame.height - (view.frame.height - 45)
        let underLineHeight = view.frame.height - (view.frame.height - 2)
        let underLineWidth = view.frame.width - (20 * 2)
        let scrollViewHeight = view.frame.height / 4
        let keyboardTopViewHeight = view.frame.height - (view.frame.height - 80)
        let keyboardTopViewWidth = view.frame.width
        
        let guide = view.safeAreaLayoutGuide
        
        topBarItem.translatesAutoresizingMaskIntoConstraints = false
        keyboardTopViewItem.translatesAutoresizingMaskIntoConstraints = false
        makePwScrollView.translatesAutoresizingMaskIntoConstraints = false
        makePwTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        makePwSubTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        inputPwTxtField.translatesAutoresizingMaskIntoConstraints = false
        underLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topBarItem.topAnchor.constraint(equalTo: guide.topAnchor),
            topBarItem.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            topBarItem.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            topBarItem.heightAnchor.constraint(equalToConstant: topBarHeight),
            
            makePwScrollView.topAnchor.constraint(equalTo: topBarItem.bottomAnchor),
            makePwScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            makePwScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            makePwScrollView.heightAnchor.constraint(equalToConstant: scrollViewHeight),
            
            makePwTitleLbl.topAnchor.constraint(equalTo: makePwScrollView.topAnchor, constant: 20),
            makePwTitleLbl.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            makePwTitleLbl.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            //            makePwTitleLbl.widthAnchor.constraint(equalToConstant: labelWidth),
            
            makePwSubTitleLbl.topAnchor.constraint(equalTo: makePwTitleLbl.bottomAnchor, constant: 15),
            makePwSubTitleLbl.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            makePwSubTitleLbl.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            makePwSubTitleLbl.heightAnchor.constraint(equalToConstant: makePwSubTitleHeight),
            
            inputPwTxtField.topAnchor.constraint(equalTo: makePwSubTitleLbl.bottomAnchor, constant: 20),
            inputPwTxtField.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            inputPwTxtField.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            
            underLine.topAnchor.constraint(equalTo: inputPwTxtField.bottomAnchor, constant: 10),
            underLine.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            underLine.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            //            underLine.widthAnchor.constraint(equalToConstant: underLineWidth),
            underLine.heightAnchor.constraint(equalToConstant: underLineHeight),
            
            ])
        
        keyboardNotiCenter.bottomLayout = keyboardTopViewItem.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        keyboardNotiCenter.bottomLayout.isActive = true
        keyboardTopViewItem.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0).isActive = true
        keyboardTopViewItem.widthAnchor.constraint(equalToConstant: keyboardTopViewWidth).isActive = true
        keyboardTopViewItem.heightAnchor.constraint(equalToConstant: keyboardTopViewHeight).isActive = true
    }
    
    private func setupConfigure() {
        makePwTitleLbl.text = "비밀번호 설정하기"
        makePwTitleLbl.textColor = .white
        makePwTitleLbl.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(7))
        
        makePwSubTitleLbl.numberOfLines = 0
        //        makePwSubTitleLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        makePwSubTitleLbl.text = "비밀번호는 최소 8자 이상이며, 기호 또는 숫자가 포함되어야 합니다."
        makePwSubTitleLbl.font = UIFont.boldSystemFont(ofSize: 17)
        makePwSubTitleLbl.textColor = .white
        
        inputPwTxtField.font = UIFont.systemFont(ofSize: 28)
        inputPwTxtField.textColor = .white
        inputPwTxtField.textAlignment = .left
        inputPwTxtField.backgroundColor = .clear
        
        underLine.backgroundColor = .white
    }
    
    private func setupConstraint() {
        //        makePwScrollView.contentSize.width = (view.safeAreaInsets.left + view.safeAreaInsets.right)
        makePwScrollView.contentSize.width = view.frame.width
        makePwScrollView.contentSize.height = view.frame.height / 3.8
        
        makePwScrollView.backgroundColor = .orange
        inputPwTxtField.backgroundColor = .clear
        
        inputPwTxtField.autocorrectionType = .no
        
        //        view.safeAreaInsets.left
        
        //        오토레이아웃 테스트용
        //        makePwScrollView.backgroundColor = .orange
        //        inputPwTxtField.backgroundColor = .black
        
        
    }
    
}

extension MakePwPageViewContorller: TopBarItemViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}

extension MakePwPageViewContorller: KeyboardTopViewDelegate {
    func pushView() {
        
        let birthDayVC = ConfirmBirthDayViewController()
        
        navigationController?.pushViewController(birthDayVC, animated: true)
    }
    
    
}
