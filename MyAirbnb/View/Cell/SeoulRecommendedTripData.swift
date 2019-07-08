//
//  SeoulRecommendedTripData.swift
//  MyAirbnb
//
//  Created by Solji Kim on 08/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

struct SeoulRecommendedTripData {
    var image: String
    var category: String
    var title: String
    var desc: String
    var lang: String
    var rate: Double?
    var noOfReview: Int?
}

let seoulRecommendedTripDatas: [SeoulRecommendedTripData] = [
    
    SeoulRecommendedTripData(image: "bathbomb", category: "공예 클래스·서울", title: "나만의 색과 향을 담은 배쓰밤을 만들어보세요!", desc: "2시간·음료, 장비, 입장권 1매 포함", lang: "영어, 한국어로 진행", rate: 5.0, noOfReview: 36),
    
    SeoulRecommendedTripData(image: "gayageum", category: "음악 강좌·서울", title: "가야금 원데이 체험", desc: "1.5시간·음료, 입장권 1매 포함", lang: "영어, 한국어로 진행", rate: 5.0, noOfReview: 10),
    
    SeoulRecommendedTripData(image: "culture_taste", category: "명상·서울", title: "서울의 문화와 맛을 느껴보는 시간", desc: "2.5시간", lang: "영어로 진행", rate: nil, noOfReview: nil),
    
    SeoulRecommendedTripData(image: "ihwa", category: "문화 도보 여행·서울", title: "현지인과 함께 이화여자 대학교 탐방", desc: "2.5시간·음식, 음료 포함", lang: "영어로 진행", rate: 4.92, noOfReview: 51),
    
    SeoulRecommendedTripData(image: "ceramics", category: "공예 클래스·서울", title: "예술을 사랑하는 작가와 함께 하는 도자기 만들기", desc: "2시간·음료 포함", lang: "영어, 한국어로 진행", rate: 4.94, noOfReview: 78),
    
    SeoulRecommendedTripData(image: "hongdae", category: "음악 도보 여행·서울", title: "뮤지션이 들려주는 홍대와 음악 이야기", desc: "3시간·음료, 장비 포함", lang: "영어, 한국어로 진행", rate: 5.0, noOfReview: 46),
    
    SeoulRecommendedTripData(image: "sommelier", category: "시식 체험·서울", title: "소믈리에와 함게 와인&김치, 묵은지김치찜 테이스팅을 즐겨보세요", desc: "2시간·음식, 음료 포함", lang: "영어, 한국어로 진행", rate: 4.96, noOfReview: 52),
    
    SeoulRecommendedTripData(image: "hangriver", category: "자전거 타기 체험·서울", title: "자전거로 한강변 달리기 + 점심 식사", desc: "3시간·음식, 음료, 장비 포함", lang: "영어로 진행", rate: 4.95, noOfReview: 61),
    
    SeoulRecommendedTripData(image: "stamp", category: "야외 클래스·서울", title: "그녀와 함게 하는 수제도장 만들기", desc: "2시간·음식, 음료, 장비 포함", lang: "영어, 한국어로 진행", rate: 4.99, noOfReview: 72),
    
    SeoulRecommendedTripData(image: "picnic", category: "시식 체험·서울", title: "한강공원에서 피크닉 즐기기", desc: "3시간·교통편, 음식, 장비 포함", lang: "영어로 進行", rate: 5.0, noOfReview: 3)
]
