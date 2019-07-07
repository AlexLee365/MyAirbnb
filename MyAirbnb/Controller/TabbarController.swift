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
        
       
        
        
        
        setSeparateLine()
        setTabbarItems()
        print("tabbar frame: ", tabBar.frame)
        print("view frame: ", view.frame)
        
    }
    
    private func setSeparateLine() {
        view.addSubview(separateLine)
        separateLine.translatesAutoresizingMaskIntoConstraints = false
        separateLine.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        separateLine.topAnchor.constraint(equalTo: view.topAnchor, constant:  10).isActive = true
        separateLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separateLine.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        separateLine.backgroundColor = .lightGray
    }
    
    private func setTabbarItems() {
        let mainVC = MainViewController()
        let saveListVC = MainViewController()
        let tripVC = TripViewController()
        let messageVC = MainViewController()
        let profileVC = MainViewController()
        
        //        mainVC.tabBarItem = UITabBarItem(title: "탐색하기", image: UIImage(named: "tabbarIcon_Search")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), tag: 0)
        mainVC.tabBarItem = UITabBarItem(title: "탐색하기", image: UIImage(named: "tabbarIcon_Search")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "tabbarIcon_Search")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        mainVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        mainVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        saveListVC.tabBarItem = UITabBarItem(title: "저장 목록", image: UIImage(named: "tabbarIcon_SaveList")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), tag: 1)
        saveListVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        tripVC.tabBarItem = UITabBarItem(title: "여행", image: UIImage(named: "tabbarIcon_Travel")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), tag: 1)
        tripVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        messageVC.tabBarItem = UITabBarItem(title: "메세지", image: UIImage(named: "tabbarIcon_Message")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), tag: 1)
        messageVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        profileVC.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(named: "tabbarIcon_Profile")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), tag: 1)
        profileVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        
        
        
        
        self.view.backgroundColor = .orange
        viewControllers = [mainVC, saveListVC, tripVC, messageVC, profileVC]
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
//        tabBar.frame = CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.y, width: tabBar.frame.width, height: tabBar.frame.height)
        tabBar.sizeThatFits(tabBar.frame.size)
        
    }
    
    
    

   
}

extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = window.safeAreaInsets.bottom + 60
        return sizeThatFits
    }
}
