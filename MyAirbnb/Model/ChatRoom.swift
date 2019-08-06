//
//  ChatRoom.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/05.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

struct ChatRoom: Codable {
    let id: Int
    let startDate, endDate: String
    let room: Room
    let messages: Message
    
    enum CodingKeys: String, CodingKey {
        case id
        case startDate = "start_date"
        case endDate = "end_date"
        case room, messages
    }
}

struct ChatRoomDetailData: Codable {
    let id: Int
    let startDate, endDate: String
    let room: Room
    let messages: [Message]
    
    enum CodingKeys: String, CodingKey {
        case id
        case startDate = "start_date"
        case endDate = "end_date"
        case room, messages
    }
}

// MARK: - Room
struct Room: Codable {
    let id: Int
    let title: String
    let price: Int
    let host: ChatUser
}

// MARK: - Host
struct ChatUser: Codable {
    let id: Int
    let username: String
    let image: String?
}

// MARK: - Message
struct Message: Codable {
    let author: ChatUser
    let isHost: Bool
    let text, created: String
    
    enum CodingKeys: String, CodingKey {
        case author
        case isHost = "is_host"
        case text, created
    }
}



