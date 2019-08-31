//
//  HouseDatasInList.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 30/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

protocol HouseViewDataProtocol {}
protocol MainViewDataProtocol {}

struct MainViewData {
    var data: [MainViewDataProtocol]
    var cellStyle: CellStyle
    
    enum CellStyle {
        case category, plus, fullImage, luxe, fourSquare
    }
}

struct HouseViewData {
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
    let image, image1, image2, image3, image4: String
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

struct HouseIntroLabelDataInList: HouseViewDataProtocol {
    let intro: String
}

struct HouseTitleLabelDataInList: HouseViewDataProtocol {
    let title: String
}

struct UsersLikeHouseList {
    var id: Int
    var title: String
    var state: String
    var roomType: String
    var image, image1, image2, image3, image4: String
    
    var bedroom: Int
    var price: Int
    var totalRating: Double
    
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


// 기존 룩스숙소 가데이터 구조체
//struct HouseLuxeDataInList: MainViewDataProtocol, HouseViewDataProtocol {
//    let houseMainImage: UIImage?
//    let houseImageString: [String]
//    let houseLocation: String
//    let houseName: String
//}

// 가데이터 생성 부분
//    private func createLuxeHouseData() {
//        let imageArray = ["luxeHouseSample1", "luxeHouseSample2", "luxeHouseSample3", "luxeHouseSample4", "luxeHouseSample5"]
//        let luxeHouseData = [
//            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[0]),
//                                houseImageString: imageArray,
//                                houseLocation: "우븟",
//                                houseName: "Villa Kelusa Modern thatch-roofed estate overlokking jungle"),
//            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[1]),
//                                houseImageString: imageArray,
//                                houseLocation: "The BIGHT",
//                                houseName: "Atelier House Gated modern villa above the sea"),
//            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[2]),
//                                houseImageString: imageArray,
//                                houseLocation: "PUNTA MITA",
//                                houseName: "Casa Koko Contemporary craft architecture on the beach"),
//            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[3]),
//                                houseImageString: imageArray,
//                                houseLocation: "MONTEGO FREEPORT",
//                                houseName: "Afimi Jamaican Villa Rental"),
//            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[4]),
//                                houseImageString: imageArray,
//                                houseLocation: "EL JOBO",
//                                houseName: "Su Casa Contemporary villa above Playa Rajada"),
//        ]
//        mainViewDataArray.append(MainViewData(data: luxeHouseData, cellStyle: .luxe))
//    }


// 기존 플러스숙소 가데이터 구조체
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

// 가데이터 생성 부분
//    private func createPlusHouseData() {
//        let imageArray = ["plusHouseSample1", "plusHouseSample2", "plusHouseSample3", "plusHouseSample4", "plusHouseSample5"]
//        let housePlusDataArray: [HousePlusDataInList] = [
//            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[0]),
//                                houseImageString: imageArray,
//                                houseLocation: "아테네",
//                                houseName: "Stay on a Working Flower Farm in a Modern Home",
//                                houseTotalRate: 5,
//                                houseRateCount: 65),
//            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[1]),
//                                houseImageString: imageArray,
//                                houseLocation: "멕시코시티",
//                                houseName: "Elegant Art Deco Home with Garden in Condesa",
//                                houseTotalRate: 3.5,
//                                houseRateCount: 30),
//            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[2]),
//                                houseImageString: imageArray,
//                                houseLocation: "오스틴",
//                                houseName: "Historic Casa Cartel - Austin Villa with Courtyard Pool",
//                                houseTotalRate: 4.3,
//                                houseRateCount: 103),
//            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[3]),
//                                houseImageString: imageArray,
//                                houseLocation: "ToberMory",
//                                houseName: "Unique and Secluded AirShip with breathtaking Highland Views",
//                                houseTotalRate: 4.6,
//                                houseRateCount: 99),
//            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[4]),
//                                houseImageString: imageArray,
//                                houseLocation: "조슈아 트리",
//                                houseName: "Dome in the Desert in Joshua Tree",
//                                houseTotalRate: 3.2,
//                                houseRateCount: 49),
//        ]
//        mainViewDataArray.append(MainViewData(data: housePlusDataArray, cellStyle: .plus))
//    }
