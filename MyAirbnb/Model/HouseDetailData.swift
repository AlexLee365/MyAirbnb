//
//  HouseDetailData.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 25/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation


struct HouseDetailData: Codable {
    let id: Int
    let title: String
    let host: [String?]
    let address, state, postalCode, mobile: String
    let image, image1, image2, image3, image4, image5, image6: String?
    let bedImage0, bedImage1, bedImage2, bedImage3, bedImage4, bedImage5: String?
    let checkIn, checkOut: String?
    let totalRating: Double
    let capacity: Int
    let space, roomType: String
    let bedroom, beds: Int
    let bathType: String
    let bathroom: Int
    let cancellation: String
    let minStay, maxStay: Int
    let houseDescription, locationalDescription: String
    let price: Int
    let facilities: [[String]]
    let reservations: [[String]]
    let updatedAt, createdAt: String
    let label: String?
    let accuracyScore, locationScore, communicationScore, checkinScore: Int
    let cleanScore, valueScore: Int
    let superHost: String?
    let reviews: [[String]]
    
    enum CodingKeys: String, CodingKey {
        case id, title, host, address, state
        case postalCode = "postal_code"
        case mobile, image
        case image1 = "image_1"
        case image2 = "image_2"
        case image3 = "image_3"
        case image4 = "image_4"
        case image5 = "image_5"
        case image6 = "image_6"
        case bedImage0 = "bed_image_0"
        case bedImage1 = "bed_image_1"
        case bedImage2 = "bed_image_2"
        case bedImage3 = "bed_image_3"
        case bedImage4 = "bed_image_4"
        case bedImage5 = "bed_image_5"
        case checkIn = "check_in"
        case checkOut = "check_out"
        case totalRating = "total_rating"
        case capacity, space
        case roomType = "room_type"
        case bedroom, beds
        case bathType = "bath_type"
        case bathroom, cancellation
        case minStay = "min_stay"
        case maxStay = "max_stay"
        case houseDescription = "description"
        case locationalDescription = "locational_description"
        case price, facilities, reservations
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case label
        case accuracyScore = "accuracy_score"
        case locationScore = "location_score"
        case communicationScore = "communication_score"
        case checkinScore = "checkin_score"
        case cleanScore = "clean_score"
        case valueScore = "value_score"
        case superHost = "super_host"
        case reviews
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



