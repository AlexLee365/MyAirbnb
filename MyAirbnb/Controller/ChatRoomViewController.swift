//
//  ChatRoomViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 24/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class ChatRoomViewController: UIViewController {

    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0.8)
        view.layer.shadowRadius = 0
        return view
    }()
    
    let msgTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        label.text = "예약 문의"
        return label
    }()
    
    let detailBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("상세정보", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    
    let bottomView: BottomView = {
        let view = BottomView()
        view.backColor = .white
        return view
    }()
    
    let requestBookingBtn: UIButton = {
        let button = UIButton()
        button.setTitle("예약 요청하기", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.7731164384)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.5, weight: .bold)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let chatTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.autocorrectionType = .no
        return textView
    }()
    
    let sendBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("보내기", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    let noti = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
        addNotificationObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = UIColor.clear
        
        tabBarController?.tabBar.isHidden = true
    }

    private func addNotificationObserver() {
        noti.addObserver(self, selector: #selector(didReceiveKeyboardNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        noti.addObserver(self, selector: #selector(didReceiveKeyboardNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func didReceiveKeyboardNotification(_ sender: Notification) {
        guard let userInfo = sender.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }
        
        let floatingTFConst = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -keyboardFrame.height)
        floatingTFConst.priority = .defaultLow
        floatingTFConst.isActive = true
        
        let downTFConst = containerView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        downTFConst.priority = .defaultLow
        downTFConst.isActive = true
        
        if keyboardFrame.minY >= view.frame.maxY {
            UIView.animate(withDuration: duration) {
                downTFConst.priority = .defaultHigh
            }
            self.view.layoutIfNeeded()
            
        } else {
            UIView.animate(withDuration: duration) {
                floatingTFConst.priority = .defaultHigh
            }
            self.view.layoutIfNeeded()
        }
    }
    

    // MARK: - set custom navi back button & image
    private func setNavigationBar() {

        self.navigationItem.setHidesBackButton(true, animated:false)

        let customBackView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let backImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))

        backImageView.image = UIImage(named: "backForMsg")
        
        customBackView.addSubview(backImageView)

        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToPreviousView))
        customBackView.addGestureRecognizer(backTap)

        let leftBarButtonItem = UIBarButtonItem(customView: customBackView)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    @objc private func backToPreviousView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Properties
    
    private func configure() {
        view.backgroundColor = .white
        
        setNavigationBar()
        
        title = "K Family"
        
        view.addSubview(topView)
        topView.addSubview(msgTypeLabel)
        topView.addSubview(detailBtn)
        
        view.addSubview(bottomView)
        bottomView.addSubview(requestBookingBtn)
        
        chatTableView.dataSource = self
        chatTableView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        view.addSubview(chatTableView)
        
        view.addSubview(containerView)
        
        chatTextView.delegate = self
        containerView.addSubview(chatTextView)
        
        containerView.addSubview(sendBtn)
    }
    
    @objc private func hideKeyboard(_ sender: Any) {
        chatTextView.resignFirstResponder()
    }
    
    private func setAutolayout() {
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.09)
        }
        
        msgTypeLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
        }
        
        detailBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-20)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.snp.height).multipliedBy(0.12)
        }
        
        requestBookingBtn.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalToSuperview().multipliedBy(0.63)
        }
        
        chatTableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(containerView.snp.top)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(65)
            make.bottom.equalTo(bottomView.snp.top).priority(500)
        }
        
        chatTextView.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.top.equalTo(11)
            make.bottom.equalTo(-5)
            make.trailing.equalTo(sendBtn.snp.leading).offset(-20)
        }
        
        sendBtn.snp.makeConstraints { (make) in
            make.trailing.equalTo(-7)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
    }
}


// MARK: - UITableViewDataSource

extension ChatRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITextViewDelegate

extension ChatRoomViewController: UITextViewDelegate {

}
