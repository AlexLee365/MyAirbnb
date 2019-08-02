//
//  ReserveStepTwoViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class ReserveStepTwoViewController: UIViewController {

    let topView: TableviewTopView = {
        let view = TableviewTopView()
        view.backgroundColor = .white
        view.backButton.setImage(UIImage(named: "backBlack"), for: .normal)
        view.shareButton.isHidden = true
        view.heartButton.isHidden = true
        
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        view.layer.shadowRadius = 0
        view.layer.shadowColor = UIColor.gray.cgColor
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.register(HostWelcomeMsgTableCell.self, forCellReuseIdentifier: HostWelcomeMsgTableCell.identifier)
        tableView.register(MsgToHostTableCell.self, forCellReuseIdentifier: MsgToHostTableCell.identifier)
        
        return tableView
    }()
    
    let bottomView: HouseBottomView = {
        let view = HouseBottomView()
        view.isDateSelected = true
        view.noOfReviewLabel.isHidden = true
        view.priceDetailBtn.isHidden = true
        view.starImageLabel.isHidden = true
        
        view.reserveBtn.setTitle(" 다음 ", for: .normal)
        view.reserveBtn.setTitleColor(.white, for: .normal)
        view.reserveBtn.backgroundColor = StandardUIValue.shared.colorBlueGreen
        
        view.priceLabel.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
        })
        view.reserveBtn.snp.makeConstraints({ (make) in
            make.width.equalTo(80)
        })
        
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let nextBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다음", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "AirbnbCerealApp-Medium", size: 15)
        return button
    }()
    
    let noti = NotificationCenter.default
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
        addNotificationObserver()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        topView.delegate = self
        view.addSubview(topView)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        panGestureRecognizer.delegate = self
        
        tableView.dataSource = self
        tableView.addGestureRecognizer(panGestureRecognizer)
        view.addSubview(tableView)
        
        bottomView.priceLabel.attributedText = attributedText(first: "₩162,007 ", second: "1박")
        bottomView.reserveBtn.addTarget(self, action: #selector(nextBtnDidTap(_:)), for: .touchUpInside)
        view.addSubview(bottomView)
        
        view.addSubview(containerView)
        
        nextBtn.addTarget(self, action: #selector(nextBtnDidTap(_:)), for: .touchUpInside)
        containerView.addSubview(nextBtn)
    }
    
    @objc private func nextBtnDidTap(_ sender: UIButton) {
        let stepThreeVC = ReserveStepThreeViewController()
        navigationController?.pushViewController(stepThreeVC, animated: true)
    }
    
    @objc private func hideKeyboard(_ sender: UIGestureRecognizer) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? MsgToHostTableCell
            else { return }
        cell.textView.resignFirstResponder()
    }
    
    private func setAutolayout() {
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        let height = UIScreen.main.bounds.height * 0.12
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(height)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(65)
            make.top.equalTo(view.snp.bottom).priority(500)
        }

        nextBtn.snp.makeConstraints { (make) in
            make.trailing.equalTo(-10)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
    }
    
    private func attributedText(first: String, second: String) -> NSAttributedString{
        let string = first + second as NSString
        let result = NSMutableAttributedString(string: string as String)
        let attributesForFirstWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Bold", size: 17) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        let attributesForSecondWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Book", size: 16) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        result.setAttributes(attributesForFirstWord, range: string.range(of: first))
        result.setAttributes(attributesForSecondWord, range: string.range(of: second))
        
        return NSAttributedString(attributedString: result)
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
        
        let downTFConst = containerView.topAnchor.constraint(equalTo: view.bottomAnchor)
        downTFConst.priority = .defaultLow
        downTFConst.isActive = true
        
        if keyboardFrame.minY >= view.frame.maxY {
            UIView.animate(withDuration: duration) {
                downTFConst.priority = .defaultHigh
                self.tableView.contentOffset.y -= (keyboardFrame.height - self.bottomView.frame.height)
            }
            self.view.layoutIfNeeded()
            
        } else {
            UIView.animate(withDuration: duration) {
                floatingTFConst.priority = .defaultHigh
                self.tableView.contentOffset.y += (keyboardFrame.height - self.bottomView.frame.height)
            }
            self.view.layoutIfNeeded()
        }
    }
}


// MARK: - UITableViewDataSource

extension ReserveStepTwoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let hostWelcomeMsgCell = tableView.dequeueReusableCell(withIdentifier: HostWelcomeMsgTableCell.identifier, for: indexPath) as! HostWelcomeMsgTableCell
            return hostWelcomeMsgCell
        case 1:
            let msgToHostCell = tableView.dequeueReusableCell(withIdentifier: MsgToHostTableCell.identifier, for: indexPath) as! MsgToHostTableCell
            return msgToHostCell
        default:
            return UITableViewCell()
        }
    }
    
    
}

// MARK: - UITableViewDelegate

extension ReserveStepTwoViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - TableviewTopViewDelegate

extension ReserveStepTwoViewController: TableviewTopViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
