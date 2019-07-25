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
import NVActivityIndicatorView

class LaunchScreenViewController: UIViewController {
    
    let imageView = UIImageView()
    
    var netWork = NetworkCommunicator()
    let kingfisher = ImageDownloader.default
    
    var mainViewDataArray = [MainViewData]()
    var houseDataArray = [HouseDataInList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let activityData = ActivityData(size: CGSize(width: 25, height: 25), message: "testing", messageFont: .systemFont(ofSize: 13, weight: .bold), messageSpacing: 10, type: .ballPulse, color: .red, padding: 50, displayTimeThreshold: 1, minimumDisplayTime: 1, backgroundColor: .clear, textColor: .black)
//
//        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        
//        startAnimating(CGSize(width: 40, height: 40), type: .ballPulse, color: StandardUIValue.shared.colorBlueGreen, displayTimeThreshold: 1, minimumDisplayTime: 1, backgroundColor: .white, textColor: nil, fadeInAnimation: nil)
        
        setAutoLayout()
        configureViewsOptions()
        createCategoryData()
        createPlusHouseData()
        createFullImageHouseData()
        createLuxeHouseData()
        
        getServerDataTest {
            self.mainViewDataArray.append(MainViewData(data: self.houseDataArray, cellStyle: .fourSquare))
            
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
                
                print("--------------------------[Before present]--------------------------")
                
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
    
    private func reArrangeMainViewDataArray() {
        var newArrangedArray = [MainViewData]()
        let categoryData = mainViewDataArray.filter { $0.cellStyle == .category}
        let plusHouseData = mainViewDataArray.filter { $0.cellStyle == .plus}
        let fullImageData = mainViewDataArray.filter { $0.cellStyle == .fullImage}
        let luxeHouseData = mainViewDataArray.filter { $0.cellStyle == .luxe}
        let normalHouseData = mainViewDataArray.filter { $0.cellStyle == .fourSquare}
        
        newArrangedArray.append(MainViewData(data: categoryData, cellStyle: .category))
        newArrangedArray.append(MainViewData(data: plusHouseData, cellStyle: .plus))
        newArrangedArray.append(MainViewData(data: fullImageData, cellStyle: .fullImage))
        newArrangedArray.append(MainViewData(data: luxeHouseData, cellStyle: .luxe))
        newArrangedArray.append(MainViewData(data: normalHouseData, cellStyle: .fourSquare))
        
        mainViewDataArray = newArrangedArray
    }
}

// ServerData & 가데이터 생성
extension LaunchScreenViewController {
    private func createCategoryData() {
        let categoryDataArray: [Category] = [
            Category(image: UIImage(named: "categoryHouseImage") ?? UIImage(), title: "숙소", subTitle: "숙소"),
            Category(image: UIImage(named: "categoryTripImage") ?? UIImage(), title: "트립", subTitle: "액티비티"),
            Category(image: UIImage(named: "categoryAdventureImage") ?? UIImage(), title: "어드벤처", subTitle: "호스팅 여행"),
            Category(image: UIImage(named: "categoryRestaurantImage") ?? UIImage(), title: "레스토랑", subTitle: "최고 평점의 음식"),
        ]
        mainViewDataArray.append(MainViewData(data: categoryDataArray, cellStyle: .category))
    }
    
    private func createPlusHouseData() {
        let imageArray = ["plusHouseSample1", "plusHouseSample2", "plusHouseSample3", "plusHouseSample4", "plusHouseSample5"]
        let housePlusDataArray: [HousePlusDataInList] = [
            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[0]),
                                houseImageString: imageArray,
                                houseLocation: "아테네",
                                houseName: "Stay on a Working Flower Farm in a Modern Home",
                                houseTotalRate: 5,
                                houseRateCount: 65),
            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[1]),
                                houseImageString: imageArray,
                                houseLocation: "멕시코시티",
                                houseName: "Elegant Art Deco Home with Garden in Condesa",
                                houseTotalRate: 3.5,
                                houseRateCount: 30),
            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[2]),
                                houseImageString: imageArray,
                                houseLocation: "오스틴",
                                houseName: "Historic Casa Cartel - Austin Villa with Courtyard Pool",
                                houseTotalRate: 4.3,
                                houseRateCount: 103),
            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[3]),
                                houseImageString: imageArray,
                                houseLocation: "ToberMory",
                                houseName: "Unique and Secluded AirShip with breathtaking Highland Views",
                                houseTotalRate: 4.6,
                                houseRateCount: 99),
            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[4]),
                                houseImageString: imageArray,
                                houseLocation: "조슈아 트리",
                                houseName: "Dome in the Desert in Joshua Tree",
                                houseTotalRate: 3.2,
                                houseRateCount: 49),
        ]
        mainViewDataArray.append(MainViewData(data: housePlusDataArray, cellStyle: .plus))
    }
    
    private func createFullImageHouseData() {
        let fullImageHouseData = [
            HouseFullImagDataInList(title: "계획을 전혀 세우지않고도\n완벽한 여행을 즐기는 법", image: UIImage(named: "MainFullImage"))
        ]
        mainViewDataArray.append(MainViewData(data: fullImageHouseData, cellStyle: .fullImage))
    }
    
    private func createLuxeHouseData() {
        let imageArray = ["luxeHouseSample1", "luxeHouseSample2", "luxeHouseSample3", "luxeHouseSample4", "luxeHouseSample5"]
        let luxeHouseData = [
            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[0]),
                                houseImageString: imageArray,
                                houseLocation: "우븟",
                                houseName: "Villa Kelusa Modern thatch-roofed estate overlokking jungle"),
            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[1]),
                                houseImageString: imageArray,
                                houseLocation: "The BIGHT",
                                houseName: "Atelier House Gated modern villa above the sea"),
            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[2]),
                                houseImageString: imageArray,
                                houseLocation: "PUNTA MITA",
                                houseName: "Casa Koko Contemporary craft architecture on the beach"),
            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[3]),
                                houseImageString: imageArray,
                                houseLocation: "MONTEGO FREEPORT",
                                houseName: "Afimi Jamaican Villa Rental"),
            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[4]),
                                houseImageString: imageArray,
                                houseLocation: "EL JOBO",
                                houseName: "Su Casa Contemporary villa above Playa Rajada"),
        ]
        mainViewDataArray.append(MainViewData(data: luxeHouseData, cellStyle: .luxe))
    }
    
    
    private func getServerDataTest(completion: @escaping () -> ()) {
        let urlString = netWork.basicUrlString
            + "/rooms/?search=seoul&ordering=price&page_size=5&page=1"
        
        
        netWork.getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json) in
            guard let object = json as? [String: Any] else { print("object convert error"); return }
            
            let resultArray = object["results"] as! [[String: Any]]
            print("🔵🔵🔵 value ")
            
            
            for (index, roomData) in resultArray.enumerated() {
                print("index \(index)")
                guard let id = roomData["id"] as? Int
                    , let title = roomData["title"] as? String
                    , let imageString = roomData["image"] as? String
                    , let imageUrl = URL(string: imageString)
                    , let roomType = roomData["room_type"] as? String
                    , let rate = roomData["total_rating"] as? Double
                    else { print("roomData convert error"); return }
                
                self.kingfisher.downloadImage(with: imageUrl, completionHandler: { (image, error, url, data) in
                    //                    guard let image = image else { print("image convert error"); return }
                    
                    let houseDataInList = HouseDataInList(id: id, houseImage: image, houseType: roomType, houseLocation: "서울", houseName: title, houseTotalRate: rate, houseRateCount: 20)
                    self.houseDataArray.append(houseDataInList)
                    
                    (index == resultArray.count-1) ? completion() : ()
                })
                //                (index == resultArray.count-1) ? completion() : ()
            }
        }
    }
    
    
}


//            let encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))1
//            if let messageString = String(cString: recevieCstring, encoding: encoding) { print(messageString)
