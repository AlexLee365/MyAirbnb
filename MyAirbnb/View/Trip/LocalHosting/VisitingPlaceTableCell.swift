//
//  VisitingPlaceTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 30/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class VisitingPlaceTableCell: UITableViewCell {
    static let identifier = "VisitingPlaceTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "방문 장소"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 25)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 3)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 15)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isRotateEnabled = false
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
        contentView.addSubview(descLabel)
        
        let mapViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewDidTap(_:)))
        
        mapView.delegate = self
        mapView.addGestureRecognizer(mapViewTapGesture)
        contentView.addSubview(mapView)
        
        let location = "Baltra Airport Rd"
        getLocationFromAddress(address: location)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.leading.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(mapView.snp.width)
            make.bottom.equalTo(-20)
        }
    }
    
    
    @objc private func mapViewDidTap(_ sender: UITapGestureRecognizer) {
        notiCenter.post(name: .mapViewDidTapInHouseDetailView, object: nil, userInfo: ["coordinate": currentCoordinate])
    }
    
    
    private func getLocationFromAddress(address: String) {
        geocoder.geocodeAddressString(address) { (placeMark, error) in
            
            guard let coordinate = placeMark?.first?.location?.coordinate
                else { print("주소변환실패!"); return }
            
            self.currentCoordinate = coordinate
            
            let span = MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
            self.drawCircleInMap(centerCoordinate: region.center)
        }
    }
    
    private func drawCircleInMap(centerCoordinate: CLLocationCoordinate2D) {
        let center = centerCoordinate
        let circle = MKCircle(center: center, radius: 400)
        mapView.addOverlay(circle)
    }
    
    func setData(tripData: TripDetail) {
        descLabel.text = tripData.placeInfo
        descLabel.setLineSpacing(lineSpacing: 3)
    }
}


// MARK: - MKMapViewDelegate

extension VisitingPlaceTableCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(overlay: circle)
            renderer.strokeColor = StandardUIValue.shared.colorBlueGreen
            renderer.lineWidth = 2
            renderer.fillColor = UIColor(red:0.09, green:0.51, blue:0.54, alpha:0.4)
            return renderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
}
