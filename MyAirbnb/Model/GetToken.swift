//
//  GetToken.swift
//  MyAirbnb
//
//  Created by 김광준 on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class GetToken {
    
    func getTokenFromDB(username: String, password: String, vc: UIViewController) -> () {
        print("\n---------- [Request Get_Token Method ] ----------\n")
        
        let myUrl = URL(string: "http://airbnb.tthae.com/api/accounts/get_token/")
        
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let postString = ["username" : username, "password" : password] as [String : String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    let accessToken = parseJSON["token"] as? String
                    //                    let userID = parseJSON["uesr"] as? Int
                    print("🔵🔵🔵 Access Token: \(String(describing: accessToken!))")
                    
                    
                    if (accessToken?.isEmpty)! {
                        print("could not successful get Token")
                        return
                    }
                    
                    DispatchQueue.main.sync {
                        // 토큰이 성공적으로 받아지면 메인 페이지로 이동 하게되는 코드 작성
                        // 테스트용 빈 페이지 띄우기
                        let sucessVC = SucessViewController()
                        vc.present(sucessVC, animated: true, completion: nil)
                        
                        // 알림 뷰 컨트롤러로 가기
                        //                        let AlarmVC = AlarmConfirmViewController()
                        //                        self.navigationController?.pushViewController(AlarmVC, animated: true)
                        
                        // 인디케이터 커스텀 해서 넣어야 함
                    }
                    
                } else {
                    return
                        print("Error: Access Token")
                }
                
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
}
