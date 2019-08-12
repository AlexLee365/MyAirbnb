//
//  SpecialTripData.swift
//  MyAirbnb
//
//  Created by Solji Kim on 09/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

struct SpecialTripData {
    var image: String
    var title: String
    var desc: String
}

let specialTripDatas: [SpecialTripData] = [
    SpecialTripData(image: "airbnb_adventure", title: "에어비앤비 어드벤처", desc: "호스트의 안내를 받아 특별한 장소로 떠나는 여행. 오셔서 즐기기만 하시면 됩니다."),
    SpecialTripData(image: "eat_trip", title: "식도락 여행", desc: "요리 전문가가 이끄는 투어로 전 세계 다향한 도시의 매력에 푹 빠져보세요."),
    SpecialTripData(image: "cooking_class", title: "쿠킹 클래스", desc: "현지 전문가의 지도를 받아 내 손으로 직접 현지 음식을 만들고 맛보세요."),
    SpecialTripData(image: "surfing", title: "서핑", desc: "세계서핑리그(WSL)가 선정하고 프로 서핑 선수가 진행하는 트립에 참여해 서핑을 즐겨보세요."),
    SpecialTripData(image: "special_concert", title: "콘서트", desc: "독특한 공간에서 열리는 소규모 공연으로 리듬에 빠져들며 라이브 음악의 신세계를 경험하세요."),
    SpecialTripData(image: "goodtrip", title: "착한 트립", desc: "좋은 일도 하고 새로운 경험도 하는 일석이조의 기회! 예약금 전액이 비영리 단체로 기부됩니다.")
]
