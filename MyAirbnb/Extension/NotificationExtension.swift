//
//  NotificationExtension.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 30/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

extension Notification.Name {
    // MARK: - SearchBarView
    static let searchBarEditBegin = Notification.Name(rawValue: "SearchBarEditBegin")
    static let searchBarEditEnd = Notification.Name(rawValue: "SearchBarEditEnd")
    static let searchBarEditingChanged = Notification.Name("SearchBarEditingChanged")
    static let searchBarEnterPressed = Notification.Name("SearchBarEnterPressed")
    
    static let searchBarTableViewScrolled = Notification.Name("SearchBarTableViewScrolled")
    static let searchBarTableCellSelected = Notification.Name("SearchBarTableCellSelected")
    
    static let searchBarDateBtnDidTap = Notification.Name(rawValue: "SearchBarDateBtnDidTap")
    static let searchBarDateResultBtnDidTap = Notification.Name(rawValue: "SearchBarDateResultBtnDidTap")
    static let searchBarPeopleBtnDidTap = Notification.Name(rawValue: "SearchBarPeopleBtnDidTap")
    static let searchBarPeopleResultBtnDidTap = Notification.Name("SearchBarPeopleResultBtnDidTap")
    static let searchBarFilterBtnDidTap = Notification.Name(rawValue: "SearchBarFilterBtnDidTap")
    static let searchBarFilterResultBtnDidTap = Notification.Name("SearchBarFilterResultBtnDidTap")
    
    // MARK: - House
    static let moveToHouseView = Notification.Name(rawValue: "MoveToHouseView")
    static let moveToHouseDetailView = Notification.Name("MoveToHouseDetailView")
    static let moveToPlusHouseDetailView = Notification.Name(rawValue: "MoveToPlusHouseDetailView")
    static let moveToLuxeHouseDetailView = Notification.Name("MoveToLuxeHouseDetailView")
    
    static let mapViewDidTapInHouseDetailView = Notification.Name("MapViewDidTapInHouseDetailView")
    
    // MARK: - Trip
    static let moveToTripViewController = Notification.Name("MoveToTripViewController")
    static let moveToTripDetailView = Notification.Name("moveToTripDetailView")
    
    // MARK: - FilterRemainsVC
    static let instantBookSwitchTapped = Notification.Name("InstantBookSwitchTapped")
    static let houseGradeSwitchTapped = Notification.Name("HouseGradeSwitchTapped")
    static let priceSliderDidChanged = Notification.Name("PriceSliderDidChanged")
    static let houseTypeSwitchTapped = Notification.Name("HouseTypeSwitchTapped")
    static let bedroomsCountChanged = Notification.Name("BedroomsCountChanged")
    static let facilitiesInsideChecked = Notification.Name("FacilitiesInsideChecked")
    static let facilitiesInsideSeeMoreBtnDidTap = Notification.Name("FacilitiesInsideSeeMoreBtnDidTap")
    static let facilitiesOutsideChecked = Notification.Name("FacilitiesOutsideChecked")
    static let facilitiesOutsideSeeMoreBtnDidTap = Notification.Name("FacilitiesOutsideSeeMoreBtnDidTap")
    static let buildingTypeChecked = Notification.Name("BuildingTypeChecked")
    static let buildingTypeSeeMoreBtnDidTap = Notification.Name("BuildingTypeSeeMoreBtnDidTap")
    static let uniqueHouseChecked = Notification.Name("UniqueHouseChecked")
    static let uniqueHouseSeeMoreBtnDidTap = Notification.Name("UniqueHouseSeeMoreBtnDidTap")
    static let useRulesChecked = Notification.Name("UseRulesChecked")
    
    // MARK: - Else
    static let downloadingMessagesDataFinished = Notification.Name("DownloadingMessagesDataFinished")
//    static let moveToFavoriteHouseDetailVC = Notification.Name("moveToFavoriteHouseDetailVC")
    static let moveToHouseDetailVCFromFavoriteList = Notification.Name("MoveToHouseDetailVCFromFavoriteList")
}
