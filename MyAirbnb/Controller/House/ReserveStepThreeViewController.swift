//
//  ReserveStepThreeViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class ReserveStepThreeViewController: UIViewController {
    
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
        
        tableView.register(StepThreeTitleTableCell.self, forCellReuseIdentifier: StepThreeTitleTableCell.identifier)
        tableView.register(AddPaymentTableCell.self, forCellReuseIdentifier: AddPaymentTableCell.identifier)
        tableView.register(PriceOverviewTableCell.self, forCellReuseIdentifier: PriceOverviewTableCell.identifier)
        tableView.register(CouponTableCell.self, forCellReuseIdentifier: CouponTableCell.identifier)
        tableView.register(RefundPolicyTableCell.self, forCellReuseIdentifier: RefundPolicyTableCell.identifier)
        tableView.register(AgreementTableCell.self, forCellReuseIdentifier: AgreementTableCell.identifier)
        
        return tableView
    }()
    
    let separateLineView = UIView()
    let bottomPayView = UIView()
    let payBtn = UIButton()
    
    var houseDetailData: HouseDetailData?
    var selectedFilterInfo = ([Date](), 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutolayout()
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        topView.delegate = self
        view.addSubview(topView)
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        separateLineView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        bottomPayView.backgroundColor = .white
        
        payBtn.setTitle("결제하기", for: .normal)
        payBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        payBtn.setTitleColor(.white, for: .normal)
        payBtn.backgroundColor = StandardUIValue.shared.colorPink
        payBtn.layer.cornerRadius = 5
        payBtn.layer.masksToBounds = true
        payBtn.addTarget(self, action: #selector(payBtnDidTap), for: .touchUpInside)
    }
    
    private func setAutolayout() {
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        view.addSubview(bottomPayView)
        bottomPayView.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        
        bottomPayView.addSubview(payBtn)
        payBtn.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview().multipliedBy(0.8)
            make.centerY.centerX.equalToSuperview()
        }
        
        view.addSubview(separateLineView)
        separateLineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(bottomPayView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(separateLineView.snp.top)
        }
    }
    
    @objc private func payBtnDidTap() {
        makeReservation { (result) in
            switch result {
            case .success(let value):
                print("🔵🔵🔵 Success!! / data: ", value)
                DispatchQueue.main.async {
                    let reservationCompleteVC = HouseReservationCompleteViewController()
                    self.navigationController?.pushViewController(reservationCompleteVC, animated: false)

                }
            case .failure(let error):
                print("‼️ : ", error.localizedDescription)
                DispatchQueue.main.async {
                    self.makeAlert(title: "Message", message: "결제에 실패하였습니다.\n다시 시도해주세요.") {}
                }
            }
        }
    }
    
    private func makeReservation(completion: @escaping (Result<Any?, NSError>) -> ()) {
        print("--------------------------[Make Reservation POST]--------------------------")
//        let userIDNumber = UserDefaults.standard.integer(forKey: SingletonCommonData.userDefaultIDNumber)
        let userToken = UserDefaults.standard.string(forKey: SingletonCommonData.userDefaultTokenKey) ?? ""
        let roomNumber = houseDetailData?.id ?? 0
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let firstDate = dateformatter.string(from: selectedFilterInfo.0.first ?? Date())
        let lastDate = dateformatter.string(from: selectedFilterInfo.0.last ?? Date())
        let message = "Hello"
        
        let postDictionary = ["start_date": firstDate, "end_date": lastDate, "message": message]
        
        guard let url = URL(string: "http://airbnb.tthae.com/api/rooms/\(roomNumber)") else {
            print("‼️ makeReservation URL convert ")
            completion(.failure(NSError()))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Token \(userToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postDictionary)
        } catch let error {
            print(error.localizedDescription)
            completion(.failure(NSError()))
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print("‼️ post UrlSession error "); return }
            guard let data = data
                , let jsonObject = try? JSONSerialization.jsonObject(with: data) else {
                    print("‼️ data, json convert error ")
                    completion(.failure(NSError()))
                    return
            }
            
            completion(.success(jsonObject))
            }.resume()
        
    }
    
    private func makeAlert(title: String, message: String, completion: @escaping () -> () ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        }
        
        alert.addAction(action1)
        present(alert, animated: true)
    }
}


// MARK: - UITableViewDataSource

extension ReserveStepThreeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let houseData = houseDetailData else { print("‼️ : "); return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            let stepThreeTitleCell = tableView.dequeueReusableCell(withIdentifier: StepThreeTitleTableCell.identifier, for: indexPath) as! StepThreeTitleTableCell
            stepThreeTitleCell.setData(houseData: houseData, selecteData: selectedFilterInfo)
            return stepThreeTitleCell
        case 1:
            let addPaymentCell = tableView.dequeueReusableCell(withIdentifier: AddPaymentTableCell.identifier, for: indexPath) as! AddPaymentTableCell
            addPaymentCell.delegate = self
            return addPaymentCell
        case 2:
            let priceOverviewCell = tableView.dequeueReusableCell(withIdentifier: PriceOverviewTableCell.identifier, for: indexPath) as! PriceOverviewTableCell
            priceOverviewCell.setData(oneDayPrice: houseData.price, stayDays: selectedFilterInfo.0.count - 1)
            return priceOverviewCell
        case 3:
            let couponCell = tableView.dequeueReusableCell(withIdentifier: CouponTableCell.identifier, for: indexPath) as! CouponTableCell
            couponCell.delegate = self
            return couponCell
        case 4:
            let refundPolicyCell = tableView.dequeueReusableCell(withIdentifier: RefundPolicyTableCell.identifier, for: indexPath) as! RefundPolicyTableCell
            return refundPolicyCell
        case 5:
            let agreementCell = tableView.dequeueReusableCell(withIdentifier: AgreementTableCell.identifier, for: indexPath) as! AgreementTableCell
            return agreementCell
        default:
            return UITableViewCell()
        }
    }
    
    
}

// MARK: - UITableViewDelegate

extension ReserveStepThreeViewController: UITableViewDelegate {
}

// MARK: - TableviewTopViewDelegate

extension ReserveStepThreeViewController: TableviewTopViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - AddPaymentTableCellDelegate

extension ReserveStepThreeViewController: AddPaymentTableCellDelegate {
    func presentSelectPayVC() {
        let selectPayVC = SelectPayMethodViewController()
        let navi = UINavigationController(rootViewController: selectPayVC)
        present(navi, animated: true)
    }
}

// MARK: - CouponTableCellDelegate

extension ReserveStepThreeViewController: CouponTableCellDelegate {
    func presentCouponVC() {
        let addCouponVC = CouponApplyViewController()
        present(addCouponVC, animated: true)
    }
}
