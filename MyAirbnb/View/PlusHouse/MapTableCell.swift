//
//  MapTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 26/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class MapTableCell: UITableViewCell {
    static let identifier = "MapTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "위치"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "부다페스트(Budapest), 헝가리"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 18)
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "Located on Karoly Boulevard, the apartment is a close walk to Deák tér, one of the largest transportation hub, making it easy to get around the city. The building is right next door to one of the city's most famous landmarks, the Great Synagogue."
        label.numberOfLines = 0
//        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 18)
//        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
//        label.setLineSpacing(lineSpacing: 4.0)
        
        label.textColor = StandardUIValue.shared.colorRegularText
        label.font = UIFont(name: StandardUIValue.shared.airbnbBookFontString, size: 16)
        label.setLineSpacing(lineSpacing: 8, lineHeightMultiple: 1)
        return label
    }()
    
    let distanceFromAirportLabel: UILabel = {
        let label = UILabel()
        label.text = "부다페스트 페렌츠 리스트 국제공항으로부터의 거리"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13.5, weight: .bold)
        return label
    }()

    let timeTakenLabel: UILabel = {
        let label = UILabel()
        label.text = "교통정체가 없을 경우 차로 28분"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13.5, weight: .regular)
        return label
    }()
    
    let noteLabel: UILabel = {
        let label = UILabel()
        label.text = "정확한 위치는 예약 완료 후에 표시됩니다"
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13.5)
        return label
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        mapView.isRotateEnabled = false
        mapView.layer.cornerRadius = 5
        mapView.clipsToBounds = true
        return mapView
    }()
    
    let geocoder = CLGeocoder()
    var currentCoordinate = CLLocationCoordinate2D()
    
    let notiCenter = NotificationCenter.default
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(descLabel)
        
        mapView.delegate = self
        let mapViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewDidTap(_:)))
        mapView.addGestureRecognizer(mapViewTapGesture)
        contentView.addSubview(mapView)
        
//        let address = "Budapest, Károly krt., 헝가리"
//        getLocationFromAddress(address: address)
        
        contentView.addSubview(distanceFromAirportLabel)
        contentView.addSubview(timeTakenLabel)
        contentView.addSubview(noteLabel)
    }
    
    @objc private func mapViewDidTap(_ sender: UITapGestureRecognizer) {
        notiCenter.post(name: .mapViewDidTapInHouseDetailView, object: nil, userInfo: ["coordinate": currentCoordinate])
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.leading.equalTo(20)
        }
        
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(15)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(mapView.snp.width)
        }
        
        distanceFromAirportLabel.snp.makeConstraints { (make) in
            make.top.equalTo(mapView.snp.bottom).offset(15)
            make.leading.equalTo(20)
        }

        timeTakenLabel.snp.makeConstraints { (make) in
            make.top.equalTo(distanceFromAirportLabel.snp.bottom).offset(3)
            make.leading.equalTo(20)
        }

        noteLabel.snp.makeConstraints { (make) in
            make.top.equalTo(timeTakenLabel.snp.bottom).offset(17)
            make.leading.equalTo(20)
            make.bottom.equalTo(-20)
        }
    }
    
    private func getLocationFromAddress(address: String) {
        geocoder.geocodeAddressString(address) { (placeMark, error) in
            
            guard let coordinate = placeMark?.first?.location?.coordinate
                else { print("주소변환실패!"); return }
            
            self.currentCoordinate = coordinate
            
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
            
            let pin = PlusHouseAnnotation(coordinate: coordinate)
            self.mapView.addAnnotation(pin)
        }
    }
    
    func setData(plusData: HouseDetailData) {
        locationLabel.text = "\(plusData.state), Russia"
        descLabel.text = plusData.locationalDescription
        descLabel.setLineSpacing(lineSpacing: 8, lineHeightMultiple: 1)
        
        getLocationFromAddress(address: plusData.address)
    }
}

// MARK: - MKMapViewDelegate

extension MapTableCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { print("annotation error"); return nil }

        let annotationIdentifier = "customPin"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        } else {
            annotationView?.annotation = annotation
        }

        annotationView?.image = UIImage(named: "plusHouseAnnotation")
        annotationView?.frame = CGRect(x: 0, y: 0, width: 45, height: 45)

        annotationView?.canShowCallout = false
        
        return annotationView
    }
}

final class PlusHouseAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
