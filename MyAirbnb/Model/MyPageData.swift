//
//  MyPageData.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

struct MyPageData {
    var title: String
    var icon: String
    var subTitle: String
}

let myPageDatas = [MyPageData(title: "알림", icon: "bell", subTitle: ""),
                   MyPageData(title: "친구를 초대하세요", icon: "invite", subTitle: "다음 번 여행 경비를 벌어보세요."),
                   MyPageData(title: "호스트 추천하기", icon: "invite", subTitle: "호스트를 추천하고 한 명당 ₩18,069을 적립하세요"),
                   MyPageData(title: "여행 크레딧과 쿠폰", icon: "credit", subTitle: ""),
                   MyPageData(title: "트립 호스팅하기", icon: "hosting", subTitle: ""),
                   MyPageData(title: "설정", icon: "setting", subTitle: ""),
                   MyPageData(title: "도움말", icon: "help", subTitle: ""),
                   MyPageData(title: "호스팅에 관해 알아보기", icon: "apply", subTitle: "월간 최대 ₩1,181,576의 수입을 올리세요"),
                   MyPageData(title: "숙소 등록하기", icon: "apply", subTitle: ""),
                   MyPageData(title: "Siri 단축키", icon: "shortcut", subTitle: ""),
                   MyPageData(title: "피드백 남기기", icon: "feedback", subTitle: ""),
                   MyPageData(title: "로그아웃", icon: "", subTitle: "")]
