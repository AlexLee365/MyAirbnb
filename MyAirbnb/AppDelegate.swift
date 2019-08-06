//
//  AppDelegate.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 05/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 미로그인 시 회원가입VC
        let signUpVC = SignUpMainViewController()
        let signUPNaviVC = UINavigationController(rootViewController: signUpVC)
        
        // 로그인 시 런치VC
        let LaunchScreenVC = LaunchScreenViewController()
        
        let isLogined = UserDefaults.standard.bool(forKey: SingletonCommonData.userDefaultLoginStateKey)
        
        window?.rootViewController = isLogined ? LaunchScreenVC : signUPNaviVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

