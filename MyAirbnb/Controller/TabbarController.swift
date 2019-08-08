//
//  TabbarController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 06/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {
    
    let separateLine = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       

        setSeparateLine()
        setTabbarItems()
    }
    
    private func setSeparateLine() {
        tabBar.addSubview(separateLine)
        separateLine.translatesAutoresizingMaskIntoConstraints = false
        separateLine.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        separateLine.topAnchor.constraint(equalTo: tabBar.topAnchor, constant:  0).isActive = true  // layoutSubview에서 설정 (tabbar frame을 받아오기위함)
        separateLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separateLine.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        separateLine.backgroundColor = #colorLiteral(red: 0.6363541484, green: 0.6325739026, blue: 0.639261663, alpha: 0.5090699914)
    }
    
    private func setTabbarItems() {
        let mainVC = UINavigationController(rootViewController: MainViewController()) 
        let saveListVC = UINavigationController(rootViewController: FavoriteHouseListViewController())
        let tripNaviController = PlannedTravelViewController()
        let messageVC = UINavigationController(rootViewController: MessageViewController()) 
        let profileVC = MyPageViewController()
            
        
        mainVC.tabBarItem = UITabBarItem(title: "탐색하기",
                                         image: UIImage(named: "tabbarIcon_Search")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                         selectedImage: UIImage(named: "tabbarIcon_Search_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        mainVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        mainVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        saveListVC.tabBarItem = UITabBarItem(title: "저장 목록",
                                             image: UIImage(named: "tabbarIcon_SaveList")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                             selectedImage: UIImage(named: "tabbarIcon_SaveList_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        saveListVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        tripNaviController.tabBarItem = UITabBarItem(title: "여행",
                                                     image: UIImage(named: "tabbarIcon_Travel")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                     selectedImage: UIImage(named: "tabbarIcon_Travel_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        tripNaviController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        messageVC.tabBarItem = UITabBarItem(title: "메세지",
                                            image: UIImage(named: "tabbarIcon_Message")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                            selectedImage: UIImage(named: "tabbarIcon_Message_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        messageVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        profileVC.tabBarItem = UITabBarItem(title: "프로필",
                                            image: UIImage(named: "tabbarIcon_Profile")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                            selectedImage: UIImage(named: "tabbarIcon_Profile_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        profileVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        

        viewControllers = [mainVC, saveListVC, tripNaviController, messageVC, profileVC]
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.barStyle = .black
        tabBar.tintColor = .yellow
        
        let unselectedColor = UIColor.black
        let selectedColor = UIColor.red
        
        let tapApperance = UITabBarItem.appearance()
        let tabTextFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
        
        tapApperance.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: unselectedColor,
             NSAttributedString.Key.font : tabTextFont]
            , for: .normal)
        tapApperance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : selectedColor], for: .selected)
        
    }
    
    var frameSet = false
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubview tabbar frame: ", tabBar.frame)
        
        if frameSet == false {
//            tabBar.sizeThatFits(tabBar.frame.size)
//            separateLine.topAnchor.constraint(equalTo: tabBar.topAnchor, constant:  0).isActive = true
            frameSet = true
        }
    }
    
    
    

   
}

extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {     // 탭바 높이 조정 (코드 다시 이해할것)
        super.sizeThatFits(size)
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = window.safeAreaInsets.bottom + 60
        return sizeThatFits
    }
}
