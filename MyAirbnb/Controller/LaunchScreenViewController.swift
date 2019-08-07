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
    
    let backgroundGrayView = UIView()
    let pinkAnimationView = UIView()
    let logoImageView = UIImageView()
    
    var netWork = NetworkCommunicator()
    let kingfisher = ImageDownloader.default
    let jsonDecoder = JSONDecoder()
    
    var mainViewDataArray = [MainViewData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAutoLayout()
        configureViewsOptions()
        startAnimation()
        
        createCategoryData()
//        createPlusHouseData()
        createFullImageHouseData()
//        createLuxeHouseData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.getEntireServerData {
                self.reArrangeMainViewDataArray()    // 서버에서 받은 데이터들 배열안에서 index 재배치
                
                DispatchQueue.main.async {
                    let tabbarVC = TabbarController()
                    SingletonCommonData.shared.tabbarController = tabbarVC
                    guard let naviVC = tabbarVC.viewControllers!.first as? UINavigationController
                        , let mainVC = naviVC.viewControllers.first as? MainViewController else {
                            print("LaunchVC naviVC, mainVC convert error")
                            return
                    }
                    
                    mainVC.mainView.mainViewDatas = self.mainViewDataArray
                    self.present(tabbarVC, animated: false)
                    print("--------------------------[Tabbar-MainVC Launched]--------------------------")
                }
            }
        }
    }
    
    private func setAutoLayout() {
        view.addSubview(backgroundGrayView)
        backgroundGrayView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        view.addSubview(pinkAnimationView)
        pinkAnimationView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-130)
            make.height.equalTo(100)
            make.width.equalTo(150)
        }
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalTo(150)
        }
    }
    
    private func configureViewsOptions() {
         print("🔵🔵🔵 UserID: \(UserDefaults.standard.string(forKey: SingletonCommonData.userDefaultIDKey) ?? "") / UserNumber: \(UserDefaults.standard.integer(forKey: SingletonCommonData.userDefaultIDNumber)) / UserToekn: \(UserDefaults.standard.string(forKey: SingletonCommonData.userDefaultTokenKey) ?? "")")
        
        view.backgroundColor = .white
        backgroundGrayView.backgroundColor = #colorLiteral(red: 0.7848168612, green: 0.7801527381, blue: 0.7884028554, alpha: 0.3912403682)
        pinkAnimationView.backgroundColor = StandardUIValue.shared.colorPink
        
        logoImageView.image = UIImage(named: "launchLogoImage")
        logoImageView.contentMode = .scaleAspectFit
        
     
    }
    
    private func startAnimation() {
        UIView.animateKeyframes(withDuration: 1.6, delay: 0, options: [.repeat], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.85, animations: {
                self.pinkAnimationView.transform = CGAffineTransform(translationX: 0, y: 100)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.15, animations: {
                self.pinkAnimationView.alpha  = 0
            })
        }) { (_) in
            print("LaunchScreenVC animation finished")
        }
    }
    
    private func reArrangeMainViewDataArray() {
        var newArrangedArray = [MainViewData]()
        guard let categoryData = ( mainViewDataArray.filter { $0.cellStyle == .category}.map{$0.data}.first ) as? [Category]
            , let plusHouseData = ( mainViewDataArray.filter { $0.cellStyle == .plus}.map{$0.data}.first ) as? [HousePlusDataInList]
            , let fullImageData = ( mainViewDataArray.filter { $0.cellStyle == .fullImage}.map{$0.data}.first ) as? [HouseFullImagDataInList]
            , let luxeHouseData = ( mainViewDataArray.filter { $0.cellStyle == .luxe}.map{$0.data}.first ) as? [HouseLuxeDataInList]
            , let normalHouseData = ( mainViewDataArray.filter { $0.cellStyle == .fourSquare}.map{$0.data}.first ) as? [HouseDataInList] else {
                print("‼️ reArrangeMainViewDataArray convert ")
                return
        }
        
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
    
//    private func createPlusHouseData() {
//        let imageArray = ["plusHouseSample1", "plusHouseSample2", "plusHouseSample3", "plusHouseSample4", "plusHouseSample5"]
//        let housePlusDataArray: [HousePlusDataInList] = [
//            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[0]),
//                                houseImageString: imageArray,
//                                houseLocation: "아테네",
//                                houseName: "Stay on a Working Flower Farm in a Modern Home",
//                                houseTotalRate: 5,
//                                houseRateCount: 65),
//            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[1]),
//                                houseImageString: imageArray,
//                                houseLocation: "멕시코시티",
//                                houseName: "Elegant Art Deco Home with Garden in Condesa",
//                                houseTotalRate: 3.5,
//                                houseRateCount: 30),
//            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[2]),
//                                houseImageString: imageArray,
//                                houseLocation: "오스틴",
//                                houseName: "Historic Casa Cartel - Austin Villa with Courtyard Pool",
//                                houseTotalRate: 4.3,
//                                houseRateCount: 103),
//            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[3]),
//                                houseImageString: imageArray,
//                                houseLocation: "ToberMory",
//                                houseName: "Unique and Secluded AirShip with breathtaking Highland Views",
//                                houseTotalRate: 4.6,
//                                houseRateCount: 99),
//            HousePlusDataInList(houseMainImage: UIImage(named: imageArray[4]),
//                                houseImageString: imageArray,
//                                houseLocation: "조슈아 트리",
//                                houseName: "Dome in the Desert in Joshua Tree",
//                                houseTotalRate: 3.2,
//                                houseRateCount: 49),
//        ]
//        mainViewDataArray.append(MainViewData(data: housePlusDataArray, cellStyle: .plus))
//    }
    
    private func createFullImageHouseData() {
        let fullImageHouseData = [
            HouseFullImagDataInList(title: "계획을 전혀 세우지않고도\n완벽한 여행을 즐기는 법", image: UIImage(named: "MainFullImage"))
        ]
        mainViewDataArray.append(MainViewData(data: fullImageHouseData, cellStyle: .fullImage))
    }
    
//    private func createLuxeHouseData() {
//        let imageArray = ["luxeHouseSample1", "luxeHouseSample2", "luxeHouseSample3", "luxeHouseSample4", "luxeHouseSample5"]
//        let luxeHouseData = [
//            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[0]),
//                                houseImageString: imageArray,
//                                houseLocation: "우븟",
//                                houseName: "Villa Kelusa Modern thatch-roofed estate overlokking jungle"),
//            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[1]),
//                                houseImageString: imageArray,
//                                houseLocation: "The BIGHT",
//                                houseName: "Atelier House Gated modern villa above the sea"),
//            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[2]),
//                                houseImageString: imageArray,
//                                houseLocation: "PUNTA MITA",
//                                houseName: "Casa Koko Contemporary craft architecture on the beach"),
//            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[3]),
//                                houseImageString: imageArray,
//                                houseLocation: "MONTEGO FREEPORT",
//                                houseName: "Afimi Jamaican Villa Rental"),
//            HouseLuxeDataInList(houseMainImage: UIImage(named: imageArray[4]),
//                                houseImageString: imageArray,
//                                houseLocation: "EL JOBO",
//                                houseName: "Su Casa Contemporary villa above Playa Rajada"),
//        ]
//        mainViewDataArray.append(MainViewData(data: luxeHouseData, cellStyle: .luxe))
//    }
    
    
    
    // =================================== Get ServerData Functions ===================================
    private func getEntireServerData(completion: @escaping () -> ()) {
        let dispatchGroup = DispatchGroup()
        let globalQueue = DispatchQueue.global()

        dispatchGroup.enter()
        globalQueue.async {
            print("🔸🔸🔸 group getServerHouseData statrted ")
        
            
            self.getServerHouseData(completion: { (houseArray) in
                self.mainViewDataArray.append(MainViewData(data: houseArray, cellStyle: .fourSquare))
                print("🔸🔸🔸 gorup getServerHouseData Finished ")
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.enter()
        globalQueue.async {
            print("🔸🔸🔸 gorup getServerLuxeData Finished ")
            self.getServerLuxeData(completion: { (luxeHouseArray) in
                self.mainViewDataArray.append(MainViewData(data: luxeHouseArray, cellStyle: .luxe))
                print("🔸🔸🔸 gorup getServerLuxeData Finished ")
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.enter()
        globalQueue.async {
            print("🔸🔸🔸 gorup getServerPlusHouseData Finished ")
            self.getServerPlusHouseData(completion: { (plusHouseArray) in
                self.mainViewDataArray.append(MainViewData(data: plusHouseArray, cellStyle: .plus))
                print("🔸🔸🔸 gorup getServerPlusHouseData Finished ")
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.enter()
        globalQueue.async {
            print("🔸🔸🔸 getLoginedUserData started ")
            self.getLoginedUserData(completion: { (result) in
                switch result {
                case .success(let value):
                    SingletonCommonData.shared.userInfo = value
                    print("🔸🔸🔸 getLoginedUserData finished ")
                    print("🔵🔵🔵 로그인한 유저정보: ", value)
                    
                    dispatchGroup.leave()
                    
                case .failure(let error):
                    print("‼️ getLoginedUserData: ", error.localizedDescription)
                    print("🔸🔸🔸 getLoginedUserData finished ")
                    dispatchGroup.leave()
                }
            })
        }
        
        dispatchGroup.notify(queue: globalQueue) {
            print("🔸🔸🔸 All downloading finisehd ")
            completion()
            
            // 숙소 데이터를 우선적으로 다운 후에 완료시 기타 부가 데이터 다운시작
            print("🔸🔸🔸 After LaunchScreen Downloading started ")
            self.getUsersChatRoomsData(completion: { (result) in
                switch result {
                case .success(_):
                    print("🔵🔵🔵 chatroomData Array: ", SingletonCommonData.shared.userChatRoomsArray)
                    print("🔸🔸🔸 getUsersChatRoomsData finished ")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        NotificationCenter.default.post(name: .downloadingMessagesDataFinished, object: nil)
                    })
                    
                case .failure(let error):
                    print("‼️", error.localizedDescription)
                }
            })
            
            self.getServerStatesData {
                print("🔸🔸🔸 getServerStatesData Finished ")
            }
        }
       
    }
    
    
    private func getServerHouseData(completion: @escaping ([HouseDataInList]) -> ()) {
        let urlString = netWork.basicUrlString
            + "/rooms/?search=korea&ordering=-total_rating&page_size=7&page=1"
        
        netWork.getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json, success) in
            guard success else {
                return
            }
            
            guard let object = json as? [String: Any]
                , let resultArray = object["results"] as? [[String: Any]]
                else { print("object convert error"); return }
            
            guard let data = try? JSONSerialization.data(withJSONObject: resultArray) else {
                print("‼️ LaunchVC data convert error")
                return
            }
            
            guard let houseArray = try? self.jsonDecoder.decode([HouseDataInList].self, from: data) else {
                print("‼️ LaunchVC result decoding convert error")
                return
            }
            
            completion(houseArray)
        }
    }
    
    private func getServerLuxeData(completion: @escaping ([HouseLuxeDataInList]) -> ()) {
        let urlString = netWork.basicUrlString
            + "/rooms/?search=sanjose&ordering=-total_rating&page_size=10&page=1"
        
        netWork.getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json, success) in
            guard success else {
                return
            }
            
            guard let object = json as? [String: Any]
                , let resultArray = object["results"] as? [[String: Any]]
                else { print("object convert error"); return }
            
            guard let data = try? JSONSerialization.data(withJSONObject: resultArray) else {
                print("‼️ LaunchVC data convert error")
                return
            }
            
            guard let luxeHouseArray = try? self.jsonDecoder.decode([HouseLuxeDataInList].self, from: data) else {
                print("‼️ LaunchVC result decoding convert error")
                return
            }
            
            completion(luxeHouseArray)
        }
    }
    
    private func getServerPlusHouseData(completion: @escaping ([HousePlusDataInList]) -> () ) {
        let urlString = netWork.basicUrlString
            + "/rooms/?search=russia&ordering=-total_rating&page_size=10&page=1"
        
        netWork.getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json, success) in
            guard success else {
                return
            }
            
            guard let object = json as? [String: Any]
                , let resultArray = object["results"] as? [[String: Any]]
                else { print("object convert error"); return }
            
            guard let data = try? JSONSerialization.data(withJSONObject: resultArray) else {
                print("‼️ LaunchVC data convert error")
                return
            }
            
            guard let plusHouseArray = try? self.jsonDecoder.decode([HousePlusDataInList].self, from: data) else {
                print("‼️ LaunchVC result decoding convert error")
                return
            }
            
            completion(plusHouseArray)
        }
    }
    
    
    private func getServerStatesData(completion: @escaping () -> ()) {
        let urlString = netWork.basicUrlString + "/locations/state/"
        netWork.getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json, success) in
            guard success else {
                return
            }
            
            guard let object = json as? [[String: Any]]
                else { print("object convert error"); return }
            
            var tempArray = [String]()
            for state in object {
                guard let name = state["name"] as? String else { continue }
                tempArray.append(name)
            }
            
            
            SingletonCommonData.shared.stateArray = tempArray
            UserDefaults.standard.set(tempArray, forKey: SingletonCommonData.userDefaultSaveStatesInfo)
            
            completion()
        }
    }
    
    private func getLoginedUserData(completion: @escaping (Result<UserInfo, netWorkError>) -> ()) {
        let urlString = netWork.basicUrlString + "/accounts/user/\(netWork.userNumber)/"
        netWork.getServerDataWithToken(urlString: urlString) { (result) in
            switch result {
            case .success(let value):
                guard let userInfo = try? self.jsonDecoder.decode(UserInfo.self, from: value) else {
                    print("[getLoginedUserData] decode error ")
                    completion(.failure(.decodingError))
                    return
                }
                completion(.success(userInfo))
            
            case .failure(let error):
                print("‼️ getLoginedUserData Error: ", error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    private func getUsersChatRoomsData(completion: @escaping (Result<Any?, netWorkError>) -> ()) {
        SingletonCommonData.shared.userChatRoomsArray.removeAll()
//        guard let userInfo = SingletonCommonData.shared.userInfo else { print("‼️ getUserChatRoomsData userInfo convert error "); return }
//        guard userInfo.reservations.count > 0 else { completion(.failure(.badUrl)); return }
//        for (index, room) in userInfo.reservations.enumerated() {
//            guard let chatRoomArray = room?.values
//                , let chatRoom = chatRoomArray.first else {
//                    print("‼️ : ")
//                    return
//            }
//
//            let urlString = netWork.basicUrlString + "/chat/\(chatRoom.id)"
//
//            netWork.getServerDataWithToken(urlString: urlString) { (result) in
//                switch result {
//                case .success(let value):
//                    guard let chatRoomData = try? self.jsonDecoder.decode(ChatRoom.self, from: value) else {
//                        print("‼️ chatRoomData decoding error ");
//                        completion(.failure(.decodingError))
//                        return
//                    }
//                    SingletonCommonData.shared.userChatRoomsArray.append(chatRoomData)
//                    (index == userInfo.reservations.count - 1) ? completion(.success(nil)) : ()       // 마지막 인덱스까지 for문이 돌면 success or failtur completion
//                case .failure(let error):
//                    print("‼️ chatroom getServerData error: ", error.localizedDescription)
//                    (index == userInfo.reservations.count - 1) ? completion(.failure(error)) : ()
//                }
//            }
//        }
        
        
        let urlString = netWork.basicUrlString + "/chat/"
        netWork.getServerDataWithToken(urlString: urlString) { (result) in
            switch result {
            case .success(let value):
                guard let chatRoomDataArray = try? self.jsonDecoder.decode([ChatRoom].self, from: value) else {
                    print("‼️ chatRoomData decoding error ");
                    completion(.failure(.decodingError))
                    return
                }
                SingletonCommonData.shared.userChatRoomsArray = chatRoomDataArray
                completion(.success(nil))
            case .failure(let error):
                print("‼️ chatroom getServerData error: ", error.localizedDescription)
                completion(.failure(error))
            }
        }
        
        
    }
}
