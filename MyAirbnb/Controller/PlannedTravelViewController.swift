//
//  PlannedTravelViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/07.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class PlannedTravelViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        tableView.register(PlannedTripTitleTableCell.self, forCellReuseIdentifier: PlannedTripTitleTableCell.identifier)
        tableView.register(PlannedHouseTableCell.self, forCellReuseIdentifier: PlannedHouseTableCell.identifier)
        
        return tableView
    }()
    
    let tableFooterView = UIView()
    
    let containerViewWhenNoTravel = UIView()
    
    var reservationArray = [Reservation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshReservationsData()
        setAutolayout()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reservationArray.removeAll()
        refreshReservationsData()
        tableView.reloadData()
//        print("🔴🔴🔴 reservationResultArray: ", reservationArray)
    }
    
    private func setAutolayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(containerViewWhenNoTravel)
        containerViewWhenNoTravel.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.tableFooterView = tableFooterView
        setTableFooterView()

//        containerViewWhenNoTravel.isHidden = false
        
        setContainerViewWhenNoTravel()
    }
    
    private func setContainerViewWhenNoTravel() {
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        let subtitleSecondLabel = UILabel()
        let button = UIButton()
        let imageView = UIImageView()
        let bottomLabel = UILabel()
        let bottomSecondLabel = UILabel()
        
        containerViewWhenNoTravel.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.top.equalTo(48)
        }
        
        containerViewWhenNoTravel.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
        
        containerViewWhenNoTravel.addSubview(subtitleSecondLabel)
        subtitleSecondLabel.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
        }
        
        containerViewWhenNoTravel.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.top.equalTo(subtitleSecondLabel.snp.bottom).offset(15)
            make.width.equalTo(140)
            make.height.equalTo(50)
        }
        
        containerViewWhenNoTravel.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(button.snp.bottom).offset(30)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        containerViewWhenNoTravel.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.top.equalTo(imageView.snp.bottom).offset(40)
        }
        
        containerViewWhenNoTravel.addSubview(bottomSecondLabel)
        bottomSecondLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(bottomLabel.snp.trailing).offset(5)
            make.top.equalTo(bottomLabel.snp.top)
        }
        
        titleLabel.text = "여행"
        titleLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        
        subtitleLabel.text = "예정된 여행 없음"
        subtitleLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        subtitleLabel.font = UIFont(name: "AirbnbCerealApp-Bold", size: 16)
        
        subtitleSecondLabel.text = "다음 여행을 계획해 보세요"
        subtitleSecondLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        subtitleSecondLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        button.layer.borderColor = StandardUIValue.shared.colorBlueGreen.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4
        button.setTitle("에어비앤비 둘러보기", for: .normal)
        button.setTitleColor(StandardUIValue.shared.colorBlueGreen, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        button.addTarget(self, action: #selector(seeAirbnbButtonDidTap), for: .touchUpInside)
        
        imageView.image = UIImage(named: "TravelDefaultImage")
        imageView.contentMode = .scaleAspectFit
        
        bottomLabel.text = "예약 내역을 찾으실 수 없나요?"
        bottomLabel.font = .systemFont(ofSize: 14, weight: .regular)
        bottomLabel.textColor = .black
        
        bottomSecondLabel.text = "도움말 센터 방문하기"
        bottomSecondLabel.textColor = StandardUIValue.shared.colorBlueGreen
        bottomSecondLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    private func setTableFooterView() {
        tableFooterView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80)
        
        let bottomLabel = UILabel()
        let bottomSecondLabel = UILabel()
        
        tableFooterView.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(30)
            make.top.equalToSuperview().offset(20)
        }
        
        tableFooterView.addSubview(bottomSecondLabel)
        bottomSecondLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(bottomLabel.snp.trailing).offset(5)
            make.top.equalTo(bottomLabel.snp.top)
        }
        
        bottomLabel.text = "예약 내역을 찾으실 수 없나요?"
        bottomLabel.font = .systemFont(ofSize: 14, weight: .regular)
        bottomLabel.textColor = .black
        
        bottomSecondLabel.text = "도움말 센터 방문하기"
        bottomSecondLabel.textColor = StandardUIValue.shared.colorBlueGreen
        bottomSecondLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    private func refreshReservationsData() {
        
        guard let reservationDictionary = SingletonCommonData.shared.userInfo?.reservations else { return }
        
        guard reservationDictionary.count > 0 else {
            //  데이터가 없을경우
            print("데이터 없음")
            tableView.isHidden = true
            containerViewWhenNoTravel.isHidden = false
            return
        }
        
        tableView.isHidden = false
        containerViewWhenNoTravel.isHidden = true
        
        for value in reservationDictionary {
            guard let reservation = value?.values.first else { continue }
            reservationArray.append(reservation)
        }
    }
    
    @objc private func seeAirbnbButtonDidTap() {
        if let tabbarVC = tabBarController {
            tabbarVC.selectedIndex = 0
            
            show(tabbarVC, sender: nil)
            
        }
    }
}


// MARK: - UITableViewDataSource
extension PlannedTravelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservationArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let plannedTripTitleCell = tableView.dequeueReusableCell(withIdentifier: PlannedTripTitleTableCell.identifier, for: indexPath) as! PlannedTripTitleTableCell
            let reservationCount = SingletonCommonData.shared.userInfo?.reservations.count ?? 0
            plannedTripTitleCell.noOfPlannedTrip.text = "예정된 여행 \(reservationCount)개"
            return plannedTripTitleCell
            
        default:
            guard reservationArray.count > 1 else {
                let plannedHouseCell = tableView.dequeueReusableCell(withIdentifier: PlannedHouseTableCell.identifier, for: indexPath) as! PlannedHouseTableCell
                plannedHouseCell.setData(firstHidden: true,
                                         secondHidden: true,
                                         reservation: reservationArray[indexPath.row - 1])
                return plannedHouseCell
            }
            
            let plannedHouseCell = tableView.dequeueReusableCell(withIdentifier: PlannedHouseTableCell.identifier, for: indexPath) as! PlannedHouseTableCell
            
            switch indexPath.row {
            case 1:
                plannedHouseCell.setData(firstHidden: true,
                                         secondHidden: false,
                                         reservation: reservationArray[indexPath.row - 1])
            case 2..<reservationArray.count:
                plannedHouseCell.setData(firstHidden: false,
                                         secondHidden: false,
                                         reservation: reservationArray[indexPath.row - 1])
            case reservationArray.count:
                plannedHouseCell.setData(firstHidden: false,
                                         secondHidden: true,
                                         reservation: reservationArray[indexPath.row - 1])
            default: break
                
            }
            
            
            
            return plannedHouseCell
        }
        
    }
}

// MARK: - UITableViewDelegate

extension PlannedTravelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let saveDetailVC = SaveDetailViewController()
        present(saveDetailVC, animated: true)
    }
}
