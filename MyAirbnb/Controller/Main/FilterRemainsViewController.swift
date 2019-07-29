//
//  FilterRemainsViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 16/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

protocol FiltersDataTransferProtocol {
    func sendDataInstantBook(isOn: Bool)
    
}

class FilterRemainsViewController: UIViewController {
    
    let topView: TableviewTopView = {
        let view = TableviewTopView()
        view.backgroundColor = .white
        view.backButton.setImage(UIImage(named: "close"), for: .normal)
        view.shareButton.isHidden = true
        view.heartButton.isHidden = true
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        view.layer.shadowRadius = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "필터"
        titleLabel.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       
        return view
    }()

    let removeAllBtn: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.titleLabel?.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        button.setTitle(" 모두 지우기 ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let bottomView: BottomInfoView = {
        let view = BottomInfoView()
        view.backColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let showBtn: UIButton = {
        let button = UIButton()
        button.setTitle("300개 이상의 숙소 보기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.5, weight: .bold)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var checkBoxDatas = [CheckBoxData]()
    var checkBoxViewButtons = [[UIButton]]()
    let notiCenter = NotificationCenter.default
    var isDateSelected = false
    
    var offset: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutolayout()
        createCheckBoxDatas()
        addNotificationObserver()
    }
    
    
    private func configure() {
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InstantBookTableCell.self, forCellReuseIdentifier: InstantBookTableCell.identifier)
        tableView.register(QualifiedHouseTableCell.self, forCellReuseIdentifier: QualifiedHouseTableCell.identifier)
        tableView.register(PriceRangeTableCell.self, forCellReuseIdentifier: PriceRangeTableCell.identifier)
        tableView.register(HouseTypeTableCell.self, forCellReuseIdentifier: HouseTypeTableCell.identifier)
        tableView.register(BedFilterTableCell.self, forCellReuseIdentifier: BedFilterTableCell.identifier)
        tableView.register(CheckboxTableCell.self, forCellReuseIdentifier: "CheckboxTableCell0")
        tableView.register(CheckboxTableCell.self, forCellReuseIdentifier: "CheckboxTableCell1")
        tableView.register(CheckboxTableCell.self, forCellReuseIdentifier: "CheckboxTableCell2")
        tableView.register(CheckboxTableCell.self, forCellReuseIdentifier: "CheckboxTableCell3")
        tableView.register(CheckboxTableCell.self, forCellReuseIdentifier: "CheckboxTableCell4")
        
        view.addSubview(tableView)
        view.addSubview(topView)
        
        removeAllBtn.addTarget(self, action: #selector(removeAllBtnDidTap(_:)), for: .touchUpInside)
        topView.addSubview(removeAllBtn)
        
        view.addSubview(bottomView)
        bottomView.addSubview(showBtn)
    }
    
    @objc private func removeAllBtnDidTap(_ sender: UIButton) {
        
    }
    
    @objc private func showBtnDidTap() {
//        guard let mainVC = presentingViewController as? MainViewController else { return }
//
//
//        guard let cellA = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? BedFilterTableCell else { return }
//        let dataA = (cellA.bathroomCount , ,)
    }
    
    private func setAutolayout() {
        let guide = view.safeAreaLayoutGuide
        topView.delegate = self
        topView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
    
        removeAllBtn.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        removeAllBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        removeAllBtn.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.11).isActive = true
        
        showBtn.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        showBtn.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        showBtn.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.85).isActive = true
        showBtn.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.63).isActive = true
    }
    
    
    
    private func createCheckBoxDatas() {
        checkBoxDatas = [
            CheckBoxData(title: "편의시설",
                         contentArray: [Content(type: "주방", checkBoxState: false),
                                        Content(type: "샴푸", checkBoxState: false),
                                        Content(type: "난방", checkBoxState: false),
                                        Content(type: "에어컨", checkBoxState: false),
                                        Content(type: "세탁기", checkBoxState: false),
                                        Content(type: "건조기", checkBoxState: false),
                                        Content(type: "무선 인터넷", checkBoxState: false),
                                        Content(type: "아침식사", checkBoxState: false),
                                        Content(type: "실내 벽난로", checkBoxState: false),
                                        Content(type: "옷걸이", checkBoxState: false),
                                        Content(type: "다리미", checkBoxState: false),
                                        Content(type: "헤어드라이어", checkBoxState: false),
                                        Content(type: "노트북 작업 공간", checkBoxState: false),
                                        Content(type: "TV", checkBoxState: false),
                                        Content(type: "아기침대", checkBoxState: false)],
                         buttonTitle: "편의시설 모두 보기", seeAllBtnState: false),
            
            CheckBoxData(title: "시설",
                         contentArray: [Content(type: "건물 내 무료 주차", checkBoxState: false),
                                        Content(type: "헬스장", checkBoxState: false),
                                        Content(type: "자쿠지", checkBoxState: false),
                                        Content(type: "수영장", checkBoxState: false)],
                         buttonTitle: "시설 모두 보기", seeAllBtnState: false),
            
            CheckBoxData(title: "건물 유형",
                         contentArray: [Content(type: "주택", checkBoxState: false),
                                        Content(type: "아파트", checkBoxState: false),
                                        Content(type: "B&B", checkBoxState: false),
                                        Content(type: "부티크 호텔", checkBoxState: false),
                                        Content(type: "게스트 스위트", checkBoxState: false),
                                        Content(type: "게스트용 별채", checkBoxState: false),
                                        Content(type: "로프트", checkBoxState: false)],
                         buttonTitle: "건물 유형 모두 보기", seeAllBtnState: false),
            
            CheckBoxData(title: "특색 있는 숙소",
                         contentArray: [Content(type: "기차", checkBoxState: false),
                                        Content(type: "농장 체험 숙박", checkBoxState: false),
                                        Content(type: "담무소(이탈리아)", checkBoxState: false),
                                        Content(type: "돔하우스", checkBoxState: false),
                                        Content(type: "동굴", checkBoxState: false),
                                        Content(type: "등대", checkBoxState: false)],
                         buttonTitle: "특색 있는 숙소 모두 보기", seeAllBtnState: false),
            
            CheckBoxData(title: "숙소 이용규칙",
                         contentArray: [Content(type: "이벤트/행사 가능", checkBoxState: false),
                                        Content(type: "반려동물 입실 가능", checkBoxState: false),
                                        Content(type: "흡연 가능", checkBoxState: false)],
                         buttonTitle: nil, seeAllBtnState: false)
        ]

    }
    
    
}


// MARK: - UITableViewDataSource
extension FilterRemainsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("🔴🔴🔴 : ", "tableview indexPath: ", indexPath.row)
        
        switch indexPath.row {
        case 0:
            let instantBookCell = tableView.dequeueReusableCell(withIdentifier: InstantBookTableCell.identifier, for: indexPath) as! InstantBookTableCell
            return instantBookCell
            
        case 1:
            let qualifiedHouseCell = tableView.dequeueReusableCell(withIdentifier: QualifiedHouseTableCell.identifier, for: indexPath) as! QualifiedHouseTableCell
            return qualifiedHouseCell
            
        case 2:
            let priceRangeCell = tableView.dequeueReusableCell(withIdentifier: PriceRangeTableCell.identifier, for: indexPath) as! PriceRangeTableCell
            priceRangeCell.isDateSelected = self.isDateSelected
            return priceRangeCell
            
        case 3:
            let houseTypeCell = tableView.dequeueReusableCell(withIdentifier: HouseTypeTableCell.identifier, for: indexPath) as! HouseTypeTableCell
            return houseTypeCell
        case 4:
            let bedCell = tableView.dequeueReusableCell(withIdentifier: BedFilterTableCell.identifier, for: indexPath) as! BedFilterTableCell
            return bedCell

        case 5...9:
            let checkBoxCell = tableView.dequeueReusableCell(withIdentifier: "CheckboxTableCell\(indexPath.row-5)", for: indexPath) as! CheckboxTableCell
            checkBoxCell.setData(inputData: checkBoxDatas[indexPath.row-5])
            checkBoxCell.currentIndex = indexPath.row-5
            
            indexPath.row == 9 ? checkBoxCell.hideSeparator() : ()
            return checkBoxCell
            
        default:
            return UITableViewCell()
        }
    }
    
    
}

// MARK: - TableviewTopViewDelegate

extension FilterRemainsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       offset = tableView.contentOffset.y
    }
}

extension FilterRemainsViewController: TableviewTopViewDelegate {
    func popView() {
        dismiss(animated: true, completion: nil)
    }
}




// Notification
extension FilterRemainsViewController {
    private func addNotificationObserver() {
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .instantBookSwitchTapped, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .houseGradeSwitchTapped, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .priceSliderDidChanged, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotiHouseType(_:)), name: .houseTypeSwitchTapped, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotiBedrooms(_:)), name: .bedroomsCountChanged, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotiFacilitiesInside(_:)), name: .facilitiesInsideChecked, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotiFacilitiesInside(_:)), name: .facilitiesInsideSeeMoreBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotiFacilitiesOutside(_:)), name: .facilitiesOutsideChecked, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotiFacilitiesOutside(_:)), name: .facilitiesOutsideSeeMoreBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receivecNotiBuildingType(_:)), name: .buildingTypeChecked, object: nil)
        notiCenter.addObserver(self, selector: #selector(receivecNotiBuildingType(_:)), name: .buildingTypeSeeMoreBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotiUniqueHouse(_:)), name: .uniqueHouseChecked, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotiUniqueHouse(_:)), name: .uniqueHouseSeeMoreBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotiUseRules), name: .useRulesChecked, object: nil)
    }
    
    @objc func receiveNotification(_ sender: Notification) {
        switch sender.name {
        case Notification.Name.instantBookSwitchTapped:
            print("noti instant")
            guard let switching = sender.object as? UISwitch else { return }
            print(switching.isOn)
            
        case Notification.Name.houseGradeSwitchTapped:
            print("noti housegrade")
            guard let switching = sender.object as? UISwitch else { return }
            print(switching.tag)
            print(switching.isOn)
            
        case Notification.Name.priceSliderDidChanged:
            print("noti priceslider")
            
            
        default: break
        }
    }
    
    @objc func receiveNotiHouseType(_ sender: Notification) {
        print("noti housetype")
        guard let button = sender.object as? UIButton else { return }
        print(button.tag)
        print(button.isSelected)
    }
    
    @objc func receiveNotiBedrooms(_ sender: Notification) {
        print("noti bedrooms")
        guard let userInfo = sender.userInfo
            , let count = userInfo["count"] as? (Int, Int, Int)
            else { return }
        print(count)
    }
    
    @objc func receiveNotiFacilitiesInside(_ sender: Notification) {
        print("noti facility inside")
        guard let button = sender.object as? UIButton
            , let userInfo = sender.userInfo
            , let index = userInfo["index"] as? Int
            else { return }
        
        
        
        guard button.tag != 99 else {
            checkBoxDatas[index].seeAllBtnState.toggle()
            let checkBoxCell = tableView.cellForRow(at: IndexPath(row: index+5, section: 0)) as! CheckboxTableCell
            checkBoxCell.setDataOnce = false
//            tableView.reloadData()
            tableView.reloadRows(at: [IndexPath(row: index+5, section: 0)], with: .fade)
            tableView.scrollToRow(at: IndexPath(row: index+5, section: 0), at: .top, animated: true)
            return
        }
        checkBoxDatas[index].contentArray[button.tag].checkBoxState = button.isSelected
        print(button.isSelected)
    }
    
    @objc func receiveNotiFacilitiesOutside(_ sender: Notification) {
        print("noti facility outside")
        
    }
    
    @objc func receivecNotiBuildingType(_ sender: Notification) {
        print("noti building type}")
        
    }
    
    @objc func receiveNotiUniqueHouse(_ sender: Notification) {
        print("noti uniqueHouse")
    }
    
    @objc func receiveNotiUseRules(_ sender: Notification) {
        print("noti useRules")
    }
}
