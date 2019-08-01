//
//  TripTestData.swift
//  MyAirbnb
//
//  Created by Solji Kim on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

struct TripTestData: Codable {
    let url: String
    let host, tripCategory, compatibility, technic: String
    let strength: String
    let tripReviews: [TripReview]
    let schedules: [Schedule]
    let provides: [Provide]
    let name: String
    let durationTime: Int
    let hostAbout, program, placeInfo, address: String
    let guestMaterial: String
    let image1, image2, image3, image4: String?
    let image5, image6, image7: String?
    let minAge: Int
    let additionalContition: String
    let certification: Bool
    let maxGuest, price, ratingScore: Int
    let state: String
    
    enum CodingKeys: String, CodingKey {
        case url, host
        case tripCategory = "trip_category"
        case compatibility, technic, strength
        case tripReviews = "trip_reviews"
        case schedules, provides, name
        case durationTime = "duration_time"
        case hostAbout = "host_about"
        case program
        case placeInfo = "place_info"
        case address
        case guestMaterial = "guest_material"
        case image1 = "image_1"
        case image2 = "image_2"
        case image3 = "image_3"
        case image4 = "image_4"
        case image5 = "image_5"
        case image6 = "image_6"
        case image7 = "image_7"
        case minAge = "min_age"
        case additionalContition = "additional_contition"
        case certification
        case maxGuest = "max_guest"
        case price
        case ratingScore = "rating_score"
        case state
    }
}

// MARK: - Provide
struct Provide: Codable {
    let provideSet: Int
    let provideDescription: String
    
    enum CodingKeys: String, CodingKey {
        case provideSet = "provide_set"
        case provideDescription = "description"
    }
}

// MARK: - Schedule
struct Schedule: Codable {
    let id: Int
    let startDatetime, endDatetime: String
    let capacity, nowGuestCount: Int
    let active: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case startDatetime = "start_datetime"
        case endDatetime = "end_datetime"
        case capacity
        case nowGuestCount = "now_guest_count"
        case active
    }
}

// MARK: - TripReview
struct TripReview: Codable {
    let userSet, tripReviewDescription: String
    let ratingScore: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case userSet = "user_set"
        case tripReviewDescription = "description"
        case ratingScore = "rating_score"
        case createdAt = "created_at"
    }
}

