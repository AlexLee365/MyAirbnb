//
//  LoginPost.swift
//  MyAirbnb
//
//  Created by 김광준 on 29/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import UIKit

func loginPost(username: String, password: String, firstName: String, lastName: String) {
    print("\n---------- [ Post Method ] ----------\n")
    let todoEndpoint = "http://airbnb.tthae.com/api/accounts/user/"
    let urlComp = URLComponents(string: todoEndpoint)
    
    guard let url = urlComp?.url else {
        return print("Error: cannot create URL")
    }
    // 회원가입
    let body = "username=\(username)&password=\(password)&firstName=\(firstName)&lastName=\(lastName)".data(using: String.Encoding.utf8, allowLossyConversion: false)
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.httpBody = body
    
    //URLSession 이걸 네트워크 작업.
    // escaping (비동기) completion =>
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        guard error == nil else {
            print(error!.localizedDescription)
            return
        }
        guard let response = response as? HTTPURLResponse,
            200..<300 ~= response.statusCode ,
            response.mimeType == "application/json"
            else {
                print("StatusCode is not valid")
                return
        }
        guard let data = data else {
            print("Error: did not receive data")
            return
        }
        guard let todo = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else {
            print("Could not get parsed data")
            return
        }
        print(response.statusCode)
        print(todo)
    }
    task.resume()
}
