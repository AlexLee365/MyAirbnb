//
//  FavoriteHouseListViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class FavoriteHouseListViewController: UIViewController {
    
    //    let mainTableView = FavoriteHouseListView()
    let favoriteTableView = UITableView()
    let placeHolderView = UIView()
    
    let notiCenter = NotificationCenter.default
    let netWork = NetworkCommunicator()
    
    var wishListArray = [WishList]()
    var cellNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureViewsOptions()
        setPlaceHolderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let urlString = netWork.basicUrlString + "/wishlists/"
        netWork.getServerDataWithToken(urlString: urlString) { (result) in
            switch result {
            case .success(let value):
                guard let wishlist = try? JSONDecoder().decode([WishList].self, from: value) else{ print("‼️ WishList JSON decoding error "); return }
                print("🔵🔵🔵 WishList Data: ", wishlist)
                self.wishListArray = wishlist
                self.cellNumber = wishlist.count + 1
                

                DispatchQueue.main.async {
                    self.favoriteTableView.reloadData()
                }
            case .failure(let error):
                print("‼️ FavoriteHouseListVC WishList get Method Failed: ", error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                if self.wishListArray.count == 0 {
                    self.favoriteTableView.isHidden = true
                    self.placeHolderView.isHidden = false
                } else {
                    self.favoriteTableView.isHidden = false
                    self.placeHolderView.isHidden = true
                    self.view.sendSubviewToBack(self.placeHolderView)
                }
            }
        }
    }
    
    private func setupLayout() {
        let guide = view.safeAreaLayoutGuide
        
        view.addSubview(favoriteTableView)
        favoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        favoriteTableView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
        favoriteTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0).isActive = true
        favoriteTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0).isActive = true
        favoriteTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0).isActive = true
        favoriteTableView.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
    }
    
    private func configureViewsOptions() {
        navigationController?.navigationBar.isHidden = true
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
        favoriteTableView.register(OnePhotoCell.self, forCellReuseIdentifier: OnePhotoCell.identifier)
        favoriteTableView.register(ThreePhotoCell.self, forCellReuseIdentifier: ThreePhotoCell.identifier)
        favoriteTableView.contentInsetAdjustmentBehavior = .never
        favoriteTableView.rowHeight = UITableView.automaticDimension
        
        placeHolderView.isHidden = true
    }
    
    private func setPlaceHolderView() {
        view.addSubview(placeHolderView)
        placeHolderView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        let titleLabel = UILabel()
        placeHolderView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.top.equalTo(48)
        }
        
        titleLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        titleLabel.textAlignment = .left
        titleLabel.sizeToFit()
        titleLabel.text = "저장목록"
        
        let subtitleLabel = UILabel()
        placeHolderView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.trailing.equalTo(-20)
        }
        
        subtitleLabel.text = "매일 매일이 모험으로 가득한 것은 아니지만 다음 모험에 대한 계획을 세울 수는 있죠. 마음에 드는 집의 하트를 탭해서 저장하세요."
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        subtitleLabel.setLineSpacing(lineSpacing: 6, lineHeightMultiple: 1)
        
     
        let searchBtn = UIButton()
        placeHolderView.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }
        
        searchBtn.backgroundColor = StandardUIValue.shared.colorPink
        searchBtn.setTitle("숙소 검색", for: .normal)
        searchBtn.setTitleColor(.white, for: .normal)
        searchBtn.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        searchBtn.layer.cornerRadius = 5
        searchBtn.layer.masksToBounds = true
//        searchBtn.addTarget(self, action: #selector(searchBtnDidTap), for: .touchUpInside)
        
        let separatorLineView = UIView()
        placeHolderView.addSubview(separatorLineView)
        separatorLineView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalTo(searchBtn.snp.top).offset(-15)
        }
        separatorLineView.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
    }
    
//    @objc private func searchBtnDidTap() {
//        if let tabbarVC = tabBarController {
//            tabbarVC.selectedIndex = 0
//
//
//            tabbarVC.show(tabbarVC, sender: nil)
//        }
//    }
}

extension FavoriteHouseListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let titleTextCell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: indexPath) as! TitleCell
            return titleTextCell
            
        case 1...:
            let onePhotoCell = tableView.dequeueReusableCell(withIdentifier: OnePhotoCell.identifier, for: indexPath) as! OnePhotoCell
            onePhotoCell.setData(wishlist: wishListArray[indexPath.row - 1])
            
            return onePhotoCell
        default : break
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteDetailVC = FavoriteHouseDetailViewController()
        favoriteDetailVC.wishListID = wishListArray[indexPath.row - 1].id
        navigationController?.pushViewController(favoriteDetailVC, animated: true)
    }
    
    
}
