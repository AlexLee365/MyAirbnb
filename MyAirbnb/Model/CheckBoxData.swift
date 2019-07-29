//
//  CheckBoxData.swift
//  MyAirbnb
//
//  Created by Solji Kim on 22/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

struct CheckBoxData {
    let title: String
    var contentArray: [Content]
    let buttonTitle: String?
    var seeAllBtnState: Bool = false
}

struct Content {
    let type: String
    var checkBoxState: Bool
}



