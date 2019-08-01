//
//  SearchBarView.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 07/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit


protocol CalendarDelegate: class {
    func presentCalenderVC()
    func presentPeopleVC()
    func presentFilterVC()
}

class SearchBarView: UIView {
    // SearchBarView must have a more than 120 height
    
    enum UseCase {
        case inMainVC, inTripVC, inHouseVC
    }
    
    // MARK: - UI Properties
    let searchContainerView = UIView()
    let searchImageBtn = UIButton()
    let searchTF = UITextField()
    let searchCancelBtn = UIButton()
    
    let filterDateBtn = UIButton()
    let filterPeopleBtn = UIButton()
    let filterRemainsBtn = UIButton()
    lazy var filterStackView = UIStackView(arrangedSubviews: [filterDateBtn, filterPeopleBtn, filterRemainsBtn])
    
    // MARK: - Properties
    var searchContainerTrailingInSearch: NSLayoutConstraint?
    let notiCenter = NotificationCenter.default
    var useCase: UseCase = .inMainVC
    
    var selectedDatesArray = [Date]()
    var selectedDateString = "날짜" {
        didSet {
            filterDateBtn.setTitle("    \(selectedDateString)    ", for: .normal)
            
            if selectedDateString == "날짜" {
                filterDateBtn.setTitleColor(StandardUIValue.shared.colorRegularText, for: .normal)
                filterDateBtn.backgroundColor = .clear
            } else {
                filterDateBtn.setTitleColor(.white, for: .normal)
                filterDateBtn.backgroundColor = StandardUIValue.shared.colorBlueGreen
            }
        }
    }
    
    var selectedPeople = (0, 0, 0) {
        didSet {
            let total = selectedPeople.0 + selectedPeople.1 + selectedPeople.2
            if total == 0 {
                filterPeopleBtn.setTitle("    인원    ", for: .normal)
                filterPeopleBtn.setTitleColor(StandardUIValue.shared.colorRegularText, for: .normal)
                filterPeopleBtn.backgroundColor = .clear
            } else {
                filterPeopleBtn.setTitle("    게스트 \(total)명    ", for: .normal)
                filterPeopleBtn.setTitleColor(.white, for: .normal)
                filterPeopleBtn.backgroundColor = StandardUIValue.shared.colorBlueGreen
            }
        }
    }
    
    var selectedBed = (0, 0, 0) {
        didSet {
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        
        self.addSubview(searchContainerView)    // 높이: 45 + 10
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        searchContainerView.translatesAutoresizingMaskIntoConstraints = false
        searchContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: sideMargin/2).isActive = true
        searchContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        let searchContainerTrailing = searchContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin)
        searchContainerTrailing.priority = UILayoutPriority(rawValue: 500)
        searchContainerTrailing.isActive = true
        //        searchContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        searchContainerView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        // =================================== searchContainerView begin ===================================
        searchContainerView.addSubview(searchImageBtn)
        searchImageBtn.translatesAutoresizingMaskIntoConstraints = false
        searchImageBtn.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 0).isActive = true
        searchImageBtn.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor).isActive = true
        searchImageBtn.heightAnchor.constraint(equalTo: searchContainerView.heightAnchor, multiplier: 1).isActive = true
        searchImageBtn.widthAnchor.constraint(equalTo: searchImageBtn.heightAnchor, multiplier: 1).isActive = true
        
        
        searchContainerView.addSubview(searchTF)
        searchTF.translatesAutoresizingMaskIntoConstraints = false
        searchTF.leadingAnchor.constraint(equalTo: searchImageBtn.trailingAnchor, constant: 0).isActive = true
        searchTF.centerYAnchor.constraint(equalTo: searchImageBtn.centerYAnchor).isActive = true
        searchTF.widthAnchor.constraint(equalTo: searchContainerView.widthAnchor, multiplier: 0.85).isActive = true
        searchTF.heightAnchor.constraint(equalTo: searchContainerView.heightAnchor, multiplier: 1).isActive = true
        
        self.addSubview(searchCancelBtn)
        searchCancelBtn.translatesAutoresizingMaskIntoConstraints = false
        searchCancelBtn.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor).isActive = true
        searchCancelBtn.heightAnchor.constraint(equalTo: searchContainerView.heightAnchor, multiplier: 1).isActive = true
        searchCancelBtn.widthAnchor.constraint(equalToConstant: 60).isActive = true
        searchCancelBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        // =========================================================================================================
        
        self.addSubview(filterStackView)    // 높이: 50
        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        filterStackView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant:  15).isActive = true
        filterStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        let filterStackViewConstHeight = filterStackView.heightAnchor.constraint(equalToConstant: 32)
        filterStackViewConstHeight.priority = .defaultHigh // 750
        filterStackViewConstHeight.isActive = true
        let filterStackViewConstBottom = filterStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        filterStackViewConstBottom.priority = .defaultHigh // 750
        filterStackViewConstBottom.isActive = true
        
        // =================================== filterStackview begin ===================================
        filterDateBtn.topAnchor.constraint(equalTo: filterStackView.topAnchor, constant: 0).isActive = true
        filterDateBtn.heightAnchor.constraint(equalTo: filterStackView.heightAnchor, multiplier: 1).isActive = true
        //        filterDateBtn.widthAnchor.constraint(equalToConstant: widthConst).isActive = true
        
        //        filterPeopleBtn.leadingAnchor.constraint(equalTo: filterDateBtn.trailingAnchor, constant: 8).isActive = true
        filterPeopleBtn.topAnchor.constraint(equalTo: filterStackView.topAnchor, constant: 0).isActive = true
        filterPeopleBtn.heightAnchor.constraint(equalTo: filterStackView.heightAnchor, multiplier: 1).isActive = true
        
        //        filterRemainsBtn.leadingAnchor.constraint(equalTo: filterPeopleBtn.trailingAnchor, constant: 8).isActive = true
        filterRemainsBtn.topAnchor.constraint(equalTo: filterStackView.topAnchor, constant: 0).isActive = true
        filterRemainsBtn.heightAnchor.constraint(equalTo: filterStackView.heightAnchor, multiplier: 1).isActive = true
        // =========================================================================================================
    }
    
    private func configureViewsOptions() {
        self.backgroundColor = .clear
        
        searchContainerView.backgroundColor = .white
        searchContainerView.layer.shadowColor = UIColor.black.cgColor
        searchContainerView.layer.shadowOpacity = 0.15
        searchContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        searchContainerView.layer.shadowRadius = 5
        searchContainerView.layer.cornerRadius = 3
        
        searchImageBtn.setImage(UIImage(named: "searchIcon"), for: .normal)
        searchImageBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 13, bottom: 10, right: 13)
        searchImageBtn.imageView?.contentMode = .scaleAspectFit
        
        searchTF.delegate = self
        searchTF.placeholder = "'쿠알라룸프르'에 가보는 건 어떠세요?"
        searchTF.attributedPlaceholder = NSAttributedString(string: "'쿠알라룸프르'에 가보는 건 어떠세요?", attributes: [
            .foregroundColor: UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.0),
            .font: UIFont.systemFont(ofSize: 14, weight: .bold)
            ])
        searchTF.font = .systemFont(ofSize: 14, weight: .bold)
        searchTF.textColor = #colorLiteral(red: 0.1501367688, green: 0.1492514014, blue: 0.1508219242, alpha: 1)
        searchTF.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        searchCancelBtn.setTitle("취소", for: .normal)
        searchCancelBtn.setTitleColor(.black, for: .normal)
        searchCancelBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        searchCancelBtn.addTarget(self, action: #selector(searchCancelBtnDidTap(_:)), for: .touchUpInside)
        searchCancelBtn.layer.opacity = 0
        
        filterStackView.axis = .horizontal
        filterStackView.alignment = .leading
        filterStackView.spacing = 8
        
        filterDateBtn.setTitle("    날짜    ", for: .normal)      // 공백 앞뒤 4개
        filterDateBtn.setTitleColor(StandardUIValue.shared.colorRegularText, for: .normal)
        filterDateBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        filterDateBtn.layer.borderColor = StandardUIValue.shared.colorLineBorder.cgColor
        filterDateBtn.layer.borderWidth = 0.5
        filterDateBtn.layer.cornerRadius = 5
        filterDateBtn.addTarget(self, action: #selector(filterDateBtnDidTap(_:)), for: .touchUpInside)

        filterPeopleBtn.setTitle("    인원    ", for: .normal)
        filterPeopleBtn.setTitleColor(StandardUIValue.shared.colorRegularText, for: .normal)
        filterPeopleBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        filterPeopleBtn.layer.borderColor = StandardUIValue.shared.colorLineBorder.cgColor
        filterPeopleBtn.layer.borderWidth = 0.5
        filterPeopleBtn.layer.cornerRadius = 5
        filterPeopleBtn.addTarget(self, action: #selector(filterPeopleBtnDidTap(_:)), for: .touchUpInside)
        
        filterRemainsBtn.setTitle("    필터    ", for: .normal)
        filterRemainsBtn.setTitleColor(StandardUIValue.shared.colorRegularText, for: .normal)
        filterRemainsBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        filterRemainsBtn.layer.borderColor = StandardUIValue.shared.colorLineBorder.cgColor
        filterRemainsBtn.layer.borderWidth = 0.5
        filterRemainsBtn.layer.cornerRadius = 5
        filterRemainsBtn.addTarget(self, action: #selector(filterRemainsBtnDidTap(_:)), for: .touchUpInside)
        
    }
    
    @objc func searchCancelBtnDidTap(_ sender: UIButton) {  // 취소 버튼 => 수정종료
        searchTF.resignFirstResponder()
        
        notiCenter.post(name: .searchBarEditEnd, object: nil)
        textEditEndAnimation()
    }
    
    @objc func filterDateBtnDidTap(_ sender: UIButton) {
        notiCenter.post(name: .searchBarDateBtnDidTap, object: nil)
    }
    
    @objc func filterPeopleBtnDidTap(_ sender: UIButton) {
        notiCenter.post(name: .searchBarPeopleBtnDidTap, object: nil)
    }
    
    @objc func filterRemainsBtnDidTap(_ sender: UIButton) {
        notiCenter.post(name: .searchBarFilterBtnDidTap, object: nil)
    }
    
}


// TextField Delegate
extension SearchBarView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != "" else { return  true }
        print("Textfield should return / There are texts")
        textField.resignFirstResponder()
        notiCenter.post(name: .searchBarEnterPressed, object: nil, userInfo: ["result": textField.text ?? ""])
        textEditEndAnimation()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("tf should begin editing")
        if textField.text != "숙소", textField.text != "트립" {
            
        } else{
            self.searchTF.text = ""
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {   // 수정 시작
        print("SearchBarView TF did begin editing")
        let text = textField.text ?? ""
        notiCenter.post(name: .searchBarEditBegin, object: text)
        
        textEditBeginAnimation()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {     // 수정 종료
        print("SearchBarView TF did end editing")

//        notiCenter.post(name: .searchBarEditEnd, object: nil)
//        textEditEndAnimation()
    }
    
    @objc private func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        notiCenter.post(name: .searchBarEditingChanged, object: text)
    }
    
    private func textEditBeginAnimation() {
        self.searchContainerTrailingInSearch = self.searchContainerView.trailingAnchor.constraint(equalTo: self.searchCancelBtn.leadingAnchor, constant: 0)
        
        UIView.animate(withDuration: 0.15) {
            self.searchTF.transform = CGAffineTransform(translationX: -(self.searchImageBtn.frame.width - 15), y: 0)
            self.searchImageBtn.layer.opacity = 0
            
            self.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.3, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [.curveEaseIn], animations: {
            self.searchContainerTrailingInSearch?.priority = .defaultHigh
            self.searchContainerTrailingInSearch?.isActive = true
            self.layoutIfNeeded()
        }) { (_) in
            
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
            self.searchCancelBtn.layer.opacity = 1
        }) { (_) in
            self.searchImageBtn.isHidden = true
        }
    }
    
    private func textEditEndAnimation() {
        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3, animations: {
                self.searchCancelBtn.layer.opacity = 0
                
                self.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.6, animations: {
                self.searchContainerTrailingInSearch?.priority = .defaultLow
                
                self.searchTF.transform = CGAffineTransform.identity
                self.searchImageBtn.isHidden = false
                self.searchImageBtn.layer.opacity = 1
                self.layoutIfNeeded()
            })
        }) { (_) in
            guard self.searchTF.text == "" else { return }
            switch self.useCase {
            case .inMainVC:
                self.searchTF.text = ""
            case .inHouseVC:
                self.searchTF.text = "숙소"
            case .inTripVC:
                self.searchTF.text = "트립"
            }
        }
    }
}



