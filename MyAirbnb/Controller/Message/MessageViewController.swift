//
//  MessageViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 24/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

class MessageViewController: UIViewController, NVActivityIndicatorViewable {
    
    // MARK: - UI Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "메시지"
        label.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "메시지를 모두 읽으셨습니다."
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16.5)
        return label
    }()
    
    let indicatorLabel: UILabel = {
        let label = UILabel()
        label.text = "메세지를 불러오는 중입니다."
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.register(MsgListTableCell.self, forCellReuseIdentifier: MsgListTableCell.identifier)
        tableView.rowHeight = 110
        return tableView
    }()
    
    let indicator = NVActivityIndicatorView(frame: .zero)
    
    // MARK: - Properties
    let dateformatter = DateFormatter()
    var chatRoomArray: [ChatRoom] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutolayout()
        startIndicatorView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = UIColor.clear
        
        tabBarController?.tabBar.isHidden = false
        print("🔴🔴🔴 MessageVC chatroomArray: ", chatRoomArray)
        chatRoomArray = SingletonCommonData.shared.userChatRoomsArray
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configure() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        view.addSubview(titleLabel)
        view.addSubview(statusLabel)
        statusLabel.isHidden = true

        indicatorLabel.isUserInteractionEnabled = true
        view.addSubview(indicatorLabel)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 800, bottom: 0, right: -800)
        view.addSubview(tableView)
        
        view.bringSubviewToFront(indicatorLabel)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(20)
            make.height.equalTo(40)
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(20)
            make.height.equalTo(35)
        }
        
        indicatorLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-60)
//            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(statusLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func startIndicatorView() {
        view.addSubview(indicator)
        indicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(indicatorLabel.snp.top).offset(-15)
            make.width.height.equalTo(38)
        }
        indicator.type = .ballRotateChase
//        indicator.color = StandardUIValue.shared.colorBlueGreen
        indicator.color = StandardUIValue.shared.colorPink
        indicator.startAnimating()
    }
}

// MARK: - UITableViewDataSource

extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoomArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msgListCell = tableView.dequeueReusableCell(withIdentifier: MsgListTableCell.identifier, for: indexPath) as! MsgListTableCell
        msgListCell.chatRoomData = chatRoomArray[indexPath.row]
        
        return msgListCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (indexPath.row == chatRoomArray.count-1) ? (cell.separatorInset = .init(top: 0, left: 800, bottom: 0, right: -800)) : ()
        print(indexPath.row)
    }
}

// MARK: - UITableViewDelegate

extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoomVC = ChatRoomViewController()
        chatRoomVC.chatRoomData = self.chatRoomArray[indexPath.row]
        chatRoomVC.currentRoomIndex = indexPath.row
        navigationController?.pushViewController(chatRoomVC, animated: true)
    }
    
    
}


