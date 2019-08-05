//
//  ChatRoomViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 24/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import Starscream

class ChatRoomViewController: UIViewController {
    
    // MARK: - UI Properties
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
    
    let chatTableHeaderView = UIView()
    let chatTableSpaceView = UIView()
    let chatTableHeaderLabel = UILabel()
    let chatTableView = UITableView()
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let chatTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 15)
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
    
    let seperateLineBottomView = UIView()
    let placeholderLabel = UILabel()
    
    // MARK: - Properteis
    var floatingTFConst: NSLayoutConstraint?
    var downTFConst: NSLayoutConstraint?
    
    let netWork = NetworkCommunicator()
    let dateformatter = DateFormatter()
    
    let noti = NotificationCenter.default
    var socket: WebSocket!
    
    var chatRoomData: ChatRoom?
    var currentRoomIndex = 0
    
    var messageArray = [(String, Bool, String)]()     // 채팅Text, 호스트인지여부, 작성날짜
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewHeaderView()
        setAutolayout()
        configureViewsOptions()
        setNavigationBar()
        addNotificationObserver()
        
        setChatContents {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: {
                    self.chatTableView.scrollToRow(at: IndexPath(row: self.messageArray.count - 1, section: 0), at: .bottom, animated: false)                    
                })
            }
        }
        configureNetwork()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = UIColor.clear
        
        tabBarController?.tabBar.isHidden = true
        
        print("🔵🔵🔵 chatData: ", chatRoomData)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        guard messageArray.count > 0 else { return }
//        chatTableView.scrollToRow(at: IndexPath(row: messageArray.count - 1, section: 0), at: .bottom, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.floatingTFConst?.priority = .defaultHigh
        self.downTFConst?.priority = .defaultLow
        self.view.layoutIfNeeded()
    }
    
    private func setAutolayout() {
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.09)
        }
        
        topView.addSubview(msgTypeLabel)
        msgTypeLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
        }
        
        topView.addSubview(detailBtn)
        detailBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-20)
        }
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(65)
            //            make.bottom.equalTo(bottomView.snp.top).priority(500)
            make.bottom.equalTo(view.safeAreaLayoutGuide).priority(500)
        }
        
        containerView.addSubview(sendBtn)
        sendBtn.snp.makeConstraints { (make) in
            make.trailing.equalTo(-7)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        
        containerView.addSubview(chatTextView)
        chatTextView.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.top.equalTo(2)
            make.bottom.equalTo(-13)
            make.trailing.equalTo(sendBtn.snp.leading).offset(-20)
        }
        
        containerView.addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(chatTextView.snp.leading).offset(8)
            make.top.equalTo(chatTextView.snp.top).offset(8)
        }
        
        containerView.addSubview(seperateLineBottomView)
        seperateLineBottomView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        view.addSubview(chatTableView)
        chatTableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(containerView.snp.top)
        }
    }
    
    
    
    private func configureViewsOptions() {
        view.backgroundColor = .white
        title = chatRoomData?.room.host.username ?? ""
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: ChatTableViewCell.identifier)
        chatTableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.separatorStyle = .none
        chatTableView.allowsSelection = false
        chatTableView.tableHeaderView = chatTableHeaderView
        
        chatTextView.delegate = self
        
        placeholderLabel.text = "메시지 작성"
        placeholderLabel.font = .systemFont(ofSize: 15, weight: .regular)
        placeholderLabel.textColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        
        sendBtn.isEnabled = false
        sendBtn.alpha = 0.3
        sendBtn.addTarget(self, action: #selector(sendBtnDidTap(_:)), for: .touchUpInside)
        
        seperateLineBottomView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }
    
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
    
    private func setTableViewHeaderView() {
        
        let width = UIScreen.main.bounds.width * 0.8
        let spaceHeight = UIScreen.main.bounds.height * 0.65
        chatTableHeaderView.frame = CGRect(x: 0, y: 0, width: width, height: spaceHeight)
        chatTableHeaderView.addSubview(chatTableSpaceView)
        chatTableSpaceView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
        }
        
        chatTableHeaderView.addSubview(chatTableHeaderLabel)
        chatTableHeaderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(chatTableSpaceView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        guard let chatData = chatRoomData else { print("‼️ : "); return }
        
        let components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
//        let componentsMonthDay = Calendar.current.dateComponents([.month, .day], from: chatData.star)
        let peopleNumber = 1
        chatTableHeaderLabel.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 13)
        chatTableHeaderLabel.setLineSpacing(lineSpacing: 8.0, lineHeightMultiple: 2)
        //        chatTableHeaderLabel.font = .systemFont(ofSize: 13, weight: .regular)
        chatTableHeaderLabel.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        chatTableHeaderLabel.textAlignment = .center
        chatTableHeaderLabel.numberOfLines = 0
        chatTableHeaderLabel.text = """
        호스트는 예약이 확정된 후에만 프로필 사진을 볼 수 있습니다.
        \n안전한 결제를 위해 에어비앤비 웹사이트나 앱을 통해 대화를
        나누고 결제하세요.
        \(components.year ?? 0)년 \(components.month ?? 0)월 \(components.day ?? 0)일
        \n예약 문의
        게스트 \(peopleNumber)명 ・ \(chatData.startDate) ~ \(chatData.endDate)
        """
    }
    
    private func addNotificationObserver() {
        noti.addObserver(self, selector: #selector(didReceiveKeyboardNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        noti.addObserver(self, selector: #selector(didReceiveKeyboardNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setChatContents(completion: @escaping () -> ()) {
        let urlString = netWork.basicUrlString + "/chat/\(chatRoomData?.id ?? 0)"
        netWork.getServerDataWithToken(urlString: urlString) { (result) in
            switch result {
            case .success(let value):
                guard let roomData = try? JSONDecoder().decode(ChatRoomDetailData.self, from: value) else { print("‼️ chatRoomDetailData convert "); break}
                
                for message in roomData.messages {
                    self.dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    guard let date = self.dateformatter.date(from: message.created) else { print("‼️ dateformmater error "); return }
                    let components = Calendar.current.dateComponents([.month, .day], from: date)

                    self.messageArray.append((message.text, message.isHost, "\(components.month ?? 0)월 \(components.day ?? 0)일"))
                }
                DispatchQueue.main.async {
                    self.chatTableView.reloadData()
                }
                
                completion()
            case .failure(let error):
                print("‼️ : ", error.localizedDescription)
                completion()
                break
            }
        }
    }
    
    private func configureNetwork() {
        print("--------------------------[Configure Network]--------------------------")
        print("userToekn: ", netWork.userToken)
        print("chatRoom ID: ", chatRoomData?.id ?? 0)
        
        let urlString = "ws://airbnb.tthae.com/ws/chat/\(chatRoomData?.id ?? 0)/?token=\(netWork.userToken)"
        guard let url = URL(string: urlString) else { print("‼️ Network url error ");  return }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    @objc private func sendBtnDidTap(_ sender: UIButton) {
        let messageDictionary = ["message": chatTextView.text]
        
        if let json = try? JSONSerialization.data(withJSONObject: messageDictionary, options: []) {
            if let content = String.init(data: json, encoding: .utf8) {
                print("Message content: ", content)
                socket.write(string: content)
            }
        } else {
            print("‼️ message json data convert error ")
        }
        
        chatTextView.text = ""
        configureWithNoText()
    }
    
    var setConstraintOnce = false
    var offsetValueWhenTableViewContentUp: CGFloat = 0
    @objc private func didReceiveKeyboardNotification(_ sender: Notification) {
        guard let userInfo = sender.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }
        
        if setConstraintOnce == false {
            floatingTFConst = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -keyboardFrame.height)
            floatingTFConst?.priority = .defaultLow
            floatingTFConst?.isActive = true
            
            downTFConst = containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            downTFConst?.priority = .defaultLow
            downTFConst?.isActive = true
            setConstraintOnce = true
            
            offsetValueWhenTableViewContentUp = keyboardFrame.height - containerView.frame.height
            print("🔴🔴🔴 : ", offsetValueWhenTableViewContentUp)
        }
        
        if keyboardFrame.minY >= view.frame.maxY {
            //키보드가 올라가있을때 => 내려감
            UIView.animate(withDuration: duration) {
                self.downTFConst?.priority = .defaultHigh
                self.floatingTFConst?.priority = .defaultLow
            }
            self.view.layoutIfNeeded()
            
            //            if chatTableView.contentSize.height >= chatTableView.frame.height {
            //                self.chatTableView.contentOffset.y -= offsetValueWhenTableViewContentUp
            //            }
            
        } else {
            // 키보드가 내려가있을때 => 올라감
            UIView.animate(withDuration: duration) {
                self.floatingTFConst?.priority = .defaultHigh
                self.downTFConst?.priority = .defaultLow
            }
            self.view.layoutIfNeeded()
            
            if chatTableView.contentSize.height >= chatTableView.frame.height {
                
                //                guard let lastIndexPath = chatTableView.indexPathsForVisibleRows?.last else { return }
                guard messageArray.count > 0 else {
                    self.chatTableView.contentOffset.y += offsetValueWhenTableViewContentUp
                    return
                }
                chatTableView.scrollToRow(at: IndexPath(row: messageArray.count - 1, section: 0), at: .bottom, animated: false)
            }
        }
    }
    
    @objc private func hideKeyboard(_ sender: Any) {
        chatTextView.resignFirstResponder()
    }
    
    @objc private func backToPreviousView() {
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: - UITableViewDataSource
extension ChatRoomViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatCell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as! ChatTableViewCell
        //        chatCell.messageTextView.text = messageArray[indexPath.row]
        
        let messageType: ChatTableViewCell.MessageType = messageArray[indexPath.row].1 ? .hosts : .mine
        chatCell.setMessageType(sender: messageType, hostName: "Host A")
        
        chatCell.messageTextView.text = messageArray[indexPath.row].0
        chatCell.hostImageView.image = UIImage(named: "hostSample2")
        chatCell.myImageView.image = UIImage(named: "hostSample3")
        
        return chatCell
    }
}


// MARK: - UITextViewDelegate
extension ChatRoomViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textViewText = textView.text ?? ""
        let replacedText = (textViewText as NSString).replacingCharacters(in: range, with: text)
        
        print("--------------------------[]--------------------------")
        print(replacedText)
        print(text)
        print(textView.text)
        
        
        (replacedText == "" && textView.text == "") ? configureWithNoText() : configureWithText()
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        (textView.text == "") ? configureWithNoText() : ()
    }
}

extension ChatRoomViewController {
    private func configureWithNoText() {
        sendBtn.isEnabled = false
        sendBtn.alpha = 0.5
        
        UIView.animate(withDuration: 0.3) {
            self.placeholderLabel.alpha = 1
        }
    }
    
    private func configureWithText() {
        sendBtn.isEnabled = true
        sendBtn.alpha = 1
        
        UIView.animate(withDuration: 0.3) {
            self.placeholderLabel.alpha = 0
        }
    }
}

extension ChatRoomViewController: WebSocketDelegate, WebSocketPongDelegate {
    func websocketDidReceivePong(socket: WebSocketClient, data: Data?) {
        print("🔵🔵🔵 : ", data)
    }
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("--------------------------[⭐️ WebSocket Did Connect Success]--------------------------")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("--------------------------[‼️ WebSocket Did Disconnect ]--------------------------")
        print(error?.localizedDescription)
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("Received Message: ", text)
        
        guard let stringData = text.data(using: .utf8)
            , let jsonObject = try? JSONSerialization.jsonObject(with: stringData) else {
                print("‼️ StringData & JsonObject convert error ")
                return
        }
        
        guard let json = jsonObject as? [String: Any]
            , let isHost = json["is_host"] as? Bool
            , let message = json["text"] as? String
            , let writeDate = json["created"] as? String else {
                print("‼️ Json key value error ")
                return
        }
        
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateformatter.date(from: writeDate) else { print("‼️ dateformmater error "); return }
        let components = Calendar.current.dateComponents([.month, .day], from: date)
        messageArray.append((message, isHost, "\(components.month ?? 0)월 \(components.day ?? 0)일"))
        chatTableView.reloadData()
        
        
        self.chatTableView.scrollToRow(at: IndexPath(row: self.messageArray.count - 1, section: 0), at: .bottom, animated: false)
        
        
        
//        let jsonDecoder = JSONDecoder()
//        let urlString = netWork.basicUrlString + "/chat/\(chatRoomData?.id ?? 0)/"
//        netWork.getServerDataWithToken(urlString: urlString) { (result) in
//            switch result {
//            case .success(let value):
//                guard let chatServerData = try? jsonDecoder.decode(ChatRoom.self, from: value) else { print("‼️ chatServerData convert error "); return }
//
//                guard let MessageVC = self.navigationController?.viewControllers.first as? MessageViewController else { print("‼️ MessageVC convert error "); return }
//
//                MessageVC.chatRoomArray[self.currentRoomIndex] = chatServerData
//
//                print("🔸🔸🔸 chatServerData download and apply success ")
//            case .failure(let error):
//                print("‼️ error: ", error.localizedDescription);
//            }
//        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Received Data: ", data)
    }
}
