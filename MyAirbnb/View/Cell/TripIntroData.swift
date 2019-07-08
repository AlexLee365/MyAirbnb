//
//  TripIntroData.swift
//  MyAirbnb
//
//  Created by Solji Kim on 08/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

struct TripIntroData {
    var image: String
    var category: String
    var title: String
    var hostName: String
}

let tripIntroDatas: [TripIntroData] = [
    TripIntroData(image: "adventure", category: "어드벤처", title: "갈라파고스 슬로푸드 사파리", hostName: "Jill & Javier"),
    TripIntroData(image: "kayak", category: "어드벤처", title: "카약을 타고 만나는 스웨덴의 다양한 섬", hostName: "Helena"),
    TripIntroData(image: "boxer", category: "복싱", title: "세계 챔피언 '파이어'와 함께 권투하기", hostName: "Keisher"),
    TripIntroData(image: "concert", category: "콘서트", title: "워털루의 숨겨진 재즈 클럽", hostName: "Theo And Jannine"),
    TripIntroData(image: "lp", category: "역사 투어", title: "LP판의 마스터", hostName: "DJ Jigüe")
]
