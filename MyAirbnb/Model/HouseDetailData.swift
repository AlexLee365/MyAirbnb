//
//  HouseDetailData.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 25/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

//struct HouseDetailData: Codable {
//    let id: Int
//    let title, host, address: String
//    let state: Int
//    let postalCode: String
//    let mobile: Int
//    let image, image1, image2, image3: String
//    let image4: String
//    let totalRating: Double
//    let capacity: Int
//    let space, roomType: String
//    let bedroom: Int
//    let bathType: String
//    let bathroom: Int
//    let cancellation: String
//    let minStay, maxStay: Int
//    let houseDescription: String
//    let price: Int
//    let facilities: [String]
//    let reservations: [[String]]
//    let updatedAt, createdAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, title, host, address, state
//        case postalCode = "postal_code"
//        case mobile, image
//        case image1 = "image_1"
//        case image2 = "image_2"
//        case image3 = "image_3"
//        case image4 = "image_4"
//        case totalRating = "total_rating"
//        case capacity, space
//        case roomType = "room_type"
//        case bedroom
//        case bathType = "bath_type"
//        case bathroom, cancellation
//        case minStay = "min_stay"
//        case maxStay = "max_stay"
//        case houseDescription = "description"
//        case price, facilities, reservations
//        case updatedAt = "updated_at"
//        case createdAt = "created_at"
//    }
//}


struct HouseDetailData: Codable {
    let id: Int
    let title, host, address, state: String
    let postalCode: String
    let mobile: Int
    let image: String
    let images: Int
    let totalRating: Double
    let capacity: Int
    let space, roomType: String
    let bedroom: Int
    let bathType: String
    let bathroom: Int
    let cancellation: String
    let minStay, maxStay: Int
    let houseDescription: String
    let price: Int
    let facilities: [String]
    let reservations: [[String]]
    let updatedAt, createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, host, address, state
        case postalCode = "postal_code"
        case mobile, image, images
        case totalRating = "total_rating"
        case capacity, space
        case roomType = "room_type"
        case bedroom
        case bathType = "bath_type"
        case bathroom, cancellation
        case minStay = "min_stay"
        case maxStay = "max_stay"
        case houseDescription = "description"
        case price, facilities, reservations
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
