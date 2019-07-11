//
//  SignUpMainViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class SignUpMainViewController: UIViewController {
    
    let mainScrollView = UIScrollView()
    
    let loginBtn = UIBarButtonItem()
    let signUpBtn = UIButton()
    let facebookLoginBtn = UIButton()
    let optionBtn = UIButton()
    let bnbLogoImage = UIImageView()
    let firstWelcomMsgLbl = UILabel()
    let secondWelcomMsgLbl = UILabel()
    let mainDescriptionLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let naviBackImage = UIImage(named: "airBnB-background")
        
        view.backgroundColor = .init(patternImage: UIImage.init(named: "AirBnB-background")!)
        
        
        addSubViews()
        mainScrollViewLayout()
        
        btnLayout()
        btnLayoutConfigure()
        
        loginBtnConfigure()
        
        bnbLogoImageLayout()
        bnbLogoImageConfigure()
        
        labelsLayout()
        labelsConfigure()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    // 회원가입 메인 페이지에 올라가는 모든 뷰와 컨텐츠들을 addSubview
    private func addSubViews() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(facebookLoginBtn)
        mainScrollView.addSubview(signUpBtn)
        mainScrollView.addSubview(bnbLogoImage)
        mainScrollView.addSubview(firstWelcomMsgLbl)
        mainScrollView.addSubview(secondWelcomMsgLbl)
        mainScrollView.addSubview(optionBtn)
        mainScrollView.addSubview(mainDescriptionLbl)
    }
    
    // 메인 스크롤 뷰 레이아웃
    private func mainScrollViewLayout() {
        
        let guide = view.safeAreaLayoutGuide
        
        mainScrollView.backgroundColor = .init(patternImage: UIImage.init(named: "AirBnB-background")!)
        
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            ])
        mainScrollView.backgroundColor = .black
        
        //        mainScrollView.contentSize.width = view.frame.width
        //        mainScrollView.contentSize.height = view.frame.height
        
    }
    
    // 메인 에어비엔비 로고 이미지
    private func bnbLogoImageConfigure() {
        bnbLogoImage.image = UIImage(named: "AirBnB_Logo")
    }
    // 메인 에어비엔비 로고 이미지 레이아웃
    private func bnbLogoImageLayout() {
        
        bnbLogoImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bnbLogoImage.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 30),
            bnbLogoImage.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            //            bnbLogoImage.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -400),
            bnbLogoImage.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -800),
            ])
    }
    
    
    // 메인 환영 메시지 레이블, 하단 정책 설명 레이블
    private func labelsConfigure() {
        firstWelcomMsgLbl.text = "에어비엔비에 오신 것을 환영"
        firstWelcomMsgLbl.font = UIFont.boldSystemFont(ofSize: 28)
        firstWelcomMsgLbl.textColor = .white
        
        secondWelcomMsgLbl.text = "합니다."
        secondWelcomMsgLbl.font = UIFont.boldSystemFont(ofSize: 28)
        secondWelcomMsgLbl.textColor = .white
        
        mainDescriptionLbl.numberOfLines = 0
        mainDescriptionLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        mainDescriptionLbl.text = "'계속','계정 만들기',또는'기타 옵션'을 누름으로써 에어비엔비 서비스 약관과 결제 서비스 약관, 개인정보 처리 방침, 차별 금지 정책에 모두 동의합니다."
        mainDescriptionLbl.font = UIFont.boldSystemFont(ofSize: 14)
        mainDescriptionLbl.textColor = .white
    }
    
    // 메인 회원가입 페이지에 올라가는 모든 레이블들의 레이아웃
    private func labelsLayout() {
        
        firstWelcomMsgLbl.translatesAutoresizingMaskIntoConstraints = false
        secondWelcomMsgLbl.translatesAutoresizingMaskIntoConstraints = false
        mainDescriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstWelcomMsgLbl.topAnchor.constraint(equalTo: bnbLogoImage.bottomAnchor, constant: 20),
            firstWelcomMsgLbl.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            firstWelcomMsgLbl.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            firstWelcomMsgLbl.heightAnchor.constraint(equalToConstant: 45),
            
            
            
            secondWelcomMsgLbl.topAnchor.constraint(equalTo: firstWelcomMsgLbl.bottomAnchor, constant: 0),
            secondWelcomMsgLbl.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            secondWelcomMsgLbl.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            secondWelcomMsgLbl.heightAnchor.constraint(equalToConstant: 45),
            
            
            
            mainDescriptionLbl.topAnchor.constraint(equalTo: optionBtn.bottomAnchor, constant: 40),
            mainDescriptionLbl.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            mainDescriptionLbl.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -20),
            mainDescriptionLbl.heightAnchor.constraint(equalToConstant: 55),
            ])
        //        secondWelcomMsgLbl.backgroundColor = .black
        //        firstWelcomMsgLbl.backgroundColor = .yellow
        //        mainDescriptionLbl.backgroundColor = .blue
    }
    
    // 네비게이션 바 버튼 -> 로그인
    private func loginBtnConfigure() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.tintColor = .white
        
        navigationItem.rightBarButtonItem = loginBtn
        
        loginBtn.title = "로그인"
        loginBtn.style = .done
        loginBtn.target = self
        loginBtn.action = #selector(didTapLoginBtn(_:))
    }
    
    // 페이스북 계정 로그인 버튼, 계정 만들기 버튼, 옵션 더 보기 레이아웃
    private func btnLayout() {
        
        facebookLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        optionBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            facebookLoginBtn.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            facebookLoginBtn.topAnchor.constraint(equalTo: secondWelcomMsgLbl.bottomAnchor, constant: 30),
            facebookLoginBtn.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            facebookLoginBtn.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -20),
            facebookLoginBtn.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            signUpBtn.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            signUpBtn.topAnchor.constraint(equalTo:facebookLoginBtn.bottomAnchor, constant: 15),
            signUpBtn.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            signUpBtn.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -20),
            signUpBtn.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            optionBtn.topAnchor.constraint(equalTo: signUpBtn.bottomAnchor, constant: 40),
            optionBtn.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            optionBtn.heightAnchor.constraint(equalToConstant: 15),
            ])
        //        optionBtn.backgroundColor = .black
    }
    
    // 메인 회원가입 페이지에 올라가는 모든 버튼들의 기본 구성 사항
    private func btnLayoutConfigure() {
        
        signUpBtn.setTitle("계정 만들기", for: .normal)
        signUpBtn.setTitleColor(.white, for: .normal)
        signUpBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signUpBtn.titleLabel?.textAlignment = .center
        
        signUpBtn.layer.borderWidth = 3
        signUpBtn.layer.borderColor = UIColor.white.cgColor
        signUpBtn.layer.cornerRadius = 7
        
        signUpBtn.addTarget(self, action: #selector(didTapSignBtn(_:)), for: .touchUpInside)
        
        facebookLoginBtn.setTitle("페이스북 계정으로 로그인", for: .normal)
        facebookLoginBtn.backgroundColor = .white
        facebookLoginBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5842272043, blue: 0.6075613499, alpha: 1), for: .normal)
        facebookLoginBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        facebookLoginBtn.titleLabel?.textAlignment = .center
        
        facebookLoginBtn.layer.borderWidth = 3
        facebookLoginBtn.layer.borderColor = UIColor.white.cgColor
        facebookLoginBtn.layer.cornerRadius = 7
        
        facebookLoginBtn.addTarget(self, action: #selector(didTapFacebookLoginBtn(_:)), for: .touchUpInside)
        
        optionBtn.setTitle("옵션 더 보기", for: .normal)
        optionBtn.setTitleColor(.white, for: .normal)
        optionBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        optionBtn.titleLabel?.textAlignment = .center
        
        optionBtn.addTarget(self, action: #selector(didTapOptionBtn(_:)), for: .touchUpInside)
        
    }
    
    // 계정 만들기 버튼 액션
    @objc private func didTapSignBtn(_ sender: UIButton) {
        print("didTapSignBtn")
        let signUpPageVC = MakeIdPageViewController()
        navigationController?.pushViewController(signUpPageVC, animated: true)
    }
    
    // 페이스북 계정으로 로그인 버튼 액션
    @objc private func didTapFacebookLoginBtn(_ sender: UIButton) {
        print("tapped  facebookLoginBtn")
    }
    
    // 옵션 더 보기 버튼 액션
    @objc private func didTapOptionBtn(_ sender: UIButton) {
        print("didTapOptionBtn")
        let optionLoginVC = OptionLoginPageViewController()
        present(optionLoginVC, animated: true, completion: nil)
    }

    // 네비게이션 바 버튼 액션 -> 로그인 버튼
    @objc private func didTapLoginBtn(_ sender: UIBarButtonItem) {
        print("didTapLoginBtn")
        let loginPageVC = LoginPageViewController()
        navigationController?.pushViewController(loginPageVC, animated: true)
    }
}

