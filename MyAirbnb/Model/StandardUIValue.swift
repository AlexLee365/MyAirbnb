//
//  StandardUIValue.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 09/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class StandardUIValue {
    static let shared = StandardUIValue()
    
    // MARK: - Color
    let colorBoldText = #colorLiteral(red: 0.3221844435, green: 0.3202747703, blue: 0.3236560524, alpha: 1)
    let colorRegularText = #colorLiteral(red: 0.3221844435, green: 0.3202747703, blue: 0.3236560524, alpha: 1)
    let colorPlaceHolderText = UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.0)
    let colorWine = #colorLiteral(red: 0.386121124, green: 0.02965694666, blue: 0.2658225596, alpha: 0.7088505993)
    let colorPurple = UIColor(red:0.20, green:0.00, blue:0.47, alpha:1.0)
    let colorBlueGreen = UIColor(red:0.09, green:0.51, blue:0.54, alpha:1.0)
    let colorBrown = UIColor(red:0.57, green:0.44, blue:0.36, alpha:1.0)
    let colorPink = UIColor(red:0.99, green:0.36, blue:0.39, alpha:1.0)
    let colorLineBorder = #colorLiteral(red: 0.625213623, green: 0.6214996576, blue: 0.628070116, alpha: 0.6072880993)
    
    // MARK: - Size
    let sizeTitleBoldText: CGFloat = 20
    let sizeSubTitleText: CGFloat = 16
    
    // MARK: - Font
    let airbnbBoldFont: UIFont = UIFont(name: "AirbnbCerealApp-Bold", size: 18)!
    let airbnbMediumFont: UIFont = UIFont(name: "AirbnbCerealApp-Medium", size: 17)!
    let airbnbBookFont: UIFont = UIFont(name: "AirbnbCerealApp-Book", size: 17)!
    
    // MARK: - FontName
    let airbnbBoldFontString = "AirbnbCerealApp-Bold"
    let airbnbMediumFontString = "AirbnbCerealApp-Medium"
    let airbnbBookFontString = "AirbnbCerealApp-Book"
    
    // MARK: - Margin
    let mainViewSideMargin: CGFloat = 20
    let mainTableViewCellsTopBottomPadding: CGFloat = 30
    
    let houseDetailTopBottomMargin: CGFloat = 25
}
