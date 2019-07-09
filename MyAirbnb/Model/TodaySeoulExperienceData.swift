//
//  TodaySeoulExperienceData.swift
//  MyAirbnb
//
//  Created by Solji Kim on 09/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

struct TodaySeoulExperienceData {
    var image: String
    var category: String
    var title: String
    var desc: String
    var lang: String
    var rate: Double?
    var noOfReview: Int?
}

let todaySeoulExperienceDatas: [TodaySeoulExperienceData] = [
    
    TodaySeoulExperienceData(image: "kimchi", category: "쿠킹 클래스 • 서울", title: "홍대에서 김치 만들기", desc: "2.5시간 • 음식, 음료, 장비 포함", lang: "영어로 진행", rate: 4.97, noOfReview: 337),
    
    TodaySeoulExperienceData(image: "hiphop", category: "댄스 수업 · 서울", title: "서울 홍대 힙합 댄스 수업", desc: "1.5시간 · 음료 포함", lang: "영어로 진행", rate: 5.0, noOfReview: 2),
    
    TodaySeoulExperienceData(image: "gangnam", category: "문화 도보 여행 · 서울", title: "달빛 아래에서 강남 도보 여행", desc: "2시간 · 교통현, 장비 포함", lang: "영어로 진행", rate: 4.96, noOfReview: 276),
    
    TodaySeoulExperienceData(image: "makeup", category: "스타일링 · 서울", title: "강남 스타일:K-뷰티 개인 메이크업 세션", desc: "2시간 · 음료, 장비, 입장권 1매 포함", lang: "영어로 진행", rate: 5.0, noOfReview: 1)
]
