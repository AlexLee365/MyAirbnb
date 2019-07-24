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
        case category, recommend, fullImage, luxe, fourSquare
    }
}

struct Category: MainViewDataProtocol {
    let image: UIImage
    let title: String
    let subTitle: String
}


struct HouseDataInList: MainViewDataProtocol {
    let id: Int
    let houseImage: UIImage
    let houseGarde: String = "default"
    let houseName: String
    var houseTotalRate: Double
    var houseRateCount: Int = 0
    let hostGrade: String = "default"
    
    //    init(houseImage: String, houseGrade: String, houseName: String, houseTotalRate: Double, houseRateCount: Int, houseGrade: String) {
    //        self.houseImage = houseImage
    //        self.
    //    }
    
    
}

