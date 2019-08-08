//
//  TripMainViewData.swift
//  MyAirbnb
//
//  Created by Solji Kim on 02/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

// MARK: - TripMainViewData
struct TripMainViewData: Codable {
    let representationTrip5: [RepresentationTrip5]
    let mainCategories: [MainCategory]
    let globalAdventureTrip: [GlobalTrip]
    let globalRecommendTrip: [BestTrip]
    let stateArray: [State]
    
    enum CodingKeys: String, CodingKey {
        case representationTrip5 = "representation_trip_5"
        case mainCategories = "main_categories"
        case globalAdventureTrip = "global_adventure_trip"
        case globalRecommendTrip = "global_recommend_trip"
        case stateArray = "state"
    }
}


// MARK: - MainCategory
struct MainCategory: Codable {
    let url: String
    let name: String
    let image: String?
    let mainCategoryDescription: String
    
    enum CodingKeys: String, CodingKey {
        case url, name, image
        case mainCategoryDescription = "description"
    }
}

// MARK: - RepresentationTrip5
struct RepresentationTrip5: Codable {
    let name, category, image1: String
    let url: String
    let host: Host
    let additional: [AdventureAdditional]
    
    enum CodingKeys: String, CodingKey {
        case name, category
        case image1 = "image_1"
        case url, host, additional
    }
}

// MARK: - Additional
struct AdventureAdditional: Codable {
    let trip: Int
    let media: String
    let additionalDescription: String
    let image1: String?
    
    enum CodingKeys: String, CodingKey {
        case trip, media
        case additionalDescription = "description"
        case image1 = "image_1"
    }
}

// MARK: - GlobalTrip
struct GlobalTrip: Codable {
    let name: String
    let image1: String?
    let state: GlobalAdventureTripState
    let ratingScore: Double
    let reviewCount: Int
    let detailCategory: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case image1 = "image_1"
        case state
        case ratingScore = "rating_score"
        case reviewCount = "review_count"
        case detailCategory = "detail_category"
        case url
    }
}

// MARK: - GlobalAdventureTripState
struct GlobalAdventureTripState: Codable {
    let name: String
}

// MARK: - State
struct State: Codable {
    let name: String
    let url: String
    let pk: Int
}



