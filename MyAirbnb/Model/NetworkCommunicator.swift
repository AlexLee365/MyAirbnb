//
//  NetworkCommunicator.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 24/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import Kingfisher

enum netWorkError: Error {
    case badUrl, responseError, decodingError, jsonObjectError
}

class NetworkCommunicator {
    let basicUrlString = "http://airbnb.tthae.com/api"
    private let kingfisher = ImageDownloader.default
    private let jsonDecoder = JSONDecoder()
    
    let userToken = UserDefaults.standard.string(forKey: SingletonCommonData.userDefaultTokenKey) ?? ""
    let userNumber = UserDefaults.standard.integer(forKey: SingletonCommonData.userDefaultIDNumber)
    
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
            
            print("⭐️⭐️ \(#file)-\(#function)-\(#line)  \n[getJsonObjectFromAPI] Success!! ")
            completion(jsonObject, true)
            }.resume()
    }
    
    func getServerDataWithToken(urlString: String, completion: @escaping (Result<Data, netWorkError>) -> ()) {
        guard let url = URL(string: urlString) else { print("‼️ getLoginedUserData url convert "); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Token \(userToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("[getLoginedUserData] dataTask error!!")
                print(error!.localizedDescription)
                completion(.failure(.badUrl))
                return
            }
            
            guard let responseConverted = response as? HTTPURLResponse,
                (200..<300).contains(responseConverted.statusCode),
                responseConverted.mimeType == "application/json"
                else {
                    print("[getLoginedUserData] response error!!")
                    print(response)
                    completion(.failure(.responseError))
                    return
            }
            
            guard let data = data else {
                print("[getLoginedUserData] data convert error")
                completion(.failure(.badUrl))
                return
            }
           
            print("⭐️⭐️ \(#file)-\(#function)-\(#line)  \n[getServerDataWithToken] Success!! ")
            completion(.success(data))
            }.resume()
    }
    
    
    func getUrlFromKoreanText(urlString: String) -> URL? {
        guard let translateAPIString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: translateAPIString)
            else { print("[getUrlFromKoreanText] convertUrl failed"); return nil }
        return url
    }
    
    func getUIImageArrayFromUrlStringArray(imageUrlStringArray: [String], completion: @escaping ([UIImage]) -> ()) {
        var imageArray = [UIImage]()
        for (index, urlString) in imageUrlStringArray.enumerated() {
            guard let url = URL(string: urlString) else { print("‼️ networkCommunicator getuiimage url convert "); return }
            kingfisher.downloadImage(with: url) { (result) in
                switch result {
                case .success(let value):
                    imageArray.append(value.image)
                case .failure(let error):
                    print("networkCommunicator result error: ", error.localizedDescription)
                }
                (index == imageUrlStringArray.count-1) ? completion(imageArray) : ()
            }
        }
    }
    
    
    
    func getHouseServerData(urlString: String, completion: @escaping ([HouseDataInList]?, Bool) -> ()) {
        getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json, success) in
            guard success else {
                print("‼️ NetWorkCommunicator success failed")
                completion(nil, false)
                return
            }
            
            guard let object = json as? [String: Any]
                , let resultArray = object["results"] as? [[String: Any]] else {
                    print("‼️ NetWorkCommunicator object convert error")
                    completion(nil, false)
                    return
            }
            
            guard let data = try? JSONSerialization.data(withJSONObject: resultArray) else {
                print("‼️ NetWorkCommunicator data convert error")
                completion(nil, false)
                return
            }
            
            guard var houseArray = try? self.jsonDecoder.decode([HouseDataInList].self, from: data)
                , houseArray.count > 0 else {
                    print("‼️ NetWorkCommunicator HouseDataInList decoding error")
                    completion(nil, false)
                    return
            }
            
            for i in 0..<houseArray.count {
                guard let url = URL(string: houseArray[i].image) else { print("‼️ NetWorkCommunicator kingfisher url error"); return }
                self.kingfisher.downloadImage(with: url, completionHandler: { (result) in
                    switch result {
                    case .success(let value):
                        houseArray[i].imageArray.append(value.image)
                    case .failure(let error):
                        print("‼️ LaunchVC kinfisher: ", error.localizedDescription)
                    }
                    (i == houseArray.count - 1) ? completion(houseArray, true) : ()
                })
            }
        }
    }
    
    func getStateDataWithText(urlString: String, completion: @escaping ([String]?, Bool) -> ()) {
        getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json, success) in
            guard success else {
                print("‼️ NetWorkCommunicator success failed")
                completion(nil, false)
                return
            }
            
            guard let object = json as? [[String: Any]] else {
                print("‼️ NetWorkCommunicator object convert error")
                completion(nil, false)
                return
            }
            
            guard let result = (object.map{ $0["name"] }) as? [String] else {
                print("‼️ result convret error ")
                return
            }
            
            completion(result, true)
        }
    }
    
}
