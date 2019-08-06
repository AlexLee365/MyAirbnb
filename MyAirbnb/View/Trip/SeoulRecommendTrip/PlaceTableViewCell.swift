//
//  PlaceTableViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class PlaceTableViewCell: UITableViewCell {
    static let identifier = "placeTableViewCell"
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.configureTripDetailTitle()
        label.text = "장소"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let introLabel: UILabel = {
        let label = UILabel()
        label.configureTripDetailDesc()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    // MARK: - Properties
    
    private func configure() {
        self.hideSeparator()
        self.selectionStyle = .none
        
        contentView.addSubview(placeLabel)
        contentView.addSubview(introLabel)
        
        let mapViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewDidTap(_:)))
        
        mapView.delegate = self
        mapView.addGestureRecognizer(mapViewTapGesture)
        contentView.addSubview(mapView)
        
        let address = "Itaewon, 한남동, 용산구"
        getLocationFromAddress(address: address)
    }
    
    @objc private func mapViewDidTap(_ sender: UITapGestureRecognizer) {
        notiCenter.post(name: .mapViewDidTapInHouseDetailView, object: nil, userInfo: ["coordinate": currentCoordinate])
    }
    
    private func setAutolayout() {
        placeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        placeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        introLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 25).isActive = true
        introLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        introLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: 20).isActive = true
        mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    
    private func getLocationFromAddress(address: String) {
        geocoder.geocodeAddressString(address) { (placeMark, error) in
            
            guard let coordinate = placeMark?.first?.location?.coordinate
                else { print("주소변환실패!"); return }
            
            self.currentCoordinate = coordinate
            
            let span = MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
            self.drawCircleInMap(centerCoordinate: region.center)
            //            let pin = PlusHouseAnnotation(coordinate: coordinate)
            //            self.mapView.addAnnotation(pin)
        }
    }
    
    private func drawCircleInMap(centerCoordinate: CLLocationCoordinate2D) {
        let center = centerCoordinate
        let circle = MKCircle(center: center, radius: 600)
        mapView.addOverlay(circle)
    }
    
    func setData(placeInfoData: TripDetail) {
        introLabel.text = placeInfoData.placeInfo
    }
}

extension PlaceTableViewCell: MKMapViewDelegate {
    
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    //        guard let annotation = annotation as? PlaceData else { return nil }
    //
    //        let identifier = "marker"
    //        var view: MKMarkerAnnotationView
    //
    //        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    //            as? MKMarkerAnnotationView {
    //            dequeuedView.annotation = annotation
    //            view = dequeuedView
    //
    //        } else {
    //            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
    //            view.canShowCallout = true
    //            view.calloutOffset = CGPoint(x: -5, y: 5)
    //            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    //        }
    //        return view
    //    }
    
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


final class SeoulRecommendedAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
