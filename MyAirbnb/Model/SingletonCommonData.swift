//
//  SingletonCommonData.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

class SingletonCommonData {
    static let shared = SingletonCommonData()
    static let userDefaultIDKey = "UserID"
    static let userDefaultTokenKey = "UserToken"
    static let userDefaultLoginStateKey = "UserLoginState"
    
    var stateArray = [String]()
}
