//
//  PlusMapViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 26/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class PlusMapViewController: UIViewController {

    let mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    var defaultLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
    }
    
    private func configure() {
        view.addSubview(mapView)
    }
    
    private func setAutolayout() {
        mapView.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}
