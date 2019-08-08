//
//  HouseDetailCalendarViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 31/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class HouseDetailCalendarViewController: UIViewController {
    
    enum cellDateError: Error {
        case inUnavailableDate
        case overMaxStay
    }
    
    // MARK: - UI Properties
    let cancelBtn = UIButton()
    let deleteBtn = UIButton()
    
    let checkInTextLabel = UILabel()
    let checkInDateLabel = UILabel()
    let topCenterImageView = UIImageView()
    let checkOutTextLabel = UILabel()
    let checkOutDateLabel = UILabel()
    
    var weekdayLabel = UILabel()
    let seperateLineViewTop = UIView()
    
    let bottomView = BottomInfoView()
    let bottomInfoLabel = UILabel()
    let bottomSaveBtn = UIButton()
    
    private weak var calendar: FSCalendar!
    
    
    // MARK: - Properties
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    let notiCenter = NotificationCenter.default
    let netWork = NetworkCommunicator()
    let jsonDecoder = JSONDecoder()
    
    var houseDetailData: HouseDetailData?
    var bottomInfoText: String {
        if let data = houseDetailData {
            let host = ( data.host.first ?? "" ) ?? ""
            let minStay = data.minStay
            let result = "\(host)님의 숙소에는 \(minStay)박 이상 숙박해야 합니다."
            return result
        } else {
            return ""
        }
    }
    
    var selectedDatesArray = [Date]() {
        didSet {
            let calendar = Calendar.current
            switch selectedDatesArray.count {
            case 0:
                checkInDateLabel.text = ""
                checkOutDateLabel.text = ""
                bottomInfoLabel.text = bottomInfoText
                bottomSaveBtn.isEnabled = false
            case 1:
                let components = calendar.dateComponents([.month, .day], from: selectedDatesArray.first!)
                checkInDateLabel.text = "\(components.month ?? 0)월 \(components.day ?? 0)일"
                bottomInfoLabel.text = bottomInfoText
                bottomSaveBtn.isEnabled = true
            case 2...:
                let componentsIn = calendar.dateComponents([.month, .day], from: selectedDatesArray.first!)
                checkInDateLabel.text = "\(componentsIn.month ?? 0)월 \(componentsIn.day ?? 0)일"
                let componentsOut = calendar.dateComponents([.month, .day], from: selectedDatesArray.last!)
                checkOutDateLabel.text = "\(componentsOut.month ?? 0)월 \(componentsOut.day ?? 0)일"
                bottomInfoLabel.text = "\(selectedDatesArray.count-1)박 선택"
                bottomSaveBtn.isEnabled = true
            default: break
            }
        }
    }
    var selectedDatesString = "날짜 선택" {
        didSet {
        }
    }
    var unavailableDates = [Date]()
    var unavailableDatesString = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendar()
        setAutoLayout()
        configureViewsOptions()
        print("🔵🔵🔵 selectedArray: ", selectedDatesArray)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUnAvailableDates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        setUnAvailableDates()
    }
    
    
    
    private func setAutoLayout() {
        let safeGuide = view.safeAreaLayoutGuide
        
        view.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.top.equalTo(safeGuide).offset(0)
            make.leading.equalTo(safeGuide).offset(10)
            make.width.height.equalTo(40)
        }
        
        view.addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { (make) in
            make.top.equalTo(safeGuide).offset(0)
            make.trailing.equalTo(-10)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        
        // 체크인
        let sideMargin: CGFloat = 20
        view.addSubview(checkInTextLabel)
        checkInTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cancelBtn.snp.bottom).offset(15)
            make.leading.equalTo(sideMargin)
        }
        
        view.addSubview(checkInDateLabel)
        checkInDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(checkInTextLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.leading.equalTo(sideMargin)
        }
        
        view.addSubview(topCenterImageView)
        topCenterImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(checkInTextLabel.snp.top)
            make.height.width.equalTo(70)
        }
        
        // 체크아웃
        view.addSubview(checkOutTextLabel)
        checkOutTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(checkInTextLabel.snp.top)
            make.trailing.equalTo(-sideMargin)
        }
        
        view.addSubview(checkOutDateLabel)
        checkOutDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(checkOutTextLabel.snp.bottom).offset(10)
            make.height.equalTo(checkInDateLabel.snp.height)
            make.trailing.equalTo(-sideMargin)
        }
        
        let weekDays = ["일", "월", "화", "수", "목", "금", "토"]
        var leadingConst: CGFloat = 20
        let letterWidth = "가".size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]).width
        let letterPadding = (UIScreen.main.bounds.width - leadingConst*2 - letterWidth ) / 6
        
        for i in 0...6 {
            let label = UILabel()
            view.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.top.equalTo(checkInDateLabel.snp.bottom).offset(40)
                make.leading.equalTo(leadingConst)
            }
            label.text = weekDays[i]
            label.textColor = #colorLiteral(red: 0.1990053952, green: 0.1978290677, blue: 0.1999138892, alpha: 0.8544252997)
            label.font = .systemFont(ofSize: 15, weight: .semibold)
            
            leadingConst += letterPadding
            ( i == 6 ) ? (weekdayLabel = label) : ()
        }
        
        view.addSubview(seperateLineViewTop)
        seperateLineViewTop.snp.makeConstraints { (make) in
            make.top.equalTo(weekdayLabel.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(safeGuide)
            make.height.equalTo(80)
        }
        
        bottomView.addSubview(bottomInfoLabel)
        bottomInfoLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(sideMargin)
            make.width.equalToSuperview().multipliedBy(0.60)
        }
        
        bottomView.addSubview(bottomSaveBtn)
        bottomSaveBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(bottomInfoLabel.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-sideMargin)
            make.height.equalTo(50)
        }
    
        
        view.addSubview(calendar)
        calendar.snp.makeConstraints { (make) in
            make.top.equalTo(seperateLineViewTop.snp.bottom).offset(0)
            make.leading.trailing.equalTo(safeGuide)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        
    }

    private func configureViewsOptions() {
        view.backgroundColor = .white
        
        let inset: CGFloat = 10
        cancelBtn.setImage(UIImage(named: "close"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnDidTap(_:)), for: .touchUpInside)
        cancelBtn.imageView?.contentMode = .scaleAspectFit
        cancelBtn.imageEdgeInsets = UIEdgeInsets(top: inset/2, left: inset, bottom: inset, right: inset)
//        cancelBtn.backgroundColor = .yellow
        
        deleteBtn.setTitle("삭제", for: .normal)
        deleteBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 0)
        deleteBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        deleteBtn.setTitleColor(StandardUIValue.shared.colorRegularText, for: .normal)
        deleteBtn.addTarget(self, action: #selector(deleteBtnDidTap(_:)), for: .touchUpInside)
//        deleteBtn.backgroundColor = .yellow
        
        let font = UIFont.systemFont(ofSize: 23, weight: .regular)
        let textColor = StandardUIValue.shared.colorRegularText
        
        checkInTextLabel.font = font
        checkInTextLabel.textColor = textColor
        checkInTextLabel.text = "체크인"
        
        checkInDateLabel.font = font
        checkInDateLabel.textColor = textColor
        checkInDateLabel.text = ""
        
        topCenterImageView.contentMode = .scaleAspectFit
        topCenterImageView.image = UIImage(named: "diagonalLine2")
        
        checkOutTextLabel.font = font
        checkOutTextLabel.textColor = textColor
        checkOutTextLabel.text = "체크아웃"
        checkOutTextLabel.textAlignment = .right
        
        checkOutDateLabel.font = font
        checkOutDateLabel.textColor = textColor
        checkOutDateLabel.text = ""
        checkOutDateLabel.textAlignment = .right
        
        seperateLineViewTop.backgroundColor = #colorLiteral(red: 0.7567283511, green: 0.7522315383, blue: 0.7601861954, alpha: 0.4162831764)
        
        bottomView.backColor = .white
        bottomView.layer.masksToBounds = false
        bottomView.layer.shadowOpacity = 0.1
        bottomView.layer.shadowOffset = CGSize(width: 5, height: -7)
        bottomView.layer.shadowRadius = 3
        bottomView.layer.shadowColor = UIColor.gray.cgColor
        
        bottomInfoLabel.font = .systemFont(ofSize: 14, weight: .regular)
        bottomInfoLabel.numberOfLines = 0
        bottomInfoLabel.textColor = StandardUIValue.shared.colorRegularText
        if let data = houseDetailData {
            let host = ( data.host.first ?? "" ) ?? ""
            let minStay = data.minStay
            bottomInfoLabel.text = "\(host)님의 숙소에는 \(minStay)박 이상 숙박해야 합니다."
        }
        
        bottomSaveBtn.setTitle("저장 〉", for: .normal)
        bottomSaveBtn.setTitleColor(.white, for: .normal)
        bottomSaveBtn.backgroundColor = StandardUIValue.shared.colorBlueGreen
        bottomSaveBtn.layer.cornerRadius = 25
        bottomSaveBtn.addTarget(self, action: #selector(saveBtnDidTap(_:)), for: .touchUpInside)
    }
    
    private func setUnAvailableDates() {
        let reservationsString = houseDetailData?.reservations ?? []
//        print("--------------------------[Set Unavailable Dates]--------------------------")
//        print(reservationsString)
        
        for reservation in reservationsString {
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            guard let firstDate = dateFormatter.date(from: reservation.first ?? ""),
                let lastDate = dateFormatter.date(from: reservation.last ?? "") else { print("‼️ : "); return }
            unavailableDates.append(firstDate)  // 첫 날짜 배열에 저장
            
            let timeGap = lastDate.timeIntervalSince(firstDate)
            let oneDayValue: TimeInterval = 3600 * 24
            let daysGap = Int(timeGap / oneDayValue)
            
            for i in 1...daysGap {
                // 첫날 이후부터 하루씩 더해서 배열에 저장
                let day = Calendar.current.date(byAdding: .day, value: i, to: firstDate) ?? Date()
                unavailableDates.append(day)
            }
        }
        
        
        print("datesArray: ", unavailableDates)
        for date in unavailableDates {
            dateFormatter.dateFormat = "MM-dd"
            let dateString = dateFormatter.string(from: date)
            unavailableDatesString.append(dateString)
        }
        
        print("datesStringArray: ", unavailableDatesString)
        calendar.reloadData()
    }
    
    @objc private func cancelBtnDidTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func deleteBtnDidTap(_ sender: UIButton) {
        selectedDatesArray.forEach{
            calendar.deselect($0)
        }
        selectedDatesArray.removeAll()
    }
    
    @objc private func saveBtnDidTap(_ sender: UIButton) {
        guard selectedDatesArray.count > 1 else {
            makeAlert(title: "Message", message: "이틀 이상의 날짜를 선택해주세요.")
            return
        }
        
        if let tabbarVC = presentingViewController as? TabbarController,
            let naviVC = tabbarVC.viewControllers?.first as? UINavigationController,
            let houseDetailVC = naviVC.viewControllers.last as? HouseDetailViewController {
            
            houseDetailVC.selectedFilterInfo.0 = selectedDatesArray
            houseDetailVC.isDateSelected = true
            dismiss(animated: true)
        }
    
        if let tabbarVC = presentingViewController as? TabbarController,
            let naviVC = tabbarVC.viewControllers?[1] as? UINavigationController,
            let houseDetailVC = naviVC.viewControllers.last as? HouseDetailViewController {
            
            houseDetailVC.selectedFilterInfo.0 = selectedDatesArray
            houseDetailVC.isDateSelected = true
            dismiss(animated: true)
        }

        print("‼️ HouseDetailCalendarVC tabbar naviVC convert error / saveBtn Failed ")
    }
    
    private func setCalendar() {
        let calendar = FSCalendar(frame: .zero)
        calendar.dataSource = self
        calendar.delegate = self
        calendar.pagingEnabled = false
        calendar.scrollDirection = .vertical
        calendar.allowsMultipleSelection = true
        calendar.today = nil
        calendar.placeholderType = .none
        
        calendar.appearance.headerDateFormat = "M"
        calendar.headerHeight = 70
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 26, weight: .regular)
        calendar.appearance.headerTitleColor = #colorLiteral(red: 0.633825779, green: 0.6300606132, blue: 0.6367217898, alpha: 0.6661494007)
        
        calendar.weekdayHeight = 0
        calendar.appearance.weekdayTextColor = .clear
        
        calendar.appearance.titleFont = .systemFont(ofSize: 16, weight: .bold)
//        calendar.appearance.titleFont = UIFont(name: "AirbnbCerealApp-Book", size: 16)
        calendar.appearance.titleDefaultColor = #colorLiteral(red: 0.1990053952, green: 0.1978290677, blue: 0.1999138892, alpha: 0.8544252997)
        calendar.appearance.titlePlaceholderColor = #colorLiteral(red: 0.7327679992, green: 0.7284137607, blue: 0.7361161113, alpha: 0.4171660959)
        calendar.appearance.subtitleFont = .systemFont(ofSize: 8, weight: .semibold)
//        calendar.appearance.subtitleFont = UIFont(name: "AirbnbCerealApp-Book", size: 10)
        calendar.appearance.selectionColor = UIColor(red:0.09, green:0.51, blue:0.54, alpha:1.0)
        calendar.rowHeight = 50
        
        calendar.appearance.subtitlePlaceholderColor = .clear
        calendar.appearance.imageOffset = CGPoint(x: 0, y: -24)
        
        
        view.addSubview(calendar)
        self.calendar = calendar
    }
    
    
    private func lastDayOfMonth(date: Date) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        let range = calendar.range(of: .day, in: .month, for: date)!
        components.day = range.upperBound - 1
        return calendar.date(from: components)!
    }
    
    private func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { _ in }
        
        alert.addAction(action1)
        present(alert, animated: true)
    }
    
}


extension HouseDetailCalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func minimumDate(for calendar: FSCalendar) -> Date {
        return currentDate
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        let laterDate = Calendar.current.date(byAdding: .month, value: 5, to: currentDate)!
        let lastDayMonth = lastDayOfMonth(date: laterDate)
        
        return lastDayMonth
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        guard let houseData = houseDetailData else { return "" }
        let priceString = String(houseData.price)
        
        return "₩\(priceString)"
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
//        print("willDisplay cell date: ", date)
        
        dateFormatter.dateFormat = "MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        if unavailableDatesString.contains(dateString) {
            // 표시할 날짜가 예약 불가능한 날짜에 들어가있을 경우
            cell.subtitle = ""
            cell.titleLabel.textColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
            cell.titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        let cell = calendar.cell(for: date, at: .current)
        guard cell?.subtitle != "" else { return false }
        
        return true
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("--------------------------[DidSelect]--------------------------")
        switch selectedDatesArray.count {
        case 0:
            print("currentCount: ", selectedDatesArray.count)
            selectedDatesArray.append(date)
            print(selectedDatesArray)
        case 1:
            // 이미 1개가 선택되어있을때
            print("currentCount: ", selectedDatesArray.count)
            selectedDatesArray.append(date)
            
            switch selectDateCells() {
            case .success():
                break
            case .failure(.inUnavailableDate):
                makeAlert(title: "Message", message: "숙박할 수 없는 날짜가 포함되어있습니다.")
                calendar.deselect(selectedDatesArray.first ?? Date())
                calendar.deselect(selectedDatesArray.last ?? Date())
                selectedDatesArray.removeAll()
            case .failure(.overMaxStay):
                makeAlert(title: "Message", message: "\(houseDetailData?.maxStay ?? 0)박 이상 선택하실 수 없습니다.")
                calendar.deselect(selectedDatesArray.first ?? Date())
                calendar.deselect(selectedDatesArray.last ?? Date())
                selectedDatesArray.removeAll()
            }
            
            print(selectedDatesArray)
        case 2...:
            // 눌렀을때 이미 2개이상이 선택되있는 상황일때
            print("currentCount: ", selectedDatesArray.count)
            selectedDatesArray.forEach{
                calendar.deselect($0)
            }
            selectedDatesArray.removeAll()
            selectedDatesArray.append(date)
            print(selectedDatesArray)
        default : break
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("--------------------------[DidDeselect]--------------------------")
        if selectedDatesArray.contains(date) {
            selectedDatesArray.forEach{
                calendar.deselect($0)
            }
            selectedDatesArray.removeAll()
            calendar.select(date)
            selectedDatesArray.append(date)
            //            topTextLabel.text = setTextFromDate()
        }
        print(selectedDatesArray)
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let cell = calendar.cell(for: date, at: .current)
        
        dateFormatter.dateFormat = "MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        if unavailableDatesString.contains(dateString) {
            // 표시할 날짜가 예약 불가능한 날짜에 들어가있을 경우
            cell?.imageView.alpha = 0.5
            return UIImage(named: "CalendarDiagonalLine5")
        }
        
        return nil
    }
    
    private func selectDateCells() -> Result<(), cellDateError> {
        let firstSelectDay = selectedDatesArray.first ?? Date()
        let lastSelectDay = selectedDatesArray.last ?? Date()
        let fasterDay = (lastSelectDay > firstSelectDay) ? firstSelectDay : lastSelectDay
        
        var tempArray: [Date] = [firstSelectDay, lastSelectDay]
        
        let timeGap = (lastSelectDay > firstSelectDay) ? lastSelectDay.timeIntervalSince(firstSelectDay) : firstSelectDay.timeIntervalSince(lastSelectDay)
        let oneDayValue: TimeInterval = 3600 * 24
        let daysGap = Int(timeGap / oneDayValue)
        
        let maxStay = houseDetailData?.maxStay ?? 0
        
        for i in 1...daysGap {
            let day = Calendar.current.date(byAdding: .day, value: i, to: fasterDay) ?? Date()
            
            guard !tempArray.contains(day) else { continue }
            tempArray.append(day)
            
            guard !unavailableDates.contains(day) else { return .failure(.inUnavailableDate)}
            guard tempArray.count <= maxStay else { return .failure(.overMaxStay)}
        }
        
        selectedDatesArray = tempArray.sorted()
        for day in selectedDatesArray {
            calendar.select(day)
        }
        
        return .success(())
    }
}
