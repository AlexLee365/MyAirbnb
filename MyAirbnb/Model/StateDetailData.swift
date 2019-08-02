//
//  StateDetailData.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

struct StateDetailData: Codable {
    let stateDetail: StateDetail
    let subTripCategory: [SubTripCategory]
    let randomRecommendTrip12, bestTrip: [BestTrip]
    
    enum CodingKeys: String, CodingKey {
        case stateDetail = "state_detail"
        case subTripCategory = "sub_trip_category"
        case randomRecommendTrip12 = "random_recommend_trip12"
        case bestTrip = "best_trip"
    }
}

// MARK: - BestTrip
struct BestTrip: Codable {
    let name: String
    let image1: String?
    let ratingScore, durationTime: Int
    let provides: [String?]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case image1 = "image_1"
        case ratingScore = "rating_score"
        case durationTime = "duration_time"
        case provides, url
    }
}

// MARK: - StateDetail
struct StateDetail: Codable {
    let name: String
    let trips: [BestTrip]
}

// MARK: - SubTripCategory
struct SubTripCategory: Codable {
    let id: Int
    let category, state, name: String
    let image1, image2, image3: String?
    let subTripCategoryDescription: String
    
    enum CodingKeys: String, CodingKey {
        case id, category, state, name
        case image1 = "image_1"
        case image2 = "image_2"
        case image3 = "image_3"
        case subTripCategoryDescription = "description"
    }
}



