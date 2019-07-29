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
        
        let firstVC = LaunchScreenViewController()
        
        window?.rootViewController = firstVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

