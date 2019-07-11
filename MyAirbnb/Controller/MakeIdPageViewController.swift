//
//  MakeIdPageViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class MakeIdPageViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    let makeIdVCtitle = UILabel()
    
    let firstNameInputTitle = UILabel()
    let firstNameInputTxtField = UITextField()
    let firstNameUnderLine = UILabel()
    
    let lastNameInputTitle = UILabel()
    let lastNameInputTxtField = UITextField()
    let lastNameUnderLine = UILabel()
    
    let firstCheckMarkImage = UIImageView()
    let lastCheckMarkImage = UIImageView()
    
    let nextBtnBackground = UIView()
    let nextBtn = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MakeIdPageViewController의 배경 이미지 지정
        view.backgroundColor = .init(patternImage: UIImage.init(named: "AirBnB-background")!)
        
        
        textFieldsConfigure()
        addViews()
        makeIdPageItemsConfigure()
        makeIdPageItemsLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registForKeyboardNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("-------------[scrollView.frame.width]--------------")
        print(scrollView.frame.width)
        print("-------------[scrollView.frame.height]--------------")
        print(scrollView.frame.height)
        print(view.frame.height)
        
        // 이름 텍스트 필드 키보드 포커스
        self.firstNameInputTxtField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregistForKeyboardNotification()
    }
    
    // 가려지는 nextBtn을 키보드 위에 붙이기 위해 사용한 노티센터
    private func registForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 노티센터 옵저버 해제
    private func unregistForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // addSubViews
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(makeIdVCtitle)
        scrollView.addSubview(firstNameInputTitle)
        scrollView.addSubview(firstNameInputTxtField)
        scrollView.addSubview(firstNameUnderLine)
        scrollView.addSubview(lastNameInputTitle)
        scrollView.addSubview(lastNameInputTxtField)
        scrollView.addSubview(lastNameUnderLine)
        scrollView.addSubview(firstCheckMarkImage)
        scrollView.addSubview(lastCheckMarkImage)
        scrollView.addSubview(nextBtnBackground)
        nextBtnBackground.addSubview(nextBtn)
    }
    
    // textfield 델리게이트와 리턴키 변경
    private func textFieldsConfigure() {
        
        firstNameInputTxtField.delegate = self
        lastNameInputTxtField.delegate = self
        
        firstNameInputTxtField.returnKeyType = .next
        lastNameInputTxtField.returnKeyType = .next
        
        firstNameInputTxtField.autocorrectionType = .no
        lastNameInputTxtField.autocorrectionType = .no
    }
    
    // MakeIdPageViewController에 올린 모든 컨텐츠의 오토레이아웃
    private func makeIdPageItemsLayout() {
        
        let guide = view.safeAreaLayoutGuide
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        makeIdVCtitle.translatesAutoresizingMaskIntoConstraints = false
        firstNameInputTitle.translatesAutoresizingMaskIntoConstraints = false
        firstNameInputTxtField.translatesAutoresizingMaskIntoConstraints = false
        firstNameUnderLine.translatesAutoresizingMaskIntoConstraints = false
        lastNameInputTitle.translatesAutoresizingMaskIntoConstraints = false
        lastNameInputTxtField.translatesAutoresizingMaskIntoConstraints = false
        lastNameUnderLine.translatesAutoresizingMaskIntoConstraints = false
        firstCheckMarkImage.translatesAutoresizingMaskIntoConstraints = false
        lastCheckMarkImage.translatesAutoresizingMaskIntoConstraints = false
        nextBtnBackground.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.backgroundColor = .init(patternImage: UIImage.init(named: "AirBnB-background")!)
        
        let labelWidth = view.frame.width - (20 * 2)
        let textFieldWidth = view.frame.width - (33 * 2)
        let underLineHeight = view.frame.height - (view.frame.height - 2)
        let checkMarkWidth = view.frame.width - (view.frame.width - 28)
        let checkMarkHeight = view.frame.height - (view.frame.height - 20)
        let nextBtnBgHeight = view.frame.height - (view.frame.height - 80)
        let nextBtnBgWidth = view.frame.width
        let nextBtnWidth = view.frame.width - (view.frame.width - 80)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            makeIdVCtitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            makeIdVCtitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            makeIdVCtitle.widthAnchor.constraint(equalToConstant: labelWidth),
            
            firstNameInputTitle.topAnchor.constraint(equalTo: makeIdVCtitle.bottomAnchor, constant: 30),
            firstNameInputTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            firstNameInputTitle.widthAnchor.constraint(equalToConstant: labelWidth),
            
            firstNameInputTxtField.topAnchor.constraint(equalTo: firstNameInputTitle.bottomAnchor, constant: 15),
            firstNameInputTxtField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            firstNameInputTxtField.widthAnchor.constraint(equalToConstant: textFieldWidth),
            
            firstNameUnderLine.topAnchor.constraint(equalTo: firstNameInputTxtField.bottomAnchor, constant: 10),
            firstNameUnderLine.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            firstNameUnderLine.widthAnchor.constraint(equalToConstant: labelWidth),
            firstNameUnderLine.heightAnchor.constraint(equalToConstant: underLineHeight),
            
            lastNameInputTitle.topAnchor.constraint(equalTo: firstNameUnderLine.bottomAnchor, constant: 20),
            lastNameInputTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            lastNameInputTitle.widthAnchor.constraint(equalToConstant: labelWidth),
            
            lastNameInputTxtField.topAnchor.constraint(equalTo: lastNameInputTitle.bottomAnchor, constant: 15),
            lastNameInputTxtField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            lastNameInputTxtField.widthAnchor.constraint(equalToConstant: textFieldWidth),
            
            lastNameUnderLine.topAnchor.constraint(equalTo: lastNameInputTxtField.bottomAnchor, constant: 10),
            lastNameUnderLine.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            lastNameUnderLine.widthAnchor.constraint(equalToConstant: labelWidth),
            lastNameUnderLine.heightAnchor.constraint(equalToConstant: underLineHeight),
            
            firstCheckMarkImage.topAnchor.constraint(equalTo: firstNameInputTitle.bottomAnchor, constant: 15),
            firstCheckMarkImage.leadingAnchor.constraint(equalTo: firstNameInputTxtField.trailingAnchor, constant: 0),
            firstCheckMarkImage.widthAnchor.constraint(equalToConstant: checkMarkWidth),
            firstCheckMarkImage.heightAnchor.constraint(equalToConstant: checkMarkHeight),
            
            lastCheckMarkImage.topAnchor.constraint(equalTo: lastNameInputTitle.bottomAnchor, constant: 15),
            lastCheckMarkImage.leadingAnchor.constraint(equalTo: lastNameInputTxtField.trailingAnchor, constant: 0),
            lastCheckMarkImage.widthAnchor.constraint(equalToConstant: checkMarkWidth),
            lastCheckMarkImage.heightAnchor.constraint(equalToConstant: checkMarkHeight),
            
            nextBtnBackground.topAnchor.constraint(equalTo: guide.bottomAnchor, constant: -80),
            nextBtnBackground.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor, constant: 0),
            nextBtnBackground.widthAnchor.constraint(equalToConstant: nextBtnBgWidth),
            nextBtnBackground.heightAnchor.constraint(equalToConstant: nextBtnBgHeight),
            
            nextBtn.topAnchor.constraint(equalTo: nextBtnBackground.topAnchor),
            nextBtn.trailingAnchor.constraint(equalTo: nextBtnBackground.trailingAnchor),
            nextBtn.widthAnchor.constraint(equalToConstant: nextBtnWidth),
            nextBtn.heightAnchor.constraint(equalToConstant: nextBtnBgHeight),
            
            
            ])
        
        // 오토레이아웃 테스트 용
        //        scrollView.backgroundColor = .black
        //        makeIdVCtitle.backgroundColor = .red
        //        firstNameInputTitle.backgroundColor = .blue
        //        firstNameInputTxtField.backgroundColor = .gray
        //        lastNameInputTitle.backgroundColor = .blue
        //        lastNameInputTxtField.backgroundColor = .gray
        //        firstCheckMarkImage.backgroundColor = .black
        //        lastCheckMarkImage.backgroundColor = .black
        //        nextBtnBackground.backgroundColor = .white
        //        nextBtn.backgroundColor = .blue
        
    }
    
    // MakeIdPageViewController에 올린 모든 컨텐츠의 기본 구성 사항
    private func makeIdPageItemsConfigure() {
        makeIdVCtitle.text = "성명을 입력하세요"
        makeIdVCtitle.textColor = .white
        makeIdVCtitle.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(7))
        
        firstNameInputTitle.text = "이름"
        firstNameInputTitle.textColor = .white
        firstNameInputTitle.font = UIFont.boldSystemFont(ofSize: 15)
        
        firstNameInputTxtField.font = UIFont.systemFont(ofSize: 28)
        firstNameInputTxtField.textColor = .white
        firstNameInputTxtField.textAlignment = .left
        firstNameInputTxtField.backgroundColor = .clear
        firstNameInputTxtField.tag = 0
        
        firstNameUnderLine.backgroundColor = .white
        
        lastNameInputTitle.text = "성"
        lastNameInputTitle.textColor = .white
        lastNameInputTitle.font = UIFont.boldSystemFont(ofSize: 15)
        
        lastNameInputTxtField.font = UIFont.systemFont(ofSize: 28)
        lastNameInputTxtField.textColor = .white
        lastNameInputTxtField.textAlignment = .left
        lastNameInputTxtField.backgroundColor = .clear
        lastNameInputTxtField.tag = 1
        
        lastNameUnderLine.backgroundColor = .white
        
        firstCheckMarkImage.image = UIImage.init(named: "checkMark")
        firstCheckMarkImage.isHidden = true
        firstCheckMarkImage.backgroundColor = .clear
        
        lastCheckMarkImage.image = UIImage.init(named: "checkMark")
        lastCheckMarkImage.isHidden = true
        lastCheckMarkImage.backgroundColor = .clear
        
        nextBtnBackground.backgroundColor = .init(patternImage: UIImage.init(named: "nextBtn_Background")!)
        
        nextBtn.setTitle("다음", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        nextBtn.addTarget(self, action: #selector(didTapNextBtn(_:)), for: .touchUpInside)
    }
    
    
    // 키보드에 의해 가려지는 nextBtn 과 nextBtnBackground 키보드와 함께 올리기
    @objc private func keyboardWillShow(_ sender: Notification) {
        
        let userInfo: NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardRect = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRect.height
        print("키보드 높이 : \(keyboardHeight)")
        
        let nextBtnBgHeight = view.frame.height - (view.frame.height - 80)
        let nextBtnBgKeyTop = scrollView.frame.height - (keyboardHeight + nextBtnBgHeight)
        
        self.nextBtnBackground.frame.origin.y = nextBtnBgKeyTop
    }
    
    // 키보드에 의해 가려지는 nextBtn 과 nextBtnBackground 키보드와 내리기
    @objc private func keyboardWillHide(_ sender: Notification) {
        
        let userInfo: NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardRect = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRect.height
        print("키보드 높이 : \(keyboardHeight)")
        
        let nextBtnBgHeight = view.frame.height - (view.frame.height - 80)
        let nextBtnBgKeyBottom = view.frame.height - nextBtnBgHeight
        
        self.nextBtnBackground.frame.origin.y = nextBtnBgKeyBottom
    }
    
    // "다음" 버튼 액션
    @objc private func didTapNextBtn(_ sender: UIButton) {
        let phoneNumberVC = InputPhoneNumberViewController()
        navigationController?.pushViewController(phoneNumberVC, animated: true)
    }
}


extension MakeIdPageViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text ?? ""
        let replaceText = (text as NSString).replacingCharacters(in: range, with: string)
        
        UIView.animate(withDuration: 0.1, delay: 0, animations: {
            
            if replaceText.isEmpty {
                self.firstCheckMarkImage.isHidden = true
                //                self.lastCheckMarkImage.isHidden = true
                
            } else {
                self.firstCheckMarkImage.isHidden = false
                //                self.lastCheckMarkImage.isHidden = false
            }
        })
        return true
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField.isEqual(self.firstNameInputTxtField)) {
            lastNameInputTxtField.becomeFirstResponder()
            
        } else if(textField.isEqual(self.lastNameInputTxtField)) {
            
            let phoneNumberVC = InputPhoneNumberViewController()
            navigationController?.pushViewController(phoneNumberVC, animated: true)
            textField.resignFirstResponder()
        }
        return true
    }
    
}
