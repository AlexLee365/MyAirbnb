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
    
    let topBarItemLabel = UIView()
    
    let backBtn = UIButton(type: .custom)
    
    let findPwBtn = UIButton(type: .custom)
    
    let loginPageTitle = UILabel()
    
    let emailAddressTitle = UILabel()
    let emailTxtField = UITextField()
    let emailTxtUnderLine = UILabel()
    let emailCheckImage = UIImageView()
    
    let showAndHideBtn = UIButton(type: .custom)
    
    let passwordTitle = UILabel()
    let passwordTxtField = UITextField()
    let passwordTxtUnderLine = UILabel()
    
    let keyboardTopView = UIView()
    
    var bottomLayout: NSLayoutConstraint!
    var keyboardHeight: CGFloat = 0
    var bottomInsets: CGFloat = 0
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        view.backgroundColor = .blue
        addViews()
        textFieldsSetup()
        loginScrollViewLayout()
        loginPageItemsLayout()
        loginPageItemsConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registForKeyboardNotification()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("safeAreaInsets", view.safeAreaInsets.bottom)
        // iphone의 맨 아래 부분 -> iphone X 버전부터 , 홈버튼이 없어진 이후 밑에 생김
        bottomInsets = view.safeAreaInsets.bottom
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.emailTxtField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregistForKeyboardNotification()
    }
    
    
    private func registForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregistForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        let userInfo: NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRect = keyboardFrame.cgRectValue
        
        print("키보드 높이 : \(keyboardRect.height)")
        keyboardHeight = keyboardRect.height - bottomInsets
        print("safeAreaInsets을 뺀 키보드 높이 : \(keyboardHeight)")
        bottomLayout.constant = -keyboardHeight
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        
        let userInfo: NSDictionary = sender.userInfo! as NSDictionary
        let hideKeyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameBeginUserInfoKey) as! NSValue
        let hideKeyboardRect = hideKeyboardFrame.cgRectValue
        let hideKeyboardHeight = hideKeyboardRect.height
        print("내려간 키보드 높이 : \(hideKeyboardHeight)")
        bottomLayout.constant = 0
    }
    
    
    private func addViews() {
        view.backgroundColor = .init(patternImage: UIImage.init(named: "AirBnB-background")!)
        
        view.addSubview(loginScrollView)
        view.addSubview(topBarItemLabel)
        topBarItemLabel.addSubview(backBtn)
        topBarItemLabel.addSubview(findPwBtn)
        loginScrollView.addSubview(loginPageTitle)
        loginScrollView.addSubview(emailAddressTitle)
        loginScrollView.addSubview(emailTxtField)
        loginScrollView.addSubview(emailTxtUnderLine)
        loginScrollView.addSubview(emailCheckImage)
        loginScrollView.addSubview(passwordTitle)
        loginScrollView.addSubview(showAndHideBtn)
        loginScrollView.addSubview(passwordTxtField)
        loginScrollView.addSubview(passwordTxtUnderLine)
        loginScrollView.addSubview(keyboardTopView)
    }
    
    private func textFieldsSetup() {
        
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
        
        emailTxtField.returnKeyType = .next
        passwordTxtField.returnKeyType = .next
        
        emailTxtField.autocorrectionType = .no
        passwordTxtField.autocorrectionType = .no
    }
    
    // 스크롤 뷰 레이아웃
    private func loginScrollViewLayout() {
        
        let guide = view.safeAreaLayoutGuide
        
        loginScrollView.backgroundColor = .clear
        
        loginScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        loginScrollView.contentSize.width = view.frame.width
        loginScrollView.contentSize.height = view.frame.height + 10
        
        NSLayoutConstraint.activate([
            loginScrollView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 55),
            loginScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            ])
        //        loginScrollView.backgroundColor = .orange
    }
    
    // 로그인 페이지의 모든 컨텐츠 레이아웃
    private func loginPageItemsLayout() {
        
        let guide = view.safeAreaLayoutGuide
        
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        findPwBtn.translatesAutoresizingMaskIntoConstraints = false
        loginPageTitle.translatesAutoresizingMaskIntoConstraints = false
        topBarItemLabel.translatesAutoresizingMaskIntoConstraints = false
        emailAddressTitle.translatesAutoresizingMaskIntoConstraints = false
        emailTxtField.translatesAutoresizingMaskIntoConstraints = false
        emailTxtUnderLine.translatesAutoresizingMaskIntoConstraints = false
        passwordTitle.translatesAutoresizingMaskIntoConstraints = false
        showAndHideBtn.translatesAutoresizingMaskIntoConstraints = false
        passwordTxtField.translatesAutoresizingMaskIntoConstraints = false
        passwordTxtUnderLine.translatesAutoresizingMaskIntoConstraints = false
        emailCheckImage.translatesAutoresizingMaskIntoConstraints = false
        keyboardTopView.translatesAutoresizingMaskIntoConstraints = false
        
        let backBtnWidth = view.frame.width - (view.frame.width - 28)
        let backBtnHeight = view.frame.height - (view.frame.height - 25)
        let findPwBtnHeight = view.frame.height - (view.frame.height - 28)
        let findPwBtnWidth = view.frame.width - (view.frame.width - 100)
        let labelWidth = view.frame.width - (20 * 2)
        let textFieldWidth = view.frame.width - (33 * 2)
        let underLineHeight = view.frame.height - (view.frame.height - 2)
        let checkMarkWidth = view.frame.width - (view.frame.width - 28)
        let checkMarkHeight = view.frame.height - (view.frame.height - 20)
        let keyboardTopViewHeight = view.frame.height - (view.frame.height - 80)
        let keyboardTopViewWidth = view.frame.width
        
        NSLayoutConstraint.activate([
            //            backBtn.topAnchor.constraint(equalTo: topBarItemLabel.topAnchor, constant: 10),
            backBtn.centerYAnchor.constraint(equalTo: topBarItemLabel.centerYAnchor),
            backBtn.leadingAnchor.constraint(equalTo: topBarItemLabel.leadingAnchor, constant: 20),
            backBtn.widthAnchor.constraint(equalToConstant: backBtnWidth),
            backBtn.heightAnchor.constraint(equalToConstant: backBtnHeight),
            
            //            findPwBtn.topAnchor.constraint(equalTo: topBarItemLabel.topAnchor, constant: 10),
            findPwBtn.centerYAnchor.constraint(equalTo: topBarItemLabel.centerYAnchor),
            findPwBtn.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            findPwBtn.widthAnchor.constraint(equalToConstant: findPwBtnWidth),
            findPwBtn.heightAnchor.constraint(equalToConstant: findPwBtnHeight),
            
            loginPageTitle.topAnchor.constraint(equalTo: loginScrollView.topAnchor, constant: 10),
            loginPageTitle.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor, constant: 20),
            loginPageTitle.widthAnchor.constraint(equalToConstant: labelWidth),
            
            topBarItemLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            topBarItemLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            topBarItemLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            topBarItemLabel.bottomAnchor.constraint(equalTo: loginScrollView.topAnchor),
            
            emailAddressTitle.topAnchor.constraint(equalTo: loginPageTitle.bottomAnchor, constant: 30),
            emailAddressTitle.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor, constant: 20),
            emailAddressTitle.widthAnchor.constraint(equalToConstant: labelWidth),
            
            emailTxtField.topAnchor.constraint(equalTo: emailAddressTitle.bottomAnchor, constant: 15),
            emailTxtField.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor, constant: 20),
            emailTxtField.widthAnchor.constraint(equalToConstant: textFieldWidth),
            
            emailTxtUnderLine.topAnchor.constraint(equalTo: emailTxtField.bottomAnchor, constant: 10),
            emailTxtUnderLine.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor, constant: 20),
            emailTxtUnderLine.widthAnchor.constraint(equalToConstant: labelWidth),
            emailTxtUnderLine.heightAnchor.constraint(equalToConstant: underLineHeight),
            
            passwordTitle.topAnchor.constraint(equalTo: emailTxtUnderLine.bottomAnchor, constant: 20),
            passwordTitle.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor, constant: 20),
            passwordTitle.widthAnchor.constraint(equalToConstant: labelWidth),
            
            showAndHideBtn.topAnchor.constraint(equalTo: emailTxtUnderLine.bottomAnchor, constant: 20),
            showAndHideBtn.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            showAndHideBtn.heightAnchor.constraint(equalToConstant: findPwBtnHeight),
            
            passwordTxtField.topAnchor.constraint(equalTo: passwordTitle.bottomAnchor, constant: 15),
            passwordTxtField.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor, constant: 20),
            passwordTxtField.widthAnchor.constraint(equalToConstant: textFieldWidth),
            
            passwordTxtUnderLine.topAnchor.constraint(equalTo: passwordTxtField.bottomAnchor, constant: 10),
            passwordTxtUnderLine.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor, constant: 20),
            passwordTxtUnderLine.widthAnchor.constraint(equalToConstant: labelWidth),
            passwordTxtUnderLine.heightAnchor.constraint(equalToConstant: underLineHeight),
            
            emailCheckImage.topAnchor.constraint(equalTo: emailAddressTitle.bottomAnchor, constant: 15),
            emailCheckImage.leadingAnchor.constraint(equalTo: emailTxtField.trailingAnchor, constant: 0),
            emailCheckImage.widthAnchor.constraint(equalToConstant: checkMarkWidth),
            emailCheckImage.heightAnchor.constraint(equalToConstant: checkMarkHeight),
            
            ])
        
        bottomLayout = keyboardTopView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        bottomLayout.isActive = true
        keyboardTopView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0).isActive = true
        keyboardTopView.widthAnchor.constraint(equalToConstant: keyboardTopViewWidth).isActive = true
        keyboardTopView.heightAnchor.constraint(equalToConstant: keyboardTopViewHeight).isActive = true
        //        오토레이아웃 확인용
        //        backBtn.backgroundColor = .white
        //        findPwBtn.backgroundColor = .white
        //        topBarItemLabel.backgroundColor = .black
        //        emailTxtField.backgroundColor = .black
        //        showAndHideBtn.backgroundColor = .black
        //        passwordTxtField.backgroundColor = .black
        
    }
    
    // 로그인 페이지 모든 컨텐츠의 기본 구성 사항
    private func loginPageItemsConfigure() {
        
        topBarItemLabel.backgroundColor = .clear
        
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
        
        emailAddressTitle.text = "이메일 주소"
        emailAddressTitle.textColor = .white
        emailAddressTitle.font = UIFont.boldSystemFont(ofSize: 15)
        
        emailTxtField.font = UIFont.systemFont(ofSize: 28)
        emailTxtField.textColor = .white
        emailTxtField.textAlignment = .left
        emailTxtField.backgroundColor = .clear
        
        emailTxtUnderLine.backgroundColor = .white
        
        passwordTitle.text = "비밀번호"
        passwordTitle.textColor = .white
        passwordTitle.font = UIFont.boldSystemFont(ofSize: 15)
        
        showAndHideBtn.setTitle("표시", for: .normal)
        showAndHideBtn.setTitle("숨기기", for: .selected)
        showAndHideBtn.setTitleColor(.white, for: .normal)
        showAndHideBtn.setTitleColor(.white, for: .selected)
        showAndHideBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        showAndHideBtn.addTarget(self, action: #selector(didTapShowAndHideBtn(_:)), for: .touchUpInside)
        
        passwordTxtField.font = UIFont.systemFont(ofSize: 28)
        passwordTxtField.textColor = .white
        passwordTxtField.textAlignment = .left
        passwordTxtField.backgroundColor = .clear
        
        passwordTxtUnderLine.backgroundColor = .white
        
        emailCheckImage.image = UIImage.init(named: "checkMark")
        emailCheckImage.isHidden = true
        emailCheckImage.backgroundColor = .clear
        
        keyboardTopView.backgroundColor = .init(patternImage: UIImage(named: "nextBtn_Background")!)
    }
    @objc private func didTapShowAndHideBtn(_ sender: UIButton) {
        
        print("숨기기, 표시하기 버튼 동작")
    }
    
    @objc private func didTapBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapFindPwBtn(_ sender: UIButton) {
        let findPwVC = FindPassWordPageViewController()
        navigationController?.pushViewController(findPwVC, animated: true)
    }
    
}

extension LoginPageViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text ?? ""
        
        let replaceText = (text as NSString).replacingCharacters(in: range, with: string)
        
        UIView.animate(withDuration: 0.1, delay: 0, animations: {
            
            if replaceText.isEmpty {
                self.emailCheckImage.isHidden = true
            } else {
                self.emailCheckImage.isHidden = false
            }
            
        })
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.isEqual(self.emailTxtField)) {
            passwordTxtField.becomeFirstResponder()
            
        } else if(textField.isEqual(self.passwordTxtField)) {
            let confirmProgressVC = ConfirmProgressViewController()
            present(confirmProgressVC, animated: true)
        }
        return true
    }
    
}



