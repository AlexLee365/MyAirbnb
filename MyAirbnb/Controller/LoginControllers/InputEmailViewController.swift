//
//  InputEmailViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 30/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class InputEmailViewController: UIViewController {
    
    
    let inputPhoneScrollView = UIScrollView()
    
    let topBarItem = TopBarItemView()
    
    let keyboardTopViewItem = KeyboardTopView()
    
    // 전화번호를 입력하세요 페이지 메인 타이틀
    let mainTitle = UILabel()
    
    // 전화번호
    let phoneNumberTitle = UILabel()
    let inputEmailTxtField = UITextField()
    //    let pickNationalNumberBtn = UIButton(type: .custom)
    let underLine = UILabel()
    let topDescriptionLbl = UILabel()
    let rejectReceptionMsgLbl = UILabel()
    let receptionSwitch = UISwitch()
    
    var bottomLayout: NSLayoutConstraint!
    var keyboardHeight: CGFloat = 0
    var bottomInsets: CGFloat = 0
    
    let checkMark = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .init(patternImage: UIImage(named: "AirBnB-background")!)
        topBarItem.delegate = self
        keyboardTopViewItem.delegate = self
        
        addViews()
        layout()
        configure()
        txtFieldSetup()
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
        self.inputEmailTxtField.becomeFirstResponder()
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
    
    private func addViews() {
        view.addSubview(topBarItem)
        view.addSubview(inputPhoneScrollView)
        view.addSubview(keyboardTopViewItem)
        
        
        inputPhoneScrollView.addSubview(mainTitle)
        inputPhoneScrollView.addSubview(phoneNumberTitle)
        //        inputPhoneScrollView.addSubview(pickNationalNumberBtn)
        inputPhoneScrollView.addSubview(inputEmailTxtField)
        inputPhoneScrollView.addSubview(underLine)
        inputPhoneScrollView.addSubview(topDescriptionLbl)
        inputPhoneScrollView.addSubview(rejectReceptionMsgLbl)
        inputPhoneScrollView.addSubview(receptionSwitch)
        inputPhoneScrollView.addSubview(checkMark)
    }
    
    private func txtFieldSetup() {
        inputEmailTxtField.keyboardType = .emailAddress
        inputEmailTxtField.autocorrectionType = .no
    }
    
    private func layout() {
        
        let topBarHeight = view.frame.height - (view.frame.height - 55)
        let labelWidth = view.frame.width - (20 * 2)
        let nationalBtnWidth = view.frame.width - (view.frame.width - 50)
        let inputNumberWidth = view.frame.width - ((20 * 2) + 55)
        let underLineHeight = view.frame.height - (view.frame.height - 2)
        let topDescriptionHeight = view.frame.height - (view.frame.height - 45)
        let receptionLblHeight = view.frame.height - (view.frame.height - 55)
        let keyboardTopViewItemHeight = view.frame.height - (view.frame.height - 80)
        let keyboardTopViewItemWidth = view.frame.width
        let checkMarkWidth = view.frame.width - (view.frame.width - 28)
        let checkMarkHeight = view.frame.height - (view.frame.height - 20)
        
        
        inputPhoneScrollView.contentSize.width = view.frame.width
        inputPhoneScrollView.contentSize.height = view.frame.height + 10
        
        inputPhoneScrollView.translatesAutoresizingMaskIntoConstraints = false
        topBarItem.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTitle.translatesAutoresizingMaskIntoConstraints = false
        //        pickNationalNumberBtn.translatesAutoresizingMaskIntoConstraints = false
        inputEmailTxtField.translatesAutoresizingMaskIntoConstraints = false
        underLine.translatesAutoresizingMaskIntoConstraints = false
        topDescriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        rejectReceptionMsgLbl.translatesAutoresizingMaskIntoConstraints = false
        receptionSwitch.translatesAutoresizingMaskIntoConstraints = false
        keyboardTopViewItem.translatesAutoresizingMaskIntoConstraints = false
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        
        
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            topBarItem.topAnchor.constraint(equalTo: guide.topAnchor),
            topBarItem.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            topBarItem.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            topBarItem.heightAnchor.constraint(equalToConstant: topBarHeight),
            
            inputPhoneScrollView.topAnchor.constraint(equalTo: topBarItem.bottomAnchor),
            inputPhoneScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            inputPhoneScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            inputPhoneScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            mainTitle.topAnchor.constraint(equalTo: inputPhoneScrollView.topAnchor, constant: 20),
            mainTitle.leadingAnchor.constraint(equalTo: inputPhoneScrollView.leadingAnchor, constant: 20),
            mainTitle.widthAnchor.constraint(equalToConstant: labelWidth),
            
            phoneNumberTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 30),
            phoneNumberTitle.leadingAnchor.constraint(equalTo: inputPhoneScrollView.leadingAnchor, constant: 20),
            phoneNumberTitle.widthAnchor.constraint(equalToConstant: labelWidth),
            
            //            pickNationalNumberBtn.topAnchor.constraint(equalTo: phoneNumberTitle.bottomAnchor, constant: 15),
            //            pickNationalNumberBtn.leadingAnchor.constraint(equalTo: inputPhoneScrollView.leadingAnchor, constant: 20),
            //            pickNationalNumberBtn.widthAnchor.constraint(equalToConstant: nationalBtnWidth),
            
            inputEmailTxtField.topAnchor.constraint(equalTo: phoneNumberTitle.bottomAnchor, constant: 15),
            inputEmailTxtField.leadingAnchor.constraint(equalTo: inputPhoneScrollView.leadingAnchor, constant: 20),
            //            inputPhoneNumberTxtField.trailingAnchor.constraint(equalTo: inputPhoneScrollView.trailingAnchor, constant: inputNumberWidth),
            inputEmailTxtField.widthAnchor.constraint(equalToConstant: inputNumberWidth),
            
            underLine.topAnchor.constraint(equalTo: inputEmailTxtField.bottomAnchor, constant: 10),
            underLine.leadingAnchor.constraint(equalTo: inputPhoneScrollView.leadingAnchor, constant: 20),
            underLine.widthAnchor.constraint(equalToConstant: labelWidth),
            underLine.heightAnchor.constraint(equalToConstant: underLineHeight),
            
            topDescriptionLbl.topAnchor.constraint(equalTo: underLine.bottomAnchor, constant: 15),
            topDescriptionLbl.leadingAnchor.constraint(equalTo: inputPhoneScrollView.leadingAnchor, constant: 20),
            topDescriptionLbl.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            topDescriptionLbl.heightAnchor.constraint(equalToConstant: topDescriptionHeight),
            
            rejectReceptionMsgLbl.topAnchor.constraint(equalTo: topDescriptionLbl.bottomAnchor, constant: 15),
            rejectReceptionMsgLbl.leadingAnchor.constraint(equalTo: inputPhoneScrollView.leadingAnchor, constant: 20),
            rejectReceptionMsgLbl.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -80),
            rejectReceptionMsgLbl.heightAnchor.constraint(equalToConstant: receptionLblHeight),
            
            receptionSwitch.topAnchor.constraint(equalTo: topDescriptionLbl.bottomAnchor, constant: 15),
            receptionSwitch.leadingAnchor.constraint(equalTo: rejectReceptionMsgLbl.trailingAnchor, constant: 20),
            //            receptionSwitch.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            //            receptionSwitch.heightAnchor.constraint(equalToConstant: switchHeight),
            
            checkMark.topAnchor.constraint(equalTo: phoneNumberTitle.bottomAnchor, constant: 15),
            checkMark.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            checkMark.widthAnchor.constraint(equalToConstant: checkMarkWidth),
            checkMark.heightAnchor.constraint(equalToConstant: checkMarkHeight),
            
            ])
        
        bottomLayout = keyboardTopViewItem.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        bottomLayout.isActive = true
        keyboardTopViewItem.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0).isActive = true
        keyboardTopViewItem.widthAnchor.constraint(equalToConstant: keyboardTopViewItemWidth).isActive = true
        keyboardTopViewItem.heightAnchor.constraint(equalToConstant: keyboardTopViewItemHeight).isActive = true
        
        
    }
    
    private func configure() {
        
        //        오토레이아웃 테스트용
        //        inputPhoneScrollView.backgroundColor = .lightGray
        //        pickNationalNumberBtn.backgroundColor = .black
        //        inputPhoneNumberTxtField.backgroundColor = .lightGray
        //        topDescriptionLbl.backgroundColor = .black
        //        rejectReceptionMsgLbl.backgroundColor = .black
        
        // 스크롤뷰 백그라운드 컬러
        inputPhoneScrollView.backgroundColor = .clear
        
        //        pickNationalNumberBtn.backgroundColor = .white
        
        mainTitle.text = "이메일을 입력하세요."
        mainTitle.textColor = .white
        mainTitle.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(7))
        
        phoneNumberTitle.text = "이메일 주소"
        phoneNumberTitle.textColor = .white
        phoneNumberTitle.font = UIFont.boldSystemFont(ofSize: 15)
        
        //        pickNationalNumberBtn.setTitle("+82", for: .normal)
        //        pickNationalNumberBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        //        pickNationalNumberBtn.setTitleColor(UIColor.init(displayP3Red: 0.238, green: 0.448, blue: 0.576, alpha: 1.0), for: .normal)
        //        pickNationalNumberBtn.titleLabel?.textAlignment = .center
        //        pickNationalNumberBtn.addTarget(self, action: #selector(didTapPickNationalNumberBtn(_:)), for: .touchUpInside)
        //        pickNationalNumberBtn.layer.cornerRadius = 5
        
        inputEmailTxtField.font = UIFont.systemFont(ofSize: 28)
        inputEmailTxtField.textColor = .white
        inputEmailTxtField.textAlignment = .left
        inputEmailTxtField.backgroundColor = .clear
        inputEmailTxtField.addTarget(self, action: #selector(whenEditingEmailTxtField(_:)), for: .allEditingEvents)
        
        underLine.backgroundColor = .white
        
        topDescriptionLbl.numberOfLines = 0
        topDescriptionLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        topDescriptionLbl.text = "이메일을 통해 마케팅 프로모션, 특별 제안가, 추천 여행 및 정책 업테이트에 대해 안내해 드립니다"
        topDescriptionLbl.font = UIFont.boldSystemFont(ofSize: 14)
        topDescriptionLbl.textColor = .white
        
        rejectReceptionMsgLbl.numberOfLines = 0
        rejectReceptionMsgLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        rejectReceptionMsgLbl.text = "에어비앤비의 마케팅 메시지를 받고 싶지 않아요. 계정 관리 설정 또는 메시지의 링크에서 언제든 수신을 거부 할 수 있습니다."
        rejectReceptionMsgLbl.font = UIFont.boldSystemFont(ofSize: 14)
        rejectReceptionMsgLbl.textColor = .white
        
        // 스위치 버튼 색
        receptionSwitch.thumbTintColor = .white
        // 스위치 테두리 색
        receptionSwitch.tintColor = .clear
        // on 일때 스위치 바탕색
        receptionSwitch.onTintColor = .clear
        
        // 스위치의 테두리 색이 on일때 clear로 하면 아에 안보이므로 boarder의 색을 하얀색으로 만들어 보여주게 함
        receptionSwitch.layer.borderColor = UIColor.white.cgColor
        receptionSwitch.layer.borderWidth = 2
        receptionSwitch.layer.cornerRadius = receptionSwitch.frame.height / 2
        
        checkMark.image = UIImage.init(named: "checkMark")
        checkMark.isHidden = true
        checkMark.backgroundColor = .clear
    }
    
    @objc private func whenEditingEmailTxtField(_ sender: UITextField) {
        if (sender.text?.isEmpty)! == true {
            checkMark.isHidden = true
            keyboardTopViewItem.nextBtn.isSelected = false
        } else if (sender.text?.isEmpty)! == false {
            checkMark.isHidden = false
            keyboardTopViewItem.nextBtn.isSelected = true
        }
    }
    
    @objc private func didTapPickNationalNumberBtn(_ sender: UIButton) {
        let pickNationalPhoneNumberVC = PickNationalNumberViewController()
        
        present(pickNationalPhoneNumberVC, animated: true, completion: nil)
    }
    
    
    
}

extension InputEmailViewController: KeyboardTopViewDelegate {
    func pushView() {
        
        if (inputEmailTxtField.text?.isEmpty)! {
            print("must filled email address")
            return
        }
        
        let makePwVC = MakePwPageViewContorller()
        navigationController?.pushViewController(makePwVC, animated: true)
        
        let email = inputEmailTxtField.text ?? ""
        
        UserDefaults.standard.set(email, forKey: "email")
    }
}

extension InputEmailViewController: TopBarItemViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}

extension InputEmailViewController: UITextFieldDelegate {
    
}
