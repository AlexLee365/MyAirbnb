//
//  TripDetailData.swift
//  MyAirbnb
//
//  Created by Solji Kim on 04/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

// MARK: - TripDetailData
struct TripDetailData: Codable {
    let tripDetail: TripDetail
    let myReservation: [String]
    
    enum CodingKeys: String, CodingKey {
        case tripDetail = "trip_detail"
        case myReservation = "my_reservation"
    }
}

// MARK: - TripDetail
struct TripDetail: Codable {
    let pk: Int
    let name, subCategory, detailCategory, state: String
    let durationTime: Int
    let language: String
    let provides: [Provide?]
    let schedules: [Schedule]
    let tripReviews: [TripReview]
    let host: Host
    let hostAbout, program, additionalCondition: String
    let guestMaterial, address, placeInfo: String
    let minAge, maxGuest: Int
    let certification: Bool
    let price, ratingScore: Int
    let compatibility, strength, technic: String
    let image1, image2, image3, image4, image5, image6, image7: String?
    var scrollImagesArray = [UIImage]()
    
    enum CodingKeys: String, CodingKey {
        case pk, name
        case subCategory = "sub_category"
        case detailCategory = "detail_category"
        case state
        case durationTime = "duration_time"
        case language, provides, schedules
        case tripReviews = "trip_reviews"
        case host
        case hostAbout = "host_about"
        case program
        case additionalCondition = "additional_condition"
        case guestMaterial = "guest_material"
        case address
        case placeInfo = "place_info"
        case minAge = "min_age"
        case maxGuest = "max_guest"
        case certification, price
        case ratingScore = "rating_score"
        case compatibility, strength, technic
        case image1 = "image_1"
        case image2 = "image_2"
        case image3 = "image_3"
        case image4 = "image_4"
        case image5 = "image_5"
        case image6 = "image_6"
        case image7 = "image_7"
    }
}

// MARK: - Host
struct Host: Codable {
    let username: String
    let image: String
}

// MARK: - Provide
struct Provide: Codable {
    let provideSet, provideDescription: String
    
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

