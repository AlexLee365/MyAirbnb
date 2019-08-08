//
//  WishList.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/09.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

struct WishList: Codable {
    let id: Int
    let title: String
    let image: String
    let roomsNumber, guestNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, image
        case roomsNumber = "rooms_number"
        case guestNumber = "guest_number"
    }
}

struct WishListDetail: Codable {
    let title: String
    let checkIn, checkOut: String?
    let adult, kid, infant, guestNumber: Int
    let isPublic: Bool
    let roomsValid: [RoomsValid]
    let roomsInvalid: [String?]
    
    enum CodingKeys: String, CodingKey {
        case title
        case checkIn = "check_in"
        case checkOut = "check_out"
        case adult, kid, infant
        case guestNumber = "guest_number"
        case isPublic = "is_public"
        case roomsValid = "rooms_valid"
        case roomsInvalid = "rooms_invalid"
    }
}

struct RoomsValid: Codable {
    let id: Int
    let host, title: String
    let image, image1, image2, image3: String
    let image4: String
    let price: Int
    let roomsValidDescription, roomType, space: String
    let totalRating: Double
    let bedroom, beds, bathroom, capacity: Int
    let bathType, address: String
    let reservations: Int
    let state, label: String
    let superHost: String?
    let facilities: [String]
    let isSaved: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, host, title, image
        case image1 = "image_1"
        case image2 = "image_2"
        case image3 = "image_3"
        case image4 = "image_4"
        case price
        case roomsValidDescription = "description"
        case roomType = "room_type"
        case space
        case totalRating = "total_rating"
        case bedroom, beds, bathroom, capacity
        case bathType = "bath_type"
        case address, reservations, state, label
        case superHost = "super_host"
        case facilities
        case isSaved = "is_saved"
    }
    
    func drawStarsWithHouseRate() -> String {
        var starCount = 0
        
        switch totalRating {
        case 0..<1.1:
            starCount = 1
        case 1.1..<2.1:
            starCount = 2
        case 2.1..<3.1:
            starCount = 3
        case 3.1..<4.1:
            starCount = 4
        case 4.1...5:
            starCount = 5
        default:
            starCount = 5
        }
        return String(repeating: "★", count: starCount)
    }
}
