//
//  MessageViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 24/07/2019.
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
    
    let noDataMessageLabel = UILabel()
    
    let changeHostModeIcon = UIButton()
    let changeHostModeLabel = UILabel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.register(MsgListTableCell.self, forCellReuseIdentifier: MsgListTableCell.identifier)
        tableView.rowHeight = 110
        return tableView
    }()
    
    let indicator = NVActivityIndicatorView(frame: .zero)
    
    // MARK: - Properties
    let netWork = NetworkCommunicator()
    let dateformatter = DateFormatter()
    var chatRoomArray: [ChatRoom] = []
    var hostMode = false {
        didSet {
            switch hostMode {
            case true:
                changeHostModeLabel.text = "게스트모드로 전환"
            case false:
                changeHostModeLabel.text = "호스트모드로 전환"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAutolayout()
        configure()
        
        if chatRoomArray.count == 0 {
            startIndicatorView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.stopIndicator()
            }
        }
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
    
    private func setAutolayout() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(20)
            make.height.equalTo(40)
        }
        
        view.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(20)
            make.height.equalTo(35)
        }
        
        view.addSubview(indicatorLabel)
        indicatorLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-60)
            //            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(statusLabel.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(noDataMessageLabel)
        noDataMessageLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(tableView)
            make.centerY.equalTo(indicatorLabel.snp.centerY)
        }
        
        view.addSubview(changeHostModeLabel)
        changeHostModeLabel.snp.makeConstraints { (make) in
//            make.bottom.equalTo(tableView.snp.top).offset(-5)
            make.bottom.equalTo(statusLabel.snp.bottom).offset(3)
            make.trailing.equalTo(-20)
            make.height.equalTo(40)
        }
        
        view.addSubview(changeHostModeIcon)
        changeHostModeIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(changeHostModeLabel.snp.centerY)
            make.trailing.equalTo(changeHostModeLabel.snp.leading).offset(-5)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        
        view.addSubview(indicator)
        indicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(indicatorLabel.snp.top).offset(-15)
            make.width.height.equalTo(38)
        }
        
        view.bringSubviewToFront(noDataMessageLabel)
    }
    
    private func configure() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
//        indicatorLabel.isUserInteractionEnabled = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 800, bottom: 0, right: -800)
        
        statusLabel.isHidden = false
        
        noDataMessageLabel.text = "메세지방이 없습니다."
        noDataMessageLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        noDataMessageLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        noDataMessageLabel.isHidden = true
        
        changeHostModeIcon.setImage(UIImage(named: "changeCycleIcon"), for: .normal)
        changeHostModeIcon.imageView?.contentMode = .scaleAspectFit
//        changeHostModeIcon.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 60)
        changeHostModeIcon.addTarget(self, action: #selector(changeHostModeBtnDidTap), for: .touchUpInside)
        
        changeHostModeLabel.text = "호스트모드로 전환"
        changeHostModeLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        changeHostModeLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        changeHostModeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeHostModeBtnDidTap)))
        changeHostModeLabel.isUserInteractionEnabled = true
    }
    
    @objc private func changeHostModeBtnDidTap() {
        chatRoomArray.removeAll()
        tableView.reloadData()
        hostMode.toggle()
        
        UIView.animate(withDuration: 0.4) {
            self.changeHostModeIcon.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        UIView.animate(withDuration: 0.3, delay: 0.2, options: [], animations: {
            self.changeHostModeIcon.transform = CGAffineTransform.identity
        })
        
        startIndicatorView()
        
        // 눌러서 호스트모드가 됨 => 호스트 채팅을 가져와야함 / 눌러서 게스트모드가 됨 => 게스트 채팅을 가져와야함
        var urlString = netWork.basicUrlString + (hostMode ? "/chat/?user_type=host" : "/chat/")
       
        netWork.getServerDataWithToken(urlString: urlString) { (result) in
            switch result {
            case .success(let value):
                guard let data = try? JSONDecoder().decode([ChatRoom].self, from: value) else { print("‼️ : "); break }
                SingletonCommonData.shared.userChatRoomsArray = data
                self.chatRoomArray = data
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.stopIndicator()
                    self.tableView.reloadData()
                })
                
            case .failure(let error):
                print("‼️ hostMode Chat Data downlload error: ", error.localizedDescription)
                self.stopIndicator()
            }
        }
    }
    
    private func startIndicatorView() {
        noDataMessageLabel.isHidden = true
        indicator.type = .ballRotateChase
        indicator.color = StandardUIValue.shared.colorPink
        statusLabel.isHidden = true
        view.bringSubviewToFront(indicatorLabel)
        indicator.startAnimating()
        indicatorLabel.isHidden = false
    }
    
    private func stopIndicator() {
        statusLabel.isHidden = false
        view.sendSubviewToBack(indicatorLabel)
        indicator.stopAnimating()
        indicatorLabel.isHidden = true
        
        if chatRoomArray.count > 0 {
            // 데이터가 있을 시
            statusLabel.text = "메세지를 모두 읽으셨습니다."
            noDataMessageLabel.isHidden = true
        } else {
            // 데이터가 없을 시
            statusLabel.text = "새로운 여행을 시작해보세요."
            noDataMessageLabel.isHidden = false
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
//        msgListCell.chatRoomData = chatRoomArray[indexPath.row]
//        msgListCell.isHostMode = hostMode
        msgListCell.setData(chatRoomData: chatRoomArray[indexPath.row], isHost: hostMode)
        
        return msgListCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (indexPath.row == chatRoomArray.count-1) ? (cell.separatorInset = .init(top: 0, left: 800, bottom: 0, right: -800)) : ()
        print(indexPath.row)
        let msgListCell = tableView.dequeueReusableCell(withIdentifier: MsgListTableCell.identifier, for: indexPath) as! MsgListTableCell
        
//        msgListCell.msgPreviewLabel.text = msgListCell.chatRoomData?.messages.text ?? ""
//        msgListCell.timeLabel.text = msgListCell.getMessagesLastTime()
        
    }
}

// MARK: - UITableViewDelegate

extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoomVC = ChatRoomViewController()
        chatRoomVC.chatRoomData = self.chatRoomArray[indexPath.row]
        chatRoomVC.currentRoomIndex = indexPath.row
        chatRoomVC.amIHost = hostMode
        navigationController?.pushViewController(chatRoomVC, animated: true)
    }

    
}


