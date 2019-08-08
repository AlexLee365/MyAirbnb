//
//  LikeButton.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/08.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

enum LikeButtonContentType {
    case room
    case trip
}

class LikeButton: UIButton {
    var contentID: Int {
        didSet {
            if SingletonCommonData.shared.usersLikeRoomNumbersArray.contains(contentID) {
                isSelected = true
            }
        }
    }
    var contentType: LikeButtonContentType
    
    var houseData: HouseDataInList?
    
    let netWork = NetworkCommunicator()
    
    override init(frame: CGRect) {
        contentID = 0
        contentType = .room
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(contentID: Int, contentType: LikeButtonContentType) {
        self.init()
        self.contentID = contentID
        self.contentType = contentType
        
        setImage(UIImage(named: "heartDefault2"), for: .normal)
        setImage(UIImage(named: "heartSelected2"), for: .selected)
        addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
    }
    
    @objc private func buttonDidTap() {
        isSelected.toggle()
        print("LikeButton ContentID: \(contentID) / ContentType: \(contentType)")
        
        switch isSelected {
        case true:
            //눌러서 셀렉트가됨 => 좋아요가됨 => POST
            postAndDeleteRoomLikeData(httpMethod: "POST")
            
            
        case false:
            // 눌러서 해제됨 => 좋아요가 제거됨 => DELETE
            postAndDeleteRoomLikeData(httpMethod: "DELETE")
        }
    }
    
    func resetContentIDAndTypeAndHouseData(contentID: Int, contentType: LikeButtonContentType, houseData: HouseDataInList) {
        self.contentID = contentID
        self.contentType = contentType
        self.houseData = houseData
    }
    
    
    private func postAndDeleteRoomLikeData(httpMethod: String) {
        
        let userToken = UserDefaults.standard.string(forKey: SingletonCommonData.userDefaultTokenKey) ?? ""
        let urlString = netWork.basicUrlString + "/rooms/like/\(contentID)" + ((httpMethod == "POST") ? "/" : "")
        
        guard let url = URL(string: urlString) else {
            print("‼️ makeReservation URL convert ")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("Token \(userToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print("‼️ post UrlSession error "); return }
            guard let data = data
                , let jsonObject = try? JSONSerialization.jsonObject(with: data) else {
                    print("‼️ data, json convert error ")
                    return
            }
            
            //            guard let reservation = try? JSONDecoder().decode(Reservation.self, from: data) else { print("‼️ : "); return }
            //            SingletonCommonData.shared.userInfo?.reservations.append([SingletonCommonData.shared.makeRandomString(): reservation])
            
            print("🔵🔵🔵 After Reservation get Data: ", jsonObject)
            //            print("After Converting: ", reservation)
            
            }.resume()
    }
    
    
    
}
