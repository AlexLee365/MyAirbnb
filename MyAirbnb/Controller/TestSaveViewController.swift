//
//  TestSaveViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 18/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class TestSaveViewController: UIViewController {
    
      let noticeLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(noticeLabel)
        noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        noticeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noticeLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        
        noticeLabel.text = "This is testPage for SavePage"
        noticeLabel.font = .systemFont(ofSize: 14, weight: .bold)
        noticeLabel.textColor = .black
        
        
        getServerData()
    }
    
    
    let netWork = NetworkCommunicator()
    let jsonDecoder = JSONDecoder()
    
    var tripTestData = [TripTestData]()
    
    var hostAbout = ""
    
    func getServerData() {
        let urlString = netWork.basicUrlString + "/trip/"
        
        netWork.getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json, success) in
            
            guard success else {
                print("get serverData failed")
                return
            }
            
            guard let data = try? JSONSerialization.data(withJSONObject: json) else {
                print("‼️ moveToHouseDetail noti data convert error")
                return
            }
            
            guard let result = try? self.jsonDecoder.decode([TripTestData].self, from: data) else {
                print("‼️ moveToHouseDetail noti result decoding convert error")
                return
            }
            
            self.tripTestData = result
            
            print(self.tripTestData[0].hostAbout)
            
//            self.tripTestData.forEach {
//                self.hostAbout = $0.hostAbout
//                print(self.hostAbout)
//            }
            
            
        }
    }
  
}
