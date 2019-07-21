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
    
    let topBarItem = TopBarItemView()
    
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
    let nextBtn = UIButton(type: .custom)
    let backBtn = UIButton(type: .custom)
    
    var bottomLayout: NSLayoutConstraint!
    var keyboardHeight: CGFloat = 0
    var bottomInsets: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        topBarItem.delegate = self
        
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
    
    
    // 뷰들이 그려진 후
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("safeAreaInsets", view.safeAreaInsets.bottom)
        // iphone의 맨 아래 부분 -> iphone X 버전부터 , 홈버튼이 없어진 이후 밑에 생김
        bottomInsets = view.safeAreaInsets.bottom
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
    
    // 키보드에 의해 가려지는 nextBtn 과 nextBtnBackground 키보드와 함께 올리기
    @objc func keyboardWillShow(_ sender: Notification) {
        let userInfo: NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRect = keyboardFrame.cgRectValue
        
        print("키보드 높이 : \(keyboardRect.height)")
        keyboardHeight = keyboardRect.height - bottomInsets
        print("safeAreaInsets을 뺀 키보드 높이 : \(keyboardHeight)")
        bottomLayout.constant = -keyboardHeight
    }
    
    // 키보드에 의해 가려지는 nextBtn 과 nextBtnBackground 키보드와 내리기
    @objc func keyboardWillHide(_ sender: Notification) {
        
        let userInfo: NSDictionary = sender.userInfo! as NSDictionary
        let hideKeyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameBeginUserInfoKey) as! NSValue
        let hideKeyboardRect = hideKeyboardFrame.cgRectValue
        let hideKeyboardHeight = hideKeyboardRect.height
        print("내려간 키보드 높이 : \(hideKeyboardHeight)")
        bottomLayout.constant = 0
    }
    
    // addSubViews
    private func addViews() {
        view.addSubview(scrollView)
        view.addSubview(topBarItem)
        
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
        scrollView.addSubview(backBtn)
        
        nextBtnBackground.addSubview(nextBtn)
    }
    
    
    // textfield 델리게이트와 여러 구성 요소
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
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        topBarItem.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.backgroundColor = .clear
        scrollView.contentSize.width = view.frame.width
        scrollView.contentSize.height = view.frame.height + 30
        
        let topBarHeight = view.frame.height - (view.frame.height - 55)
        let labelWidth = view.frame.width - (20 * 2)
        let textFieldWidth = view.frame.width - (33 * 2)
        let underLineHeight = view.frame.height - (view.frame.height - 2)
        let checkMarkWidth = view.frame.width - (view.frame.width - 28)
        let checkMarkHeight = view.frame.height - (view.frame.height - 20)
        let nextBtnBgHeight = view.frame.height - (view.frame.height - 80)
        let nextBtnBgWidth = view.frame.width
        let nextBtnWidth = view.frame.width - (view.frame.width - 80)
        let backBtnWidth = view.frame.width - (view.frame.width - 28)
        let backBtnHeight = view.frame.height - (view.frame.height - 25)
        
        
        NSLayoutConstraint.activate([
            topBarItem.topAnchor.constraint(equalTo: guide.topAnchor),
            topBarItem.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            topBarItem.trailingAnchor.constraint(equalTo:guide.trailingAnchor),
            topBarItem.heightAnchor.constraint(equalToConstant: topBarHeight),
            
            scrollView.topAnchor.constraint(equalTo: topBarItem.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            makeIdVCtitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
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
            
            //            nextBtnBackground.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0),
            //            nextBtnBackground.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0),
            //            nextBtnBackground.widthAnchor.constraint(equalToConstant: nextBtnBgWidth),
            //            nextBtnBackground.heightAnchor.constraint(equalToConstant: nextBtnBgHeight),
            
            nextBtn.topAnchor.constraint(equalTo: nextBtnBackground.topAnchor),
            nextBtn.trailingAnchor.constraint(equalTo: nextBtnBackground.trailingAnchor),
            nextBtn.widthAnchor.constraint(equalToConstant: nextBtnWidth),
            nextBtn.heightAnchor.constraint(equalToConstant: nextBtnBgHeight),
            
            backBtn.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            backBtn.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            backBtn.widthAnchor.constraint(equalToConstant: backBtnWidth),
            backBtn.heightAnchor.constraint(equalToConstant: backBtnHeight),
            
            ])
        
        // 다음 버튼의 배경 뷰 = nextBtnBackground 의 레이아웃
        bottomLayout = nextBtnBackground.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        bottomLayout.isActive = true
        nextBtnBackground.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0).isActive = true
        nextBtnBackground.widthAnchor.constraint(equalToConstant: nextBtnBgWidth).isActive = true
        nextBtnBackground.heightAnchor.constraint(equalToConstant: nextBtnBgHeight).isActive = true
        
        
        // 오토레이아웃 테스트 용
        //        scrollView.backgroundColor = .black
        //
        //        makeIdVCtitle.backgroundColor = .red
        //        firstNameInputTitle.backgroundColor = .blue
        //        firstNameInputTxtField.backgroundColor = .gray
        //        lastNameInputTitle.backgroundColor = .blue
        //        lastNameInputTxtField.backgroundColor = .gray
        //        firstCheckMarkImage.backgroundColor = .yellow
        //        lastCheckMarkImage.backgroundColor = .yellow
        //        nextBtnBackground.backgroundColor = .white
        //        nextBtn.backgroundColor = .blue
        //        backBtn.backgroundColor = .yellow
        
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
        
        
        backBtn.backgroundColor = .init(patternImage: UIImage.init(named: "backBtnImage")!)
        backBtn.addTarget(self, action: #selector(didTapBackBtn(_:)), for: .touchUpInside)
        
        nextBtn.setTitle("다음", for: .normal)
        nextBtn.setTitleColor(.lightGray, for: .normal)
        nextBtn.setTitleColor(.white, for: .selected)
        nextBtn.addTarget(self, action: #selector(didTapNextBtn(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapBackBtn(_ sender: UIButton) {
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    // "다음" 버튼 액션
    @objc private func didTapNextBtn(_ sender: UIButton) {
        let phoneNumberVC = InputPhoneNumberViewController()
        navigationController?.pushViewController(phoneNumberVC, animated: true)
    }
}

extension MakeIdPageViewController: UITextFieldDelegate {
    
    // 텍스트 필드 옆 체크 버튼 애니메이션 -> 수정 필요
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text ?? ""
        
        //        if textField == self.firstNameInputTxtField {
        //            text = firstNameInputTxtField.text ?? ""
        //        } else if textField == self.lastNameInputTxtField {
        //            text = lastNameInputTxtField.text ?? ""
        //        }
        
        let replaceText = (text as NSString).replacingCharacters(in: range, with: string)
        
        UIView.animate(withDuration: 0.1, delay: 0, animations: {
            
            if replaceText.isEmpty {
                self.firstCheckMarkImage.isHidden = true
                self.lastCheckMarkImage.isHidden = true
            } else {
                self.firstCheckMarkImage.isHidden = false
                self.lastCheckMarkImage.isHidden = false
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

extension MakeIdPageViewController: TopBarItemViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    
}


