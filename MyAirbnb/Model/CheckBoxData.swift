//
//  CheckBoxData.swift
//  MyAirbnb
//
//  Created by Solji Kim on 22/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

struct CheckBoxData {
    let title: String
    var contentArray: [Content]
    let buttonTitle: String?
    var seeAllBtnState: Bool = false
}

struct Content {
    let type: String
    var checkBoxState: Bool
}


//let checkBoxDatas: [CheckBoxData] = [
//    CheckBoxData(title: "편의시설",
//                 contentArray: [Content(type: "주방", checkBoxState: false),
//                                Content(type: "샴푸", checkBoxState: false),
//                                Content(type: "난방", checkBoxState: false),
//                                Content(type: "에어컨", checkBoxState: false),
//                                Content(type: "세탁기", checkBoxState: false),
//                                Content(type: "건조기", checkBoxState: false),
//                                Content(type: "무선 인터넷", checkBoxState: false),
//                                Content(type: "아침식사", checkBoxState: false),
//                                Content(type: "실내 벽난로", checkBoxState: false),
//                                Content(type: "옷걸이", checkBoxState: false),
//                                Content(type: "다리미", checkBoxState: false),
//                                Content(type: "헤어드라이어", checkBoxState: false),
//                                Content(type: "노트북 작업 공간", checkBoxState: false),
//                                Content(type: "TV", checkBoxState: false),
//                                Content(type: "아기침대", checkBoxState: false)],
//                 buttonTitle: "편의시설 모두 보기", seeAllBtnState: false),
//    
//    CheckBoxData(title: "시설",
//                 contentArray: [Content(type: "건물 내 무료 주차", checkBoxState: false),
//                                Content(type: "헬스장", checkBoxState: false),
//                                Content(type: "자쿠지", checkBoxState: false),
//                                Content(type: "수영장", checkBoxState: false)],
//                 buttonTitle: "시설 모두 보기", seeAllBtnState: false),
//    
//    CheckBoxData(title: "건물 유형",
//                 contentArray: [Content(type: "주택", checkBoxState: false),
//                                Content(type: "아파트", checkBoxState: false),
//                                Content(type: "B&B", checkBoxState: false),
//                                Content(type: "부티크 호텔", checkBoxState: false),
//                                Content(type: "게스트 스위트", checkBoxState: false),
//                                Content(type: "게스트용 별채", checkBoxState: false),
//                                Content(type: "로프트", checkBoxState: false)],
//                 buttonTitle: "건물 유형 모두 보기", seeAllBtnState: false),
//    
//    CheckBoxData(title: "특색 있는 숙소",
//                 contentArray: [Content(type: "기차", checkBoxState: false),
//                                Content(type: "농장 체험 숙박", checkBoxState: false),
//                                Content(type: "담무소(이탈리아)", checkBoxState: false),
//                                Content(type: "돔하우스", checkBoxState: false),
//                                Content(type: "동굴", checkBoxState: false),
//                                Content(type: "등대", checkBoxState: false)],
//                 buttonTitle: "특색 있는 숙소 모두 보기", seeAllBtnState: false),
//    
//    CheckBoxData(title: "숙소 이용규칙",
//                 contentArray: [Content(type: "이벤트/행사 가능", checkBoxState: false),
//                                Content(type: "반려동물 입실 가능", checkBoxState: false),
//                                Content(type: "흡연 가능", checkBoxState: false)],
//                 buttonTitle: nil, seeAllBtnState: false)
//]
