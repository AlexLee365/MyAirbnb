//
//  FilterPeopleViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 16/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class FilterPeopleViewController: UIViewController {
    
    
    // MARK: - UI Properties
    let backgroundView = UIView()
    
    let containerView = UIView()
    let mainTitleLabel = UILabel()
    let refreshBtn = UIButton()
    let seperateLineViewTop = UIView()
    
    let mainSubtitleLabel = UILabel()
    let adultTitleLabel = UILabel()
    let adultMinusBtn = UIButton()
    let adultCountLabel = UILabel()
    let adultPlusBtn = UIButton()
    
    let childTitleLabel = UILabel()
    let childSubtitleLabel = UILabel()
    let childMinusBtn = UIButton()
    let childCountLabel = UILabel()
    let childPlusBtn = UIButton()
    
    let babyTitleLabel = UILabel()
    let babySubtitleLabel = UILabel()
    let babyMinusBtn = UIButton()
    let babyCountLabel = UILabel()
    let babyPlusBtn = UIButton()
    
    let seperateLineViewBottom = UIView()
    let resultBtn = UIButton()
    
    // MARK: - Properties
    var selectedPeople = (0, 0, 0)
    
    var adultCount = 0 {
        didSet {
            adultCountLabel.text = String(adultCount)
            if adultCount == 0 {
                adultMinusBtn.isEnabled = false
                adultMinusBtn.layer.opacity = 0.3
            } else {
                adultMinusBtn.isEnabled = true
                adultMinusBtn.layer.opacity = 1
            }
        }
    }
    var childCount = 0 {
        didSet {
            childCountLabel.text = String(childCount)
            if childCount == 0 {
                childMinusBtn.isEnabled = false
                childMinusBtn.layer.opacity = 0.3
            } else {
                childMinusBtn.isEnabled = true
                childMinusBtn.layer.opacity = 1
            }
        }
    }
    var babyCount = 0 {
        didSet {
            babyCountLabel.text = String(babyCount)
            if babyCount == 0 {
                babyMinusBtn.isEnabled = false
                babyMinusBtn.layer.opacity = 0.3
            } else {
                babyMinusBtn.isEnabled = true
                babyMinusBtn.layer.opacity = 1
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundView()
        setAutoLayout()
        configureViewsOptions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAnimation()
        
        adultCount = selectedPeople.0
        childCount = selectedPeople.1
        babyCount = selectedPeople.2
    }
    
    private func setBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.frame = view.frame
        backgroundView.backgroundColor = .white
        backgroundView.alpha = 0
    }
    
    private func setAutoLayout() {
        let safeGuide = view.safeAreaLayoutGuide
        let sideMargin: CGFloat = 20
        let buttonSize: CGFloat = 30
            
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 80).isActive = true
        containerView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 15).isActive = true
        containerView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -15).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 380).isActive = true
            
        containerView.addSubview(mainTitleLabel)
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainTitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        mainTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15).isActive = true
        
        containerView.addSubview(refreshBtn)
        refreshBtn.translatesAutoresizingMaskIntoConstraints = false
        refreshBtn.centerYAnchor.constraint(equalTo: mainTitleLabel.centerYAnchor).isActive = true
        refreshBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -sideMargin).isActive = true
//        refreshBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        refreshBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        containerView.addSubview(seperateLineViewTop)
        seperateLineViewTop.translatesAutoresizingMaskIntoConstraints = false
        seperateLineViewTop.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 15).isActive = true
        seperateLineViewTop.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        seperateLineViewTop.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        seperateLineViewTop.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        containerView.addSubview(mainSubtitleLabel)
        mainSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainSubtitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        mainSubtitleLabel.topAnchor.constraint(equalTo: seperateLineViewTop.bottomAnchor, constant: 15).isActive = true
        
        // Adult
        containerView.addSubview(adultTitleLabel)
        adultTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        adultTitleLabel.topAnchor.constraint(equalTo: mainSubtitleLabel.bottomAnchor, constant: 50).isActive = true
        adultTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: sideMargin).isActive = true
        
        containerView.addSubview(adultPlusBtn)
        adultPlusBtn.translatesAutoresizingMaskIntoConstraints = false
        adultPlusBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -sideMargin).isActive = true
        adultPlusBtn.centerYAnchor.constraint(equalTo: adultTitleLabel.centerYAnchor).isActive = true
        adultPlusBtn.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        adultPlusBtn.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        containerView.addSubview(adultCountLabel)
        adultCountLabel.translatesAutoresizingMaskIntoConstraints = false
        adultCountLabel.trailingAnchor.constraint(equalTo: adultPlusBtn.leadingAnchor, constant: -sideMargin).isActive = true
        adultCountLabel.centerYAnchor.constraint(equalTo: adultTitleLabel.centerYAnchor).isActive = true
        adultCountLabel.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        containerView.addSubview(adultMinusBtn)
        adultMinusBtn.translatesAutoresizingMaskIntoConstraints = false
        adultMinusBtn.trailingAnchor.constraint(equalTo: adultCountLabel.leadingAnchor, constant: -sideMargin).isActive = true
        adultMinusBtn.centerYAnchor.constraint(equalTo: adultTitleLabel.centerYAnchor).isActive = true
        adultMinusBtn.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        adultMinusBtn.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        // Child
        containerView.addSubview(childTitleLabel)
        childTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        childTitleLabel.topAnchor.constraint(equalTo: adultTitleLabel.bottomAnchor, constant: 44).isActive = true
        childTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: sideMargin).isActive = true
        
        containerView.addSubview(childSubtitleLabel)
        childSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        childSubtitleLabel.topAnchor.constraint(equalTo: childTitleLabel.bottomAnchor, constant: 2).isActive = true
        childSubtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: sideMargin).isActive = true
        
        containerView.addSubview(childPlusBtn)
        childPlusBtn.translatesAutoresizingMaskIntoConstraints = false
        childPlusBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -sideMargin).isActive = true
        childPlusBtn.centerYAnchor.constraint(equalTo: childTitleLabel.bottomAnchor, constant: -4).isActive = true
        childPlusBtn.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        childPlusBtn.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        containerView.addSubview(childCountLabel)
        childCountLabel.translatesAutoresizingMaskIntoConstraints = false
        childCountLabel.trailingAnchor.constraint(equalTo: childPlusBtn.leadingAnchor, constant: -sideMargin).isActive = true
        childCountLabel.centerYAnchor.constraint(equalTo: childPlusBtn.centerYAnchor).isActive = true
        childCountLabel.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        containerView.addSubview(childMinusBtn)
        childMinusBtn.translatesAutoresizingMaskIntoConstraints = false
        childMinusBtn.trailingAnchor.constraint(equalTo: childCountLabel.leadingAnchor, constant: -sideMargin).isActive = true
        childMinusBtn.centerYAnchor.constraint(equalTo: childPlusBtn.centerYAnchor).isActive = true
        childMinusBtn.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        childMinusBtn.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        // Baby
        containerView.addSubview(babyTitleLabel)
        babyTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        babyTitleLabel.topAnchor.constraint(equalTo: childSubtitleLabel.bottomAnchor, constant: 40).isActive = true
        babyTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: sideMargin).isActive = true
        
        containerView.addSubview(babySubtitleLabel)
        babySubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        babySubtitleLabel.topAnchor.constraint(equalTo: babyTitleLabel.bottomAnchor, constant: 2).isActive = true
        babySubtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: sideMargin).isActive = true
        
        containerView.addSubview(babyPlusBtn)
        babyPlusBtn.translatesAutoresizingMaskIntoConstraints = false
        babyPlusBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -sideMargin).isActive = true
        babyPlusBtn.centerYAnchor.constraint(equalTo: babyTitleLabel.bottomAnchor, constant: -4).isActive = true
        babyPlusBtn.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        babyPlusBtn.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        containerView.addSubview(babyCountLabel)
        babyCountLabel.translatesAutoresizingMaskIntoConstraints = false
        babyCountLabel.trailingAnchor.constraint(equalTo: babyPlusBtn.leadingAnchor, constant: -sideMargin).isActive = true
        babyCountLabel.centerYAnchor.constraint(equalTo: babyPlusBtn.centerYAnchor).isActive = true
        babyCountLabel.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        containerView.addSubview(babyMinusBtn)
        babyMinusBtn.translatesAutoresizingMaskIntoConstraints = false
        babyMinusBtn.trailingAnchor.constraint(equalTo: babyCountLabel.leadingAnchor, constant: -sideMargin).isActive = true
        babyMinusBtn.centerYAnchor.constraint(equalTo: babyPlusBtn.centerYAnchor).isActive = true
        babyMinusBtn.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        babyMinusBtn.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        

        containerView.addSubview(seperateLineViewBottom)
        seperateLineViewBottom.translatesAutoresizingMaskIntoConstraints = false
        seperateLineViewBottom.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -47).isActive = true
        seperateLineViewBottom.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        seperateLineViewBottom.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        seperateLineViewBottom.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        containerView.addSubview(resultBtn)
        resultBtn.translatesAutoresizingMaskIntoConstraints = false
        resultBtn.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        resultBtn.centerYAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -23).isActive = true
        //        resultBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        resultBtn.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1).isActive = true
        resultBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func configureViewsOptions() {
        let textColor = StandardUIValue.shared.colorBoldText
        let textFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        let plusImage = UIImage(named: "plusIcon")
        let minusImage = UIImage(named: "minusIcon")
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 5
        containerView.alpha = 0
        
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 0.6
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowRadius = 5
        
        mainTitleLabel.text = "필터"
        mainTitleLabel.textColor = textColor
        mainTitleLabel.font = textFont
        
        refreshBtn.setTitle("모두 지우기", for: .normal)
        refreshBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        refreshBtn.setTitleColor(textColor, for: .normal)
        refreshBtn.addTarget(self, action: #selector(refreshBtnDidTap(_:)), for: .touchUpInside)
        
        seperateLineViewTop.backgroundColor = #colorLiteral(red: 0.5761868954, green: 0.5727648139, blue: 0.5788194537, alpha: 0.4162831764)
        
        mainSubtitleLabel.text = "인원"
        mainSubtitleLabel.textColor = textColor
        mainSubtitleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        
        adultTitleLabel.text = "성인"
        adultTitleLabel.textColor = textColor
        adultTitleLabel.font = textFont
        
        adultCountLabel.text = String(adultCount)
        adultCountLabel.textColor = textColor
        adultCountLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        adultPlusBtn.setImage(plusImage, for: .normal)
        adultPlusBtn.addTarget(self, action: #selector(plusBtnDidTap(_:)), for: .touchUpInside)
        adultPlusBtn.tag = 0
        adultMinusBtn.setImage(minusImage, for: .normal)
        adultMinusBtn.isEnabled = false
        adultMinusBtn.layer.opacity = 0.3
        adultMinusBtn.addTarget(self, action: #selector(minusBtnDidTap(_:)), for: .touchUpInside)
        adultMinusBtn.tag = 0
        
        childTitleLabel.text = "어린이"
        childTitleLabel.textColor = textColor
        childTitleLabel.font = textFont
        
        childSubtitleLabel.text = "2~12세"
        childSubtitleLabel.textColor = textColor
        childSubtitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        childCountLabel.text = String(childCount)
        childCountLabel.textColor = textColor
        childCountLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        childPlusBtn.setImage(plusImage, for: .normal)
        childPlusBtn.addTarget(self, action: #selector(plusBtnDidTap(_:)), for: .touchUpInside)
        childPlusBtn.tag = 1
        childMinusBtn.setImage(minusImage, for: .normal)
        childMinusBtn.isEnabled = false
        childMinusBtn.layer.opacity = 0.3
        childMinusBtn.addTarget(self, action: #selector(minusBtnDidTap(_:)), for: .touchUpInside)
        childMinusBtn.tag = 1
        
        babyTitleLabel.text = "유아"
        babyTitleLabel.textColor = textColor
        babyTitleLabel.font = textFont
        
        babySubtitleLabel.text = "2~12세"
        babySubtitleLabel.textColor = textColor
        babySubtitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        babyCountLabel.text = String(babyCount)
        babyCountLabel.textColor = textColor
        babyCountLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        babyPlusBtn.setImage(plusImage, for: .normal)
        babyPlusBtn.addTarget(self, action: #selector(plusBtnDidTap(_:)), for: .touchUpInside)
        babyPlusBtn.tag = 2
        babyMinusBtn.setImage(minusImage, for: .normal)
        babyMinusBtn.isEnabled = false
        babyMinusBtn.layer.opacity = 0.3
        babyMinusBtn.addTarget(self, action: #selector(minusBtnDidTap(_:)), for: .touchUpInside)
        babyMinusBtn.tag = 2
        
        seperateLineViewBottom.backgroundColor = #colorLiteral(red: 0.5761868954, green: 0.5727648139, blue: 0.5788194537, alpha: 0.4162831764)
        
        resultBtn.setTitle("결과 보기", for: .normal)
        resultBtn.setTitleColor(UIColor(red:0.09, green:0.51, blue:0.54, alpha:1.0), for: .normal)
        resultBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        resultBtn.addTarget(self, action: #selector(resultBtnDidTap(_:)), for: .touchUpInside)
    }
    
    private func setAnimation() {
        UIView.animate(withDuration: 0.2) {
            self.backgroundView.alpha = 0.5
            self.containerView.transform = CGAffineTransform(translationX: 0, y: -10)
            self.containerView.alpha = 1
        }
    }
    
    @objc func plusBtnDidTap(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            adultCount += 1
        case 1:
            childCount += 1
        case 2:
            babyCount += 1
        default: break
        }
    }
    
    @objc func minusBtnDidTap(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            adultCount -= 1
        case 1:
            childCount -= 1
        case 2:
            babyCount -= 1
        default: break
        }
    }
    
    @objc func refreshBtnDidTap(_ sender: UIButton) {
        adultCount = 0
        childCount = 0
        babyCount = 0
    }
    
    @objc func resultBtnDidTap(_ sender: UIButton) {
        print("resultBtnDidTap")

        guard let tabbarVC = presentingViewController as? TabbarController else { print("tabbarVC convert error"); return }
        guard let naviVC = tabbarVC.viewControllers?.first as? UINavigationController else { print("navi convert error"); return }
        
        if let mainVC = naviVC.viewControllers.first as? MainViewController {
           print("mainVC")
            
            mainVC.searchBarView.selectedPeople = (adultCount, childCount, babyCount)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.backgroundView.alpha = 0
                self.containerView.transform = CGAffineTransform.identity
                self.containerView.alpha = 0
            }) { (_) in
                self.dismiss(animated: false, completion: nil)
            }
            
            
        } else if let tripVC = presentingViewController as? TripViewController {
            print("tripVC")
        }
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLocation = touches.first!.location(in: view)
        
        guard !containerView.frame.contains(touchLocation) else { return }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundView.alpha = 0
            self.containerView.transform = CGAffineTransform.identity
            self.containerView.alpha = 0
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }


}
