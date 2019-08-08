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
    static let userDefaultIDNumber = "userNumber"
    static let userDefaultTokenKey = "UserToken"
    static let userDefaultLoginStateKey = "UserLoginState"
    
    static let userDefaultSaveStatesInfo = "SaveStatesInfo"
    static let userDefaultSaveChatList = "SaveChattingRoomList"
    
    static let notiKeySearchBarUseCase = "SearchBarUseCase"
    static let notiKeySearchBarInController = "SearchBarInController"
    
    
    var stateArray = [String]()
    var deviceSafeAreaInset = UIEdgeInsets.zero
    var tabbarController = UITabBarController()
    
    var userInfo: UserInfo?
    var userChatRoomsArray = [ChatRoom]()
    var usersLikeContentsArray = [[String: Int]]()
    var usersLikeRoomNumbersArray = [Int]()
    
    var tempValue: Any?
    
    func makeRandomString() -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let length = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< 10 {
            let rand = arc4random_uniform(length)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
