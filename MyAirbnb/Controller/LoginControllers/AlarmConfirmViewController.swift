//
//  AlarmConfirmViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 20/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class AlarmConfirmViewController: UIViewController {
    
    let alarmScrollView = UIScrollView()
    let alarmIconImage = UIImageView()
    let alarmViewTitle = UILabel()
    let alarmViewDescription = UILabel()
    let confirmBtn = UIButton()
    let skipBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //        오토레이아웃 테스트용
        //        view.backgroundColor = .orange
        
        setupConstants()
        setupConfigure()
        setupItems()
        setupLayoutItems()
    }
    
    // 제약
    private func setupConstants() {
        alarmIconImage.image = UIImage(named: "AlarmIcon")
        
        alarmScrollView.contentSize.width = view.frame.width
        // height 정확한 길이에 대한 계산 필요 -> 수정
        alarmScrollView.contentSize.height = view.frame.height + 1
        alarmScrollView.backgroundColor = .white
        
        alarmViewTitle.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(7))
        alarmViewTitle.textColor = .black
        
        alarmViewDescription.numberOfLines = 0
        alarmViewDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        alarmViewDescription.font = UIFont.systemFont(ofSize: 18)
        alarmViewDescription.textColor = .black
        
        confirmBtn.setTitleColor(.white, for: .normal)
        confirmBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        confirmBtn.titleLabel?.textAlignment = .center
        confirmBtn.backgroundColor = UIColor.init(displayP3Red: 0.222, green: 0.505, blue: 0.533, alpha: 1.0)
        confirmBtn.layer.borderWidth = 3
        confirmBtn.layer.borderColor = UIColor.init(displayP3Red: 0.222, green: 0.505, blue: 0.533, alpha: 1.0).cgColor
        confirmBtn.layer.cornerRadius = 7
        
        skipBtn.setTitleColor(UIColor.init(displayP3Red: 0.222, green: 0.505, blue: 0.533, alpha: 1.0), for: .normal)
        skipBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        skipBtn.titleLabel?.textAlignment = .center
        skipBtn.layer.borderWidth = 3
        skipBtn.layer.borderColor = UIColor.init(displayP3Red: 0.222, green: 0.505, blue: 0.533, alpha: 1.0).cgColor
        skipBtn.layer.cornerRadius = 7
        
    }
    
    // 기본 구성 사항
    private func setupConfigure() {
        alarmViewTitle.text = "알림을 켤까요?"
        
        alarmViewDescription.text = "메시지가 수신되거나 중요한 계정 활동이 있으면 알려 드립니다."
        
        confirmBtn.setTitle("예, 알림을 보내주세요", for: .normal)
        confirmBtn.addTarget(self, action: #selector(didTapConfirmBtn(_:)), for: .touchUpInside)
        
        skipBtn.setTitle("건너뛰기", for: .normal)
        skipBtn.addTarget(self, action: #selector(didTapSkipBtn(_:)), for: .touchUpInside)
    }
    
    // add views
    private func setupItems() {
        view.addSubview(alarmScrollView)
        
        alarmScrollView.addSubview(alarmIconImage)
        alarmScrollView.addSubview(alarmViewTitle)
        alarmScrollView.addSubview(alarmViewDescription)
        alarmScrollView.addSubview(confirmBtn)
        alarmScrollView.addSubview(skipBtn)
        
    }
    
    // 위치 설정
    private func setupLayoutItems() {
        let guide = view.safeAreaLayoutGuide
        
        let labelWidth = view.frame.width - (20 * 2)
        let btnHeight = view.frame.height - (view.frame.height - 50)
        let confirmBtnWidth = view.frame.width - (view.frame.width - 200)
        let skipBtnWidth = view.frame.width - (view.frame.width - 100)
        
        alarmScrollView.translatesAutoresizingMaskIntoConstraints = false
        alarmIconImage.translatesAutoresizingMaskIntoConstraints = false
        alarmViewTitle.translatesAutoresizingMaskIntoConstraints = false
        alarmViewDescription.translatesAutoresizingMaskIntoConstraints = false
        confirmBtn.translatesAutoresizingMaskIntoConstraints = false
        skipBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alarmScrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            alarmScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            alarmScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            alarmScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            alarmIconImage.topAnchor.constraint(equalTo: alarmScrollView.topAnchor, constant: 70),
            alarmIconImage.leadingAnchor.constraint(equalTo: alarmScrollView.leadingAnchor, constant: 20),
            
            alarmViewTitle.topAnchor.constraint(equalTo: alarmIconImage.bottomAnchor, constant: 20),
            alarmViewTitle.leadingAnchor.constraint(equalTo: alarmScrollView.leadingAnchor, constant: 20),
            alarmViewTitle.widthAnchor.constraint(equalToConstant: labelWidth),
            
            alarmViewDescription.topAnchor.constraint(equalTo: alarmViewTitle.bottomAnchor, constant: 20),
            alarmViewDescription.leadingAnchor.constraint(equalTo: alarmScrollView.leadingAnchor, constant: 20),
            alarmViewDescription.widthAnchor.constraint(equalToConstant: labelWidth),
            
            confirmBtn.topAnchor.constraint(equalTo: alarmViewDescription.bottomAnchor, constant: 40),
            confirmBtn.leadingAnchor.constraint(equalTo: alarmScrollView.leadingAnchor, constant: 20),
            confirmBtn.widthAnchor.constraint(equalToConstant: confirmBtnWidth),
            confirmBtn.heightAnchor.constraint(equalToConstant: btnHeight),
            
            skipBtn.topAnchor.constraint(equalTo: confirmBtn.bottomAnchor, constant: 15),
            skipBtn.leadingAnchor.constraint(equalTo: alarmScrollView.leadingAnchor, constant: 20),
            skipBtn.widthAnchor.constraint(equalToConstant: skipBtnWidth),
            skipBtn.heightAnchor.constraint(equalToConstant: btnHeight),
            
            ])
        
    }
    
    // 버튼 액션
    @objc private func didTapConfirmBtn(_ sender: UIButton) {
        
        // 메인 페이지랑 연결
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
        
        
        print("tapped ConfirmBtn")
    }
    
    @objc private func didTapSkipBtn(_ sender: UIButton) {
        
        // 메인 페이지랑 연결
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
        
        
        print("tapped SkipBtn")
    }
    
}
