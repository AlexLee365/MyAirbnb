//
//  PlaceData.swift
//  MyAirbnb
//
//  Created by Solji Kim on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import MapKit

class PlaceData: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}


