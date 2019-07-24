//
//  LaunchScreenViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 24/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class LaunchScreenViewController: UIViewController {
    
    let imageView = UIImageView()
    
    var netWork = NetworkCommunicator()
    let kingfisher = ImageDownloader.default
    
    var mainViewDataArray = [MainViewData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setAutoLayout()
        configureViewsOptions()
        createCategoryData()
        
        getServerDataTest {
            DispatchQueue.main.async {
                let tabbarVC = TabbarController()
                guard let naviVC = tabbarVC.viewControllers!.first as? UINavigationController else {
                    print("LaunchVC naviVC convert erorr")
                    return
                }
                
                guard let mainVC = naviVC.viewControllers.first as? MainViewController else {
                    print("LaunchVC mainVC convert erorr")
                    return
                }
                
                
                mainVC.mainView.mainViewDatas = self.mainViewDataArray
                
                self.present(tabbarVC, animated: false)
            }
        }
    }
    
    private func setAutoLayout() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func configureViewsOptions() {
        view.backgroundColor = .white
        imageView.image = UIImage(named: "launchImage")
        imageView.contentMode = .scaleAspectFit
    }
    
    private func getServerDataTest(completion: @escaping () -> ()) {
        let urlString = netWork.basicUrlString
            + "/rooms/?search=seoul&ordering=price&page_size=5&page=1"
        
        
        netWork.getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json) in
            guard let object = json as? [String: Any] else { print("object convert error"); return }
            
            let resultArray = object["results"] as! [[String: Any]]
            print("🔵🔵🔵 value ")
            
            var houseDataArray = [HouseDataInList]()
            for (index, roomData) in resultArray.enumerated() {
                print("index \(index)")
                guard let id = roomData["id"] as? Int
                    , let title = roomData["title"] as? String
                    , let imageString = roomData["image"] as? String
                    , let imageUrl = URL(string: imageString)
                    , let rate = roomData["total_rating"] as? Double
                    else { print("roomData convert error"); return }
                
//                self.kingfisher.downloadImage(with: imageUrl, completionHandler: { (image, error, url, data) in
//                    guard let image = image else { print("image convert error"); return }
//
//                    let houseDataInList = HouseDataInList(id: id, houseImage: image, houseName: title, houseTotalRate: rate, houseRateCount: 0)
//                    houseDataArray.append(houseDataInList)
//
//                    (index == resultArray.count-1) ? completion() : ()
//                })
                (index == resultArray.count-1) ? completion() : ()
            }
        }
    }
    
    private func createCategoryData() {
        var categoryDataArray = [Category]()
        categoryDataArray = [
            Category(image: UIImage(named: "categoryHouseImage") ?? UIImage(), title: "숙소", subTitle: "숙소"),
            Category(image: UIImage(named: "categoryTripImage") ?? UIImage(), title: "트립", subTitle: "액티비티"),
            Category(image: UIImage(named: "categoryAdventureImage") ?? UIImage(), title: "어드벤처", subTitle: "호스팅 여행"),
            Category(image: UIImage(named: "categoryRestaurantImage") ?? UIImage(), title: "레스토랑", subTitle: "최고 평점의 음식"),
        ]
        
        mainViewDataArray.append(MainViewData(data: categoryDataArray, cellStyle: .category))
    }

}


//            let encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))1
//            if let messageString = String(cString: recevieCstring, encoding: encoding) { print(messageString)
