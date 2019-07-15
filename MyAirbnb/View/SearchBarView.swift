//
//  SearchBarView.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 07/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

protocol CalendarDelegate: class {
    func presentCalenderVC()
}

class SearchBarView: UIView {
    // SearchBarView must have a more than 120 height
    
    // MARK: - UI Properties
    let searchContainerView = UIView()
    let searchImageView = UIImageView()
    let searchTF = UITextField()
    let searchCancelBtn = UIButton()
    
    let filterDateBtn = UIButton()
    let filterPeopleBtn = UIButton()
    lazy var filterStackView = UIStackView(arrangedSubviews: [filterDateBtn, filterPeopleBtn])
    
    let autoCompleteTableView = UITableView()
    

    // MARK: - Properties
    var searchContainerTrailingInSearch: NSLayoutConstraint?
    
    var selectedDatesArray = [Date]()
    
    var selectedDateString = "날짜" {
        didSet {
            
            filterDateBtn.setTitle("    \(selectedDateString)    ", for: .normal)
//            let widthConst = selectedDateString.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: .semibold)]).width
//            filterDateBtn.frame.size.width = widthConst
            
            if selectedDateString == "날짜" {
                filterDateBtn.setTitleColor(.black, for: .normal)
                filterDateBtn.backgroundColor = .clear
            } else {
                filterDateBtn.setTitleColor(.white, for: .normal)
                filterDateBtn.backgroundColor = StandardUIValue.shared.colorBlueGreen
            }
        }
    }
    
    weak var delegate: CalendarDelegate?
    
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
        let bottomMargin = StandardUIValue.shared.mainTableViewCellsTopBottomPadding
        searchContainerView.translatesAutoresizingMaskIntoConstraints = false
        searchContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: sideMargin/2).isActive = true
        searchContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        let searchContainerTrailing = searchContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideMargin)
        searchContainerTrailing.priority = UILayoutPriority(rawValue: 500)
        searchContainerTrailing.isActive = true
//        searchContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        searchContainerView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        // =================================== searchContainerView begin ===================================
        searchContainerView.addSubview(searchImageView)
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        searchImageView.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 15).isActive = true
        searchImageView.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor).isActive = true
        searchImageView.heightAnchor.constraint(equalTo: searchContainerView.heightAnchor, multiplier: 0.4).isActive = true
        searchImageView.widthAnchor.constraint(equalTo: searchImageView.heightAnchor, multiplier: 1).isActive = true
        
        
        searchContainerView.addSubview(searchTF)
        searchTF.translatesAutoresizingMaskIntoConstraints = false
        searchTF.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: 15).isActive = true
        searchTF.centerYAnchor.constraint(equalTo: searchImageView.centerYAnchor).isActive = true
        searchTF.widthAnchor.constraint(equalTo: searchContainerView.widthAnchor, multiplier: 0.85).isActive = true
        searchTF.heightAnchor.constraint(equalTo: searchContainerView.heightAnchor, multiplier: 0.7).isActive = true
        
        self.addSubview(searchCancelBtn)
        searchCancelBtn.translatesAutoresizingMaskIntoConstraints = false
        searchCancelBtn.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor).isActive = true
        searchCancelBtn.heightAnchor.constraint(equalTo: searchContainerView.heightAnchor, multiplier: 1).isActive = true
        searchCancelBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        // =================================== searchContainerView end ===================================
        
        self.addSubview(filterStackView)    // 높이: 50
        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        filterStackView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor).isActive = true
        filterStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideMargin).isActive = true
        filterStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        filterStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        // =================================== filterStackview begin ===================================
        filterDateBtn.topAnchor.constraint(equalTo: filterStackView.topAnchor, constant: 15).isActive = true
        filterDateBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
//        filterDateBtn.widthAnchor.constraint(equalToConstant: widthConst).isActive = true
        
        filterPeopleBtn.leadingAnchor.constraint(equalTo: filterDateBtn.trailingAnchor, constant: 5).isActive = true
        filterPeopleBtn.topAnchor.constraint(equalTo: filterStackView.topAnchor, constant: 15).isActive = true
        filterPeopleBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        // =================================== filterStackview end ===================================
        
        self.addSubview(autoCompleteTableView)
        let height: CGFloat = UIScreen.main.bounds.height - 55 - 50
        autoCompleteTableView.translatesAutoresizingMaskIntoConstraints = false
        autoCompleteTableView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: 0).isActive = true
        autoCompleteTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        autoCompleteTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        autoCompleteTableView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
    }
    
    private func configureViewsOptions() {
        self.backgroundColor = .clear
        
        searchContainerView.backgroundColor = .white
        searchContainerView.layer.shadowColor = UIColor.black.cgColor
        searchContainerView.layer.shadowOpacity = 0.15
        searchContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        searchContainerView.layer.shadowRadius = 5
        searchContainerView.layer.cornerRadius = 3
        //        searchContainerView.layer.shadowPath
        
        searchImageView.image = UIImage(named: "searchIcon")
        
        searchTF.delegate = self
        searchTF.placeholder = "'쿠알라룸프르'에 가보는 건 어떠세요?"
        searchTF.attributedPlaceholder = NSAttributedString(string: "'쿠알라룸프르'에 가보는 건 어떠세요?", attributes: [
            .foregroundColor: UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.0),
            .font: UIFont.systemFont(ofSize: 14, weight: .bold)
            ])
        searchTF.font = .systemFont(ofSize: 14, weight: .bold)
        searchTF.textColor = #colorLiteral(red: 0.1501367688, green: 0.1492514014, blue: 0.1508219242, alpha: 1)
        
        searchCancelBtn.setTitle("취소", for: .normal)
        searchCancelBtn.setTitleColor(.black, for: .normal)
        searchCancelBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        searchCancelBtn.addTarget(self, action: #selector(searchCancelBtnDidTap(_:)), for: .touchUpInside)
        searchCancelBtn.layer.opacity = 0
        
        filterStackView.axis = .horizontal
        filterStackView.alignment = .leading
        filterStackView.spacing = 5
        
        filterDateBtn.setTitle("    날짜    ", for: .normal)
        filterDateBtn.setTitleColor(StandardUIValue.shared.colorRegularText, for: .normal)
        filterDateBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        filterDateBtn.layer.borderColor = StandardUIValue.shared.colorLineBorder.cgColor
        filterDateBtn.layer.borderWidth = 0.5
        filterDateBtn.layer.cornerRadius = 5
        filterDateBtn.addTarget(self, action: #selector(filterDateBtnDidTap(_:)), for: .touchUpInside)
        
        filterPeopleBtn.setTitle("    인원    ", for: .normal)    // 공백 앞뒤 4개
        filterPeopleBtn.setTitleColor(StandardUIValue.shared.colorRegularText, for: .normal)
        filterPeopleBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        filterPeopleBtn.layer.borderColor = StandardUIValue.shared.colorLineBorder.cgColor
        filterPeopleBtn.layer.borderWidth = 0.5
        filterPeopleBtn.layer.cornerRadius = 5
        
        autoCompleteTableView.delegate = self
        autoCompleteTableView.dataSource = self
        autoCompleteTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        autoCompleteTableView.backgroundColor = .blue
    }
    
    @objc func searchCancelBtnDidTap(_ sender: UIButton) {
        searchTF.resignFirstResponder()
        searchTF.text = ""
    }
    
    @objc func filterDateBtnDidTap(_ sender: UIButton) {
        self.delegate?.presentCalenderVC()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        print("--------------------------[SearchBarView layoutSubviews]--------------------------")
        print(filterDateBtn.titleLabel?.text)
    }
    
    
    
}


extension SearchBarView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.searchContainerTrailingInSearch = self.searchContainerView.trailingAnchor.constraint(equalTo: self.searchCancelBtn.leadingAnchor, constant: -20)
     
        
        UIView.animate(withDuration: 0.2) {
            self.searchTF.transform = CGAffineTransform(translationX: -self.searchImageView.frame.width-15, y: 0)
            self.searchImageView.layer.opacity = 0
            self.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.3, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [.curveEaseIn], animations: {
            self.searchContainerTrailingInSearch?.priority = .defaultHigh
            self.searchContainerTrailingInSearch?.isActive = true
            
            self.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
            self.searchCancelBtn.layer.opacity = 1
        }) { (_) in
            self.searchImageView.isHidden = true
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3, animations: {
                self.searchCancelBtn.layer.opacity = 0

            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.6, animations: {
                self.searchContainerTrailingInSearch?.priority = .defaultLow

                self.searchTF.transform = CGAffineTransform.identity
                self.searchImageView.isHidden = false
                self.searchImageView.layer.opacity = 1
                self.layoutIfNeeded()
            })
        })
    }
}

extension SearchBarView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}
