//
//  HouseDatasInList.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 30/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

protocol MainViewDataProtocol {}
protocol HouseViewDataProtocol {}

struct MainViewData: MainViewDataProtocol {
    var data: [MainViewDataProtocol]
    var cellStyle: CellStyle
    
    enum CellStyle {
        case category, plus, fullImage, luxe, fourSquare
    }
}

struct HouseViewData: HouseViewDataProtocol {
    var data: [HouseViewDataProtocol]
    var cellStyle: CellStyle
    
    enum CellStyle {
        case introLabel, luxe, plus, titleLabel, normalHouse
    }
}

struct Category: MainViewDataProtocol {
    let image: UIImage
    let title: String
    let subTitle: String
}

struct HouseDataInList: Codable, MainViewDataProtocol, HouseViewDataProtocol {
    let id: Int
    let host, title: String
    let image, image1, image2, image3: String
    let image4: String
    let price: Int
    let houseDescription, roomType, space: String
    let totalRating: Double
    let bedroom, beds, bathroom, capacity: Int
    let bathType, address: String
    let reservations: Int
    let state: String
    let label, superHost: String?
    let facilities: [String]
    var imageArray: [UIImage] = []
    
    enum CodingKeys: String, CodingKey {
        case id, host, title, image
        case image1 = "image_1"
        case image2 = "image_2"
        case image3 = "image_3"
        case image4 = "image_4"
        case price
        case houseDescription = "description"
        case roomType = "room_type"
        case space
        case totalRating = "total_rating"
        case bedroom, beds, bathroom, capacity
        case bathType = "bath_type"
        case address, reservations, state, label
        case superHost = "super_host"
        case facilities
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

// 기존 플로스숙소 가데이터 구조체
//struct HousePlusDataInList: MainViewDataProtocol, HouseViewDataProtocol {
//    let houseMainImage: UIImage?
//    let houseImageString: [String]
//    let houseLocation: String
//    let houseName: String
//    var houseTotalRate: Double
//    var houseRateCount: Int
//
//    func drawStarsWithHouseRate() -> String {
//        var starCount = 0
//
//        switch houseTotalRate {
//        case 0..<1.1:
//            starCount = 1
//        case 1.1..<2.1:
//            starCount = 2
//        case 2.1..<3.1:
//            starCount = 3
//        case 3.1..<4.1:
//            starCount = 4
//        case 4.1...5:
//            starCount = 5
//        default:
//            starCount = 5
//        }
//        return String(repeating: "★", count: starCount)
//    }
//}

struct HousePlusDataInList: Codable, MainViewDataProtocol, HouseViewDataProtocol {
    let id: Int
    let host, title: String
    let image, image1, image2, image3: String
    let image4: String
    let price: Int
    let houseDescription, roomType, space: String
    let totalRating: Double
    let bedroom, beds, bathroom, capacity: Int
    let bathType, address: String
    let reservations: Int
    let state: String
    let label, superHost: String?
    let facilities: [String]
    var imageArray: [UIImage] = []
    
    enum CodingKeys: String, CodingKey {
        case id, host, title, image
        case image1 = "image_1"
        case image2 = "image_2"
        case image3 = "image_3"
        case image4 = "image_4"
        case price
        case houseDescription = "description"
        case roomType = "room_type"
        case space
        case totalRating = "total_rating"
        case bedroom, beds, bathroom, capacity
        case bathType = "bath_type"
        case address, reservations, state, label
        case superHost = "super_host"
        case facilities
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

struct HouseFullImagDataInList: MainViewDataProtocol {
    let title: String
    let image: UIImage?
}

// 기존 룩스숙소 가데이터 구조체
//struct HouseLuxeDataInList: MainViewDataProtocol, HouseViewDataProtocol {
//    let houseMainImage: UIImage?
//    let houseImageString: [String]
//    let houseLocation: String
//    let houseName: String
//}

struct HouseLuxeDataInList: Codable, MainViewDataProtocol, HouseViewDataProtocol {
    let id: Int
    let host, title: String
    let image, image1, image2, image3: String
    let image4: String
    let price: Int
    let houseDescription, roomType, space: String
    let totalRating: Double
    let bedroom, beds, bathroom, capacity: Int
    let bathType, address: String
    let reservations: Int
    let state: String
    let label, superHost: String?
    let facilities: [String]
    var imageArray: [UIImage] = []

    enum CodingKeys: String, CodingKey {
        case id, host, title, image
        case image1 = "image_1"
        case image2 = "image_2"
        case image3 = "image_3"
        case image4 = "image_4"
        case price
        case houseDescription = "description"
        case roomType = "room_type"
        case space
        case totalRating = "total_rating"
        case bedroom, beds, bathroom, capacity
        case bathType = "bath_type"
        case address, reservations, state, label
        case superHost = "super_host"
        case facilities
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

struct HouseIntroLabelDataInList: HouseViewDataProtocol {
    let intro: String
}

struct HouseTitleLabelDataInList: HouseViewDataProtocol {
    let title: String
}
