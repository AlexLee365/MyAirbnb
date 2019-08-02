//
//  CouponApplyViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class CouponApplyViewController: UIViewController {

    let topView: TableviewTopView = {
        let view = TableviewTopView()
        view.backgroundColor = .clear
        view.backButton.setImage(UIImage(named: "close"), for: .normal)
        view.shareButton.isHidden = true
        view.heartButton.isHidden = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "쿠폰 추가"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 27)
        label.textColor = .white
        return label
    }()
    
    let couponCodeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "쿠폰 코드"
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 12)
        label.textColor = .white
        return label
    }()
    
    let codeTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "나의 코드"
        tf.font = UIFont(name: "AirbnbCerealApp-Medium", size: 18)
        tf.textColor = .white
        return tf
    }()
    
    let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1).withAlphaComponent(0.7)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        codeTF.becomeFirstResponder()
    }
    
    private func configure() {
        view.backgroundColor = .init(patternImage: UIImage.init(named: "AirBnB-background")!)
        
//        view.backgroundColor = .white
        
        topView.delegate = self
        view.addSubview(topView)
        
        view.addSubview(titleLabel)
        view.addSubview(couponCodeTitleLabel)
        
        codeTF.delegate = self
        view.addSubview(codeTF)
        view.addSubview(separatorLineView)
    }
    
    private func setAutolayout() {
        topView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
        
        couponCodeTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalTo(20)
        }

        codeTF.snp.makeConstraints { (make) in
            make.top.equalTo(couponCodeTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }

        separatorLineView.snp.makeConstraints { (make) in
            make.top.equalTo(codeTF.snp.bottom).offset(5)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(0.4)
        }
    }
}


extension CouponApplyViewController: UITextFieldDelegate {
    
}

extension CouponApplyViewController: TableviewTopViewDelegate {
    func popView() {
        dismiss(animated: true, completion: nil)
    }
}
