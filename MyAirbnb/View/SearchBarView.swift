//
//  SearchBarView.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 07/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class SearchBarView: UIView {

    // MARK: - UI Properties
    let searchContainerView = UIView()
    let searchImageView = UIImageView()
    let searchTF = UITextField()
    let searchCancelBtn = UIButton()
    
    // MARK: - Properties
    var searchContainerTrailingInSearch: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {

        self.addSubview(searchContainerView)
        let searchMargin: CGFloat = 20
        searchContainerView.translatesAutoresizingMaskIntoConstraints = false
        searchContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: searchMargin/2).isActive = true
        searchContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: searchMargin).isActive = true
        let searchContainerTrailing = searchContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -searchMargin)
        searchContainerTrailing.priority = UILayoutPriority(rawValue: 500)
        searchContainerTrailing.isActive = true
        searchContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -searchMargin/2).isActive = true
        
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
        searchCancelBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
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
    }
    
    @objc func searchCancelBtnDidTap(_ sender: UIButton) {
        searchTF.resignFirstResponder()
        searchTF.text = ""
    }
   
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    

}


extension SearchBarView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("tf Did Begin")
        
        self.searchContainerTrailingInSearch = self.searchContainerView.trailingAnchor.constraint(equalTo: self.searchCancelBtn.leadingAnchor, constant: -20)
        UIView.animate(withDuration: 0.4) {
            self.searchCancelBtn.layer.opacity = 1
            self.searchContainerTrailingInSearch?.priority = .defaultHigh
            self.searchContainerTrailingInSearch?.isActive = true
            
            
            self.searchTF.transform = CGAffineTransform(translationX: -self.searchImageView.frame.width-15, y: 0)
            self.searchImageView.layer.opacity = 0
        }
        self.searchImageView.isHidden = true
        self.layoutIfNeeded()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("tf did end")
        UIView.animate(withDuration: 0.4) {
            self.searchCancelBtn.layer.opacity = 0
            self.searchContainerTrailingInSearch?.priority = .defaultLow
            
            self.searchTF.transform = CGAffineTransform.identity
            self.searchImageView.isHidden = false
            self.searchImageView.layer.opacity = 1
        }
        self.layoutIfNeeded()
    }
}
