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
    
    // MARK: - UI Properties
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let mapView = MKMapView()
    let geocoder = CLGeocoder()
    
    let mapNoticeLabel = UILabel()
    
    // MARK: - Properties
//    var callBack: ( () -> Void )?
    let notiCenter = NotificationCenter.default
    var currentCoordinate = CLLocationCoordinate2D()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        configureViewsOptions()
        
        print("🔵🔵🔵 HouseDetailLocation TableCell ")
        print(mapView.annotations)
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
            make.trailing.equalTo(-sideMargin)
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
    
    private func setMapView(addressString: String) {
        mapView.delegate = self
        mapView.isScrollEnabled = false
        let mapViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewDidTap(_:)))
        mapView.addGestureRecognizer(mapViewTapGesture)

        getLocationFromAddress(address: addressString) { (region) in
            self.mapView.setRegion(region, animated: false)
            self.drawCircleInMap(centerCoordinate: region.center)
        }
    }
    
    private func drawCircleInMap(centerCoordinate: CLLocationCoordinate2D) {
        let center = centerCoordinate
        let circle = MKCircle(center: center, radius: 800)
        mapView.addOverlay(circle)
    }
    
    private func getLocationFromAddress(address: String, completion: @escaping (MKCoordinateRegion) -> Void ) {
        geocoder.geocodeAddressString(address) { (placeMark, error) in
            guard let coordinate = placeMark?.first?.location?.coordinate else { print("주소 변환 실패"); return }
            self.currentCoordinate = coordinate
            
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            completion(region)
        }
    }
    
    @objc func mapViewDidTap(_ sender: UITapGestureRecognizer) {
        print("Mapview Tapped")
        notiCenter.post(name: .mapViewDidTapInHouseDetailView, object: nil, userInfo: ["coordinate": currentCoordinate])
    }
    
    func setData(state: String, LocationDescription: String, address: String) {
        subTitleLabel.text = "\(state), 한국"
//        descriptionLabel.text = LocationDescription
        setMapView(addressString: address)
    }
    

}

extension HouseDetailLocationTableCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(circle: circle)
            renderer.strokeColor = StandardUIValue.shared.colorBlueGreen
            renderer.lineWidth = 1
            renderer.fillColor = UIColor(red:0.09, green:0.51, blue:0.54, alpha:0.2)
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

final class Annotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
}
