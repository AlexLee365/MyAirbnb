//
//  FavoriteViewData.swift
//  MyAirbnb
//
//  Created by 김광준 on 06/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import UIKit

protocol FavoriteDataProtocol {}

struct FavoriteData {
    var data: FavoriteDataProtocol
    var cellStyle: CellStyle
    
    enum CellStyle {
        case one, three, title
    }
}

struct OnePhoto: FavoriteDataProtocol {
    let firstImage: UIImage
}

struct ThreePhoto: FavoriteDataProtocol {
    let firstImage: UIImage
    let secondImage: UIImage
    let thirdImage: UIImage
}

struct TitleText: FavoriteDataProtocol {
    let title: String
}



