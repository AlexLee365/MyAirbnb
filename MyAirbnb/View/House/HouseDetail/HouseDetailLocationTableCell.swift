//
//  HouseDetailLocationTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 22/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class HouseDetailLocationTableCell: UITableViewCell {
    static let identifier = "HouseDetailLocationTableCell"
    
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let mapView = MKMapView()
    let geocoder = CLGeocoder()
    
    let mapNoticeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        configureViewsOptions()
        setMapView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        let topBottomMargin = StandardUIValue.shared.houseDetailTopBottomMargin
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topBottomMargin)
            make.leading.equalTo(sideMargin)
        }
        
        self.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(topBottomMargin)
            make.leading.equalTo(sideMargin)
        }
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(topBottomMargin/2)
            make.leading.equalTo(sideMargin)
        }
        
        self.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(topBottomMargin)
            make.leading.equalTo(sideMargin)
            make.trailing.equalTo(-sideMargin)
            make.height.equalTo(mapView.snp.width).multipliedBy(0.6)
        }
        
        self.addSubview(mapNoticeLabel)
        mapNoticeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(mapView.snp.bottom).offset(8)
            make.leading.equalTo(sideMargin)
            make.bottom.equalTo(-topBottomMargin)
        }
        
    }
    
    private func configureViewsOptions() {
        titleLabel.configureHouseDetailMainText()
        titleLabel.text = "숙소 위치"
        
        subTitleLabel.configureHouseDetailMainText()
        subTitleLabel.text = "서울, 한국"
        
        descriptionLabel.configureHouseDetailSubText()
        descriptionLabel.text = """
        Perfect Location for first comer roaming around Seoul!!!
        \n\n10mins by subway or bus: Myeongdong, Itaeown, Hongdae
        \n20mins: Gyeongbok Palace, Dongdaemun
        """
        
        mapNoticeLabel.configureHouseDetailSubText()
        mapNoticeLabel.font = .systemFont(ofSize: 10, weight: .regular)
        mapNoticeLabel.text = "정확한 위치는 예약 완료 후에 표시됩니다."
    }
    
    private func setMapView() {
        let basicLocation = "서울 종로구 사직로 161 경복궁"
        getLocationFromAddress(address: basicLocation)
    }
    
    private func getLocationFromAddress(address: String) {
        geocoder.geocodeAddressString(address) { (placeMark, error) in
            guard let coordinate = placeMark?.first?.location?.coordinate else { print("주소 변환 실패"); return }
            
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapView.setRegion(region, animated: false)
        }
    }

}

//extension HouseDetailLocationTableCell: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .authorizedWhenInUse, .authorizedAlways:
//            print("authrorized")
//        default :
//            print("Unauthorized")
//
//        }
//    }
//
//
//}
