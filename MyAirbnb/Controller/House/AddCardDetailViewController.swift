//
//  AddCardDetailViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class AddCardDetailViewController: UIViewController {

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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "카드 세부정보를 입력하세요"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 27)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let cardNoTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "카드 번호"
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 16)
        return label
    }()
    
    let creditCardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "creditCard")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let cardNoTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "0000 0000 0000 0000"
        tf.keyboardType = UIKeyboardType.numberPad
        tf.font = UIFont(name: "AirbnbCerealApp-Medium", size: 18)
        tf.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return tf
    }()
    
    let separatorLineView1: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1).withAlphaComponent(0.5)
        return view
    }()
    
    let expiredTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "유효기간"
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 16)
        return label
    }()
    
    let expiredTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "MM/YY"
        tf.keyboardType = UIKeyboardType.numberPad
        tf.font = UIFont(name: "AirbnbCerealApp-Medium", size: 18)
        tf.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return tf
    }()
    
    let separatorLineView2: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1).withAlphaComponent(0.5)
        return view
    }()
    
    let cvvTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "CVV"
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 16)
        return label
    }()
    
    let cvvTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "123"
        tf.keyboardType = UIKeyboardType.numberPad
        tf.font = UIFont(name: "AirbnbCerealApp-Medium", size: 18)
        tf.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return tf
    }()
    
    let separatorLineView3: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1).withAlphaComponent(0.5)
        return view
    }()
    
    let postCodeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "우편번호"
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 16)
        return label
    }()
    
    let postCodeTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "12345"
        tf.keyboardType = UIKeyboardType.numberPad
        tf.font = UIFont(name: "AirbnbCerealApp-Medium", size: 18)
        tf.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return tf
    }()
    
    let separatorLineView4: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1).withAlphaComponent(0.5)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        topView.delegate = self
        view.addSubview(topView)
        
        view.addSubview(titleLabel)
        view.addSubview(cardNoTitleLabel)
        view.addSubview(creditCardImage)
        view.addSubview(cardNoTF)
        view.addSubview(separatorLineView1)
        
        view.addSubview(expiredTitleLabel)
        view.addSubview(expiredTF)
        view.addSubview(separatorLineView2)
        
        view.addSubview(cvvTitleLabel)
        view.addSubview(cvvTF)
        view.addSubview(separatorLineView3)
        
        view.addSubview(postCodeTitleLabel)
        view.addSubview(postCodeTF)
        view.addSubview(separatorLineView4)
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
        
        cardNoTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalTo(20)
        }
        
        creditCardImage.snp.makeConstraints { (make) in
            make.top.equalTo(cardNoTitleLabel.snp.bottom).offset(15)
            make.leading.equalTo(20)
            make.width.equalTo(40)
            make.height.equalTo(25)
        }
        
        cardNoTF.snp.makeConstraints { (make) in
            make.top.equalTo(cardNoTitleLabel.snp.bottom).offset(15)
            make.leading.equalTo(creditCardImage.snp.trailing).offset(15)
        }

        separatorLineView1.snp.makeConstraints { (make) in
            make.top.equalTo(creditCardImage.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(0.35)
        }
        
        let separatorLineWidth = (UIScreen.main.bounds.width - 40) / 3 - 10
        
        expiredTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLineView1.snp.bottom).offset(25)
            make.leading.equalTo(20)
        }
        
        expiredTF.snp.makeConstraints { (make) in
            make.top.equalTo(expiredTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
        
        separatorLineView2.snp.makeConstraints { (make) in
            make.top.equalTo(expiredTF.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.height.equalTo(0.35)
            make.width.equalTo(separatorLineWidth)
        }
        
        cvvTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLineView1.snp.bottom).offset(25)
            make.leading.equalTo(separatorLineView2.snp.trailing).offset(10)
        }
        
        cvvTF.snp.makeConstraints { (make) in
            make.top.equalTo(cvvTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(cvvTitleLabel.snp.leading)
        }
        
        separatorLineView3.snp.makeConstraints { (make) in
            make.top.equalTo(cvvTF.snp.bottom).offset(20)
            make.leading.equalTo(cvvTitleLabel.snp.leading)
            make.height.equalTo(0.35)
            make.width.equalTo(separatorLineWidth)
        }
        
        postCodeTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLineView1.snp.bottom).offset(25)
            make.leading.equalTo(separatorLineView3.snp.trailing).offset(10)
        }
        
        postCodeTF.snp.makeConstraints { (make) in
            make.top.equalTo(postCodeTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(postCodeTitleLabel.snp.leading)
        }
        
        separatorLineView4.snp.makeConstraints { (make) in
            make.top.equalTo(postCodeTF.snp.bottom).offset(20)
            make.leading.equalTo(postCodeTitleLabel.snp.leading)
            make.height.equalTo(0.35)
            make.width.equalTo(separatorLineWidth)
        }
    }
}


// MARK: - UITextFieldDelegate

extension AddCardDetailViewController: UITextFieldDelegate {
    
}


// MARK: - TableviewTopViewDelegate

extension AddCardDetailViewController: TableviewTopViewDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
