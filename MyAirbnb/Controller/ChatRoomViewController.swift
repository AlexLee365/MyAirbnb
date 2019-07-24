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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = UIColor.clear
        
        tabBarController?.tabBar.isHidden = true
    }


    // MARK: - set custom navi back button & image
    func setNavigationBar() {

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

    @objc func backToPreviousView() {
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
    }
}
