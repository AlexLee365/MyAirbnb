//
//  PlaceTableViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import MapKit

class PlaceTableViewCell: UITableViewCell {
    static let identifier = "placeTableViewCell"

    let placeLabel: UILabel = {
        let label = UILabel()
        label.configureTripDetailHostInfoTitle()
        label.text = "장소"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let introLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.numberOfLines = 0
        label.text = "이 프로그램은 멜릭서의 오피스인 위워크(Wework) 선릉역 2호점에서 진행됩니다. 멜릭서 사무실도 둘러보고, 한국의 스타트업 회사와 코워킹 스페이스를 둘러보실 수도 있는 좋은 기회가 될 거에요 :)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mapView = MKMapView()
    
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let regionRadius: CLLocationDistance = 1000
    let artwork = PlaceData(title: "",
                          locationName: "Waikiki Gateway Park",
                          discipline: "Sculpture",
                          coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func configure() {
        contentView.addSubview(placeLabel)
        contentView.addSubview(introLabel)
        
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isRotateEnabled = false
        contentView.addSubview(mapView)
        
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        
        let circle = MKCircle(center: artwork.coordinate, radius: 100)
        mapView.addOverlay(circle)
        
        mapView.addAnnotation(artwork)
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
        mapView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

extension PlaceTableViewCell: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? PlaceData else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.fillColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1).withAlphaComponent(0.5)
        renderer.strokeColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        renderer.lineWidth = 2
        return renderer
    }
}
