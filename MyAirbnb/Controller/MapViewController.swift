//
//  MapViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 22/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController {
    
    let mapView = MKMapView()
    let clearView = UIView()
    let dismissBtn = UIButton()
    
    var defaultLocation = CLLocationCoordinate2D()
    var circleColor = UIColor.black

    override func viewDidLoad() {
        super.viewDidLoad()

        setAutoLayout()
        configureViewsOptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false   
    }
    
    private func setAutoLayout() {
        let safeGuide = view.safeAreaLayoutGuide
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
//            make.leading.equalTo(50)
        }
        
        view.addSubview(clearView)
        clearView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(20)
        }
        
//        view.addSubview(dismissBtn)
//        dismissBtn.snp.makeConstraints { (make) in
//            make.leading.top.equalTo(safeGuide).offset(10)
//            make.width.height.equalTo(35)
//        }
        
        
    }
    
    private func configureViewsOptions() {
        view.backgroundColor = .white
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: defaultLocation, span: span)
        mapView.setRegion(region, animated: false)
        mapView.delegate = self
        
        clearView.backgroundColor = .clear
        
        dismissBtn.setImage(UIImage(named: "backBtnImage"), for: .normal)
        
        drawCircleInMap(centerCoordinate: defaultLocation)
    }
    
    private func drawCircleInMap(centerCoordinate: CLLocationCoordinate2D) {
        let center = centerCoordinate
        let circle = MKCircle(center: center, radius: 800)
        mapView.addOverlay(circle)
    }

}


extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(circle: circle)
            renderer.strokeColor = circleColor
            renderer.lineWidth = 1
            renderer.fillColor = circleColor.withAlphaComponent(0.3)
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    
}
