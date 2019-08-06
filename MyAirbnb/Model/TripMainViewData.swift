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
    let mainCategories: [MainCategory]
    let globalAdventureTrip, globalRecommendTrip: [BestTrip]
    let stateArray: [State]
    
    enum CodingKeys: String, CodingKey {
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

// MARK: - State
struct State: Codable {
    let name: String
    let url: String
    let pk: Int
}

