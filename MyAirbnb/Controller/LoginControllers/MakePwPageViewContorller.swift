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
    let makePwScrollView = UIScrollView()
    let makePwTitleLbl = UILabel()
    let makePwSubTitleLbl = UILabel()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBarItem.delegate = self
        
        setupItems()
        setupLayout()
        setupConfigure()
        setupConstraint()
        
        view.backgroundColor = .init(patternImage: UIImage(named: "AirBnB-background")!)
        
        
    }
    
    private func setupItems() {
        view.addSubview(topBarItem)
        view.addSubview(makePwScrollView)
        
        makePwScrollView.addSubview(makePwTitleLbl)
        makePwScrollView.addSubview(makePwSubTitleLbl)
    }
    
    private func setupLayout() {
        
        let topBarHeight = view.frame.height - (view.frame.height - 55)
        let labelWidth = view.frame.width - (20 * 2)
        let makePwSubTitleHeight = view.frame.height - (view.frame.height - 45)
        
        let guide = view.safeAreaLayoutGuide
        
        topBarItem.translatesAutoresizingMaskIntoConstraints = false
        makePwScrollView.translatesAutoresizingMaskIntoConstraints = false
        makePwTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        makePwSubTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topBarItem.topAnchor.constraint(equalTo: guide.topAnchor),
            topBarItem.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            topBarItem.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            topBarItem.heightAnchor.constraint(equalToConstant: topBarHeight),
            
            makePwScrollView.topAnchor.constraint(equalTo: topBarItem.bottomAnchor),
            makePwScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            makePwScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            makePwScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            makePwTitleLbl.topAnchor.constraint(equalTo: makePwScrollView.topAnchor, constant: 20),
            makePwTitleLbl.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            makePwTitleLbl.widthAnchor.constraint(equalToConstant: labelWidth),
            
            makePwSubTitleLbl.topAnchor.constraint(equalTo: makePwTitleLbl.bottomAnchor, constant: 15),
            makePwSubTitleLbl.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            makePwSubTitleLbl.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            makePwSubTitleLbl.heightAnchor.constraint(equalToConstant: makePwSubTitleHeight),
            ])
    }
    
    private func setupConfigure() {
        makePwTitleLbl.text = "비밀번호 설정하기"
        makePwTitleLbl.textColor = .white
        makePwTitleLbl.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(7))
        
        makePwSubTitleLbl.numberOfLines = 0
        makePwSubTitleLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        makePwSubTitleLbl.text = "비밀번호는 최소 8자 이상이며, 기호 또는 숫자가 포함되어야 합니다."
        makePwSubTitleLbl.font = UIFont.boldSystemFont(ofSize: 17)
        makePwSubTitleLbl.textColor = .white
    }
    
    private func setupConstraint() {
        makePwScrollView.contentSize.width = view.frame.width
        makePwScrollView.contentSize.height = view.frame.height + 10
        
        //        오토레이아웃 테스트용
        makePwScrollView.backgroundColor = .orange
        //        makePwScrollView.backgroundColor = .clear
    }
    
}

extension MakePwPageViewContorller: TopBarItemViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
