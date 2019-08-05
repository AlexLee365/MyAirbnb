//
//  GetToken.swift
//  MyAirbnb
//
//  Created by 김광준 on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class GetToken {
    
    func getTokenFromDB(username: String, password: String, completion: @escaping (Result<(String, Int), netWorkError>) -> ()) {
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
                    print("🔵🔵🔵 parsonJson Data: ", parseJSON)
                    guard let accessToken = parseJSON["token"] as? String
                        , let idNumber = parseJSON["user"] as? Int else {
                        // 토큰 받아오기 실패 시
                        completion(.failure(.jsonObjectError))
                        return
                    }
                    //                    let userID = parseJSON["uesr"] as? Int
                    print("🔵🔵🔵 Access Token: \(String(describing: accessToken))")
                    
                    completion(.success((accessToken, idNumber)))    // 토큰 받아오기 성공 시
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
