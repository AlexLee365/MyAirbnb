//
//  AllTripData.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

// MARK: - AllTripDatum
struct AllTripData: Codable {
    let name: String
    let image1: String?
    let ratingScore: Double
    let language: String
    let durationTime: Int
    let provides: [String]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case image1 = "image_1"
        case ratingScore = "rating_score"
        case language
        case durationTime = "duration_time"
        case provides, url
    }
}

