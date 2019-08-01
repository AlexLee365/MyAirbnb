//
//  SelectPayMethodViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class SelectPayMethodViewController: UIViewController {

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
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "결제 수단"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 27)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let creditCardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "creditCard")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let cardLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.text = "신용카드나 직불카드"
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 17)
        return label
    }()
    
    let greaterThanImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "greaterThan")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let clearBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setAutolayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    private func configure() {
        view.backgroundColor = .white
        
        topView.delegate = self
        view.addSubview(topView)
        
        view.addSubview(titleLabel)
        
        currencyLabel.attributedText = attributedText(first: "결제 통화: ", second: "KRW") 
        view.addSubview(currencyLabel)
        
        view.addSubview(creditCardImage)
        view.addSubview(cardLabel)
        view.addSubview(greaterThanImage)
        
        clearBtn.addTarget(self, action: #selector(addCardDetailBtnDidTap(_:)), for: .touchUpInside)
        view.addSubview(clearBtn)
    }
    
    @objc private func addCardDetailBtnDidTap(_ sender: UIButton) {
        let addCardDetailVC = AddCardDetailViewController()
        navigationController?.pushViewController(addCardDetailVC, animated: true)
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

        currencyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(20)
        }

        creditCardImage.snp.makeConstraints { (make) in
            make.top.equalTo(currencyLabel.snp.bottom).offset(30)
            make.leading.equalTo(20)
            make.width.equalTo(40)
            make.height.equalTo(25)
        }

        cardLabel.snp.makeConstraints { (make) in
            make.top.equalTo(currencyLabel.snp.bottom).offset(30)
            make.leading.equalTo(creditCardImage.snp.trailing).offset(15)
        }

        greaterThanImage.snp.makeConstraints { (make) in
            make.trailing.equalTo(-20)
            make.top.equalTo(cardLabel.snp.top)
            make.width.height.equalTo(15)
        }

        clearBtn.snp.makeConstraints { (make) in
            make.top.equalTo(currencyLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    private func attributedText(first: String, second: String) -> NSAttributedString{
        let string = first + second as NSString
        let result = NSMutableAttributedString(string: string as String)
        let attributesForFirstWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Book", size: 15) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        let attributesForSecondWord = [
            NSAttributedString.Key.font : UIFont(name: "AirbnbCerealApp-Book", size: 15) ?? "",
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
            ] as [NSAttributedString.Key : Any]
        
        result.setAttributes(attributesForFirstWord, range: string.range(of: first))
        result.setAttributes(attributesForSecondWord, range: string.range(of: second))
        
        return NSAttributedString(attributedString: result)
    }

    
}


extension SelectPayMethodViewController: TableviewTopViewDelegate {
    func popView() {
        dismiss(animated: true, completion: nil)
    }
}


