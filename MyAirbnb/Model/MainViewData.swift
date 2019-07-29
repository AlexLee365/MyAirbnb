//
//  MainViewData.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 24/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

protocol MainViewDataProtocol {}

struct MainViewData: MainViewDataProtocol {
    var data: [MainViewDataProtocol]
    var cellStyle: CellStyle
    
    enum CellStyle {
        case category, plus, fullImage, luxe, fourSquare
    }
}

struct Category: MainViewDataProtocol {
    let image: UIImage
    let title: String
    let subTitle: String
}


struct HouseDataInList: MainViewDataProtocol {
    let id: Int
    let houseImage: UIImage?
    let houseGarde: String = "default"
    let houseType: String
    let houseLocation: String
    let houseName: String
    var houseTotalRate: Double
    var houseRateCount: Int = 0
    let hostGrade: String = "default"
    
    func drawStarsWithHouseRate() -> String {
        var starCount = 0
        
        switch houseTotalRate {
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

struct HousePlusDataInList: MainViewDataProtocol {
    let houseMainImage: UIImage?
    let houseImageString: [String]
    let houseLocation: String
    let houseName: String
    var houseTotalRate: Double
    var houseRateCount: Int
    
    func drawStarsWithHouseRate() -> String {
        var starCount = 0
        
        switch houseTotalRate {
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

struct HouseLuxeDataInList: MainViewDataProtocol {
    let houseMainImage: UIImage?
    let houseImageString: [String]
    let houseLocation: String
    let houseName: String
}
