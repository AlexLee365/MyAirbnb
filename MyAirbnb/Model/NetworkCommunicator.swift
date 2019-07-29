//
//  NetworkCommunicator.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 24/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class NetworkCommunicator {
    let basicUrlString = "http://airbnb.tthae.com/api"
    
    func getJsonObjectFromAPI(urlString: String = "", urlForSpecificProcessing incomingUrl: URL?, completion: @escaping (Any, _ success: Bool) -> ()) {
        // url 매개변수 값을 넣으면 url로 URLSession API호출 진행 (밖에서 url을 별도 처리해주고 넣어줘야할경우 사용)
        // url 값이 들어오지않으면 urlString으로 API호출 진행
        
        guard let url = (incomingUrl == nil) ? URL(string: urlString) : incomingUrl else { return }
        // url 매개변수값을 넣지않아 없으면 urlString값을 url로 변환하여 API호출 : url 값이 들어왔을 경우 들어온 incomingUrl로 API호출
        
        let urlSessionConfig = URLSessionConfiguration.default
        urlSessionConfig.timeoutIntervalForRequest = 30
        urlSessionConfig.timeoutIntervalForResource = 30
        
        let session = URLSession(configuration: urlSessionConfig)
        session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("[getJsonObjectFromAPI] dataTask error!!")
                print(error!.localizedDescription)
                completion("", false)
                return
            }
            
            guard let responseConverted = response as? HTTPURLResponse,
                (200..<300).contains(responseConverted.statusCode),
                responseConverted.mimeType == "application/json"
                else {
                    print("[getJsonObjectFromAPI] response error!!")
                    print(response)
                    completion("", false)
                    return
            }
            
            guard let data = data else {
                print("[getJsonObjectFromAPI] data convert error")
                completion("", false)
                return
            }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) else {
                print("[getJsonObjectFromAPI] json convert error")
                completion("", false)
                return
            }
            
            print("⭐️⭐️ \(#file)-\(#function)-\(#line)  \n[jsonObject 데이터 결과]: ", jsonObject)
            completion(jsonObject, true)
        }.resume()
    }
    
    func getUrlFromKoreanText(urlString: String) -> URL? {
        guard let translateAPIString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: translateAPIString)
            else { print("[getUrlFromKoreanText] convertUrl failed"); return nil }
        return url
    }
}
