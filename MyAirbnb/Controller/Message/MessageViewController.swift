//
//  MessageViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 24/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class MessageViewController: UIViewController {
    
    let chatRoomArray: [ChatRoom] = SingletonCommonData.shared.userChatRoomsArray

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
    
    let emptyMsgLabel: UILabel = {
        let label = UILabel()
        label.text = "메시지를 모두 확인했습니다."
        label.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16.5, weight: .medium)
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
    
    let dateformatter = DateFormatter()
    
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
        
        print("🔴🔴🔴 MessageVC chatroomArray: ", chatRoomArray)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    private func configure() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        view.addSubview(titleLabel)
        view.addSubview(statusLabel)
        

        emptyMsgLabel.isUserInteractionEnabled = true
        view.addSubview(emptyMsgLabel)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 800, bottom: 0, right: -800)
        view.addSubview(tableView)
        
        
        
//        view.sendSubviewToBack(tableView)
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
        
        emptyMsgLabel.snp.makeConstraints { (make) in
            make.top.equalTo(statusLabel.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(emptyMsgLabel)
        }
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
        (indexPath.row == 2) ? (cell.separatorInset = .init(top: 0, left: 800, bottom: 0, right: -800)) : ()
        print(indexPath.row)
    }
}

// MARK: - UITableViewDelegate

extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoomVC = ChatRoomViewController()
        
        navigationController?.pushViewController(chatRoomVC, animated: true)
    }
    
    
}


