//
//  CalenderViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 15/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView

class CalenderViewController: UIViewController {
    
    // MARK: - UI Properties
    let backgroundView = UIView()
    
    let containerView = UIView()
    let topTextLabel = UILabel()
    let refreshBtn = UIButton()
    var weekdayLabel = UILabel()
    let seperateLineViewTop = UIView()
    let seperateLineViewBottom = UIView()
    let resultBtn = UIButtonWithHighlightEffect()
    
    private weak var calendar: FSCalendar!
    let indicator = NVActivityIndicatorView(frame: .zero)
    
    // MARK: - Properties
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    let notiCenter = NotificationCenter.default
    let netWork = NetworkCommunicator()
    let jsonDecoder = JSONDecoder()
    let kingfisher = ImageDownloader.default
    
    var beginDatesArray = [Date]() {
        didSet {
            print("🔵🔵🔵 beginDatesArray didSet")
            selectedDatesArray = beginDatesArray
            
//            guard beginDatesArray.count > 1 else {
//                calendar.select(beginDatesArray.first!)
//                return
//            }
//            print(selectedDatesArray)
//            selectDateCells()
        }
    }
    var selectedDatesArray = [Date]() {
        didSet {
            guard selectedDatesArray.count > 0 else { return }
            selectedDatesString = setTextFromDate(datesArray: selectedDatesArray)
            
        }
    }
    var selectedDatesString = "날짜 선택" {
        didSet {
            guard selectedDatesString != "날짜 선택" else {
                topTextLabel.text = "날짜 선택"
                return
            }
            topTextLabel.text = selectedDatesString
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundView()
        setCalendar()
        setAutoLayout()
        configureViewsOptions()
        setIndicatorView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAnimation()
        
        guard beginDatesArray.count > 0 else { return }
        calendar.select(beginDatesArray.first!)
        
        refreshBtn.isEnabled = true
        refreshBtn.layer.opacity = 1
        
        if beginDatesArray.count > 1 {
            print(" 😘 ", selectedDatesArray)
            selectDateCells()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    private func setBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.frame = view.frame
        backgroundView.backgroundColor = .white
        backgroundView.alpha = 0
    }
    

    private func setAutoLayout() {
        let safeGuide = view.safeAreaLayoutGuide
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 80).isActive = true
        containerView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 15).isActive = true
        containerView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -15).isActive = true
//        containerView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: -200).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 430).isActive = true
        
        containerView.addSubview(topTextLabel)
        topTextLabel.translatesAutoresizingMaskIntoConstraints = false
        topTextLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15).isActive = true
        topTextLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(refreshBtn)
        refreshBtn.translatesAutoresizingMaskIntoConstraints = false
        refreshBtn.centerYAnchor.constraint(equalTo: topTextLabel.centerYAnchor).isActive = true
        refreshBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -3).isActive = true
        refreshBtn.widthAnchor.constraint(equalToConstant: 60).isActive = true
        refreshBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let weekDays = ["일", "월", "화", "수", "목", "금", "토"]
        var leadingConst:CGFloat = 20
        let letterWidth = "가".size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)]).width
        let letterPadding = (UIScreen.main.bounds.width - 30 - leadingConst*2 - letterWidth ) / 6
        
        for i in 0...6 {
            let label = UILabel()
            containerView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: topTextLabel.bottomAnchor, constant: 15).isActive = true
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leadingConst).isActive = true
            label.text = weekDays[i]
            label.textColor = #colorLiteral(red: 0.1990053952, green: 0.1978290677, blue: 0.1999138892, alpha: 0.8544252997)
            label.font = .systemFont(ofSize: 11, weight: .regular)
            
            leadingConst += letterPadding
            ( i == 6 ) ? (weekdayLabel = label) : ()
        }
        
        containerView.addSubview(seperateLineViewTop)
        seperateLineViewTop.translatesAutoresizingMaskIntoConstraints = false
        seperateLineViewTop.topAnchor.constraint(equalTo: weekdayLabel.bottomAnchor, constant: 5).isActive = true
        seperateLineViewTop.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        seperateLineViewTop.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        seperateLineViewTop.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        containerView.addSubview(resultBtn)
        resultBtn.translatesAutoresizingMaskIntoConstraints = false
        resultBtn.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        resultBtn.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        resultBtn.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1).isActive = true
        resultBtn.heightAnchor.constraint(equalToConstant: 43).isActive = true
        
        containerView.addSubview(seperateLineViewBottom)
        seperateLineViewBottom.translatesAutoresizingMaskIntoConstraints = false
        seperateLineViewBottom.bottomAnchor.constraint(equalTo: resultBtn.topAnchor, constant: 0).isActive = true
        seperateLineViewBottom.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        seperateLineViewBottom.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        seperateLineViewBottom.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        containerView.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.topAnchor.constraint(equalTo: seperateLineViewTop.bottomAnchor, constant: 0).isActive = true
        calendar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        calendar.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        calendar.bottomAnchor.constraint(equalTo: seperateLineViewBottom.topAnchor, constant: 0).isActive = true
    }
    
    private func configureViewsOptions() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 5
        containerView.alpha = 0
        
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 0.6
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowRadius = 5
        
        topTextLabel.text = selectedDatesString
        topTextLabel.textAlignment = .center
        topTextLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        topTextLabel.textColor = #colorLiteral(red: 0.1990053952, green: 0.1978290677, blue: 0.1999138892, alpha: 0.8544252997)
        
        refreshBtn.setTitle("지우기", for: .normal)
        refreshBtn.setTitleColor(UIColor(red:0.09, green:0.51, blue:0.54, alpha:1.0), for: .normal)
        refreshBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        refreshBtn.addTarget(self, action: #selector(refreshBtnDidTap(_:)), for: .touchUpInside)
        refreshBtn.isEnabled = false
        refreshBtn.layer.opacity = 0.5
        resultBtn.addTarget(self, action: #selector(resultBtnDidTap(_:)), for: .touchUpInside)
        
        seperateLineViewTop.backgroundColor = #colorLiteral(red: 0.5761868954, green: 0.5727648139, blue: 0.5788194537, alpha: 0.4162831764)
        seperateLineViewBottom.backgroundColor = #colorLiteral(red: 0.5761868954, green: 0.5727648139, blue: 0.5788194537, alpha: 0.4162831764)
        
        resultBtn.setTitle("결과 보기", for: .normal)
        resultBtn.setTitleColor(UIColor(red:0.09, green:0.51, blue:0.54, alpha:1.0), for: .normal)
        resultBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
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
        calendar.headerHeight = 35
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 13, weight: .semibold)
        calendar.appearance.headerTitleColor = .black
        
        calendar.weekdayHeight = 15
        calendar.appearance.weekdayTextColor = .clear
        
        calendar.appearance.titleFont = .systemFont(ofSize: 13, weight: .semibold)
        calendar.appearance.titleDefaultColor = #colorLiteral(red: 0.1990053952, green: 0.1978290677, blue: 0.1999138892, alpha: 0.8544252997)
        calendar.appearance.titlePlaceholderColor = #colorLiteral(red: 0.7327679992, green: 0.7284137607, blue: 0.7361161113, alpha: 0.4171660959)
        calendar.appearance.selectionColor = UIColor(red:0.09, green:0.51, blue:0.54, alpha:1.0)
        
        view.addSubview(calendar)
        self.calendar = calendar
    }
    
    private func setAnimation() {
        UIView.animate(withDuration: 0.2) {
            self.backgroundView.alpha = 0.5
            self.containerView.transform = CGAffineTransform(translationX: 0, y: -10)
            self.containerView.alpha = 1
        }
    }
    
    private func setIndicatorView() {
        let centerX = UIScreen.main.bounds.width/2
        let centerY = UIScreen.main.bounds.height/2
        resultBtn.addSubview(indicator)
        indicator.frame = CGRect(x: centerX-23, y: 9, width: 23, height: 23)
        indicator.type = .ballBeat
        indicator.color = StandardUIValue.shared.colorBlueGreen
    }

    
    @objc func refreshBtnDidTap(_ sender: UIButton) {
        print("didTap")
        selectedDatesString = "날짜 선택"
        selectedDatesArray.forEach{
            calendar.deselect($0)
        }
        selectedDatesArray.removeAll()
        sender.isEnabled = false
        sender.layer.opacity = 0.5
    }
    
    @objc func resultBtnDidTap(_ sender: UIButton) {
        print("--------------------------[resultBtnDidTap]--------------------------")
        print(selectedDatesString)
//        guard let naviVC = presentingViewController as? UINavigationController else { print("navi convert error"); return }
        
        guard let tabbarVC = presentingViewController as? TabbarController else { print("tabbarVC convert error"); return }
        guard let naviVC = tabbarVC.viewControllers?.first as? UINavigationController else { print("navi convert error"); return }
        
        
        if let mainVC = naviVC.viewControllers.first as? MainViewController {
            print("mainVC")
            
            if self.selectedDatesString == "날짜 선택" {
                mainVC.searchBarView.selectedDatesArray.removeAll()
                mainVC.searchBarView.selectedDateString = "날짜"
                dismissWithAnimation()
            } else {
                resultBtn.setTitle("", for: .normal)
                indicator.startAnimating()
                
                mainVC.searchBarView.selectedDateString = selectedDatesString
                mainVC.searchBarView.selectedDatesArray = selectedDatesArray
                
                var houseViewDataArray = [HouseViewData]()
                getServerDataWithDate { (houseDataArray, success) in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        
                        switch success {
                        case true:
                            print("--------------------------[CalendarVC serfverData Success]--------------------------")
                            let houseviewDataIntroLabel = HouseViewData(
                                data: [HouseIntroLabelDataInList(intro: "여행 날짜와 게스트 인원수를 입력하면 1박당 총 요금을 확인할 수 있습니다. 관광세가 추가로 부과될 수 있습니다.")],
                                cellStyle: .introLabel)
                            let houseviewDataTitleLabel = HouseViewData(
                                data: [HouseTitleLabelDataInList(title: "300개 이상의 숙소 모두 둘러보기")], cellStyle: .titleLabel)
                            let houseviewDataNormal = HouseViewData(data: houseDataArray!, cellStyle: .normalHouse)
                            houseViewDataArray = [houseviewDataIntroLabel, houseviewDataTitleLabel, houseviewDataNormal]
                        case false:
                            print("--------------------------[CalendarVC serfverData False]--------------------------")
                            let houseviewDataIntroLabel = HouseViewData(
                                data: [HouseIntroLabelDataInList(intro: "숙소 결과가 없습니다.")],
                                cellStyle: .introLabel)
                            houseViewDataArray = [houseviewDataIntroLabel]
                        }
                        self.notiCenter.post(name: .searchBarDateResultBtnDidTap, object: nil, userInfo: ["houseViewDataArray": houseViewDataArray])
                        self.dismissWithAnimation()
                    }
                    
                   
                }
            }
            
        }
//        else if let tripVC = presentingViewController as? TripViewController {
//            print("tripVC")
//        }
        
    }
    
    private func lastDayOfMonth(date: Date) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        let range = calendar.range(of: .day, in: .month, for: date)!
        components.day = range.upperBound - 1
        return calendar.date(from: components)!
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLocation = touches.first!.location(in: view)
        print(touchLocation)
        
        guard !containerView.frame.contains(touchLocation) else { return }
        
        
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundView.alpha = 0
            self.containerView.transform = CGAffineTransform.identity
            self.containerView.alpha = 0
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    private func dismissWithAnimation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundView.alpha = 0
            self.containerView.transform = CGAffineTransform.identity
            self.containerView.alpha = 0
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    private func getServerDataWithDate(completion: @escaping ([HouseDataInList]?, Bool) -> ()) {
        let startDate = selectedDatesArray.first?.getDateStringFormatYearMonthDay(dateFormat: "yyyy-MM-dd") ?? ""
        let endDate = selectedDatesArray.last?.getDateStringFormatYearMonthDay(dateFormat: "yyyy-MM-dd") ?? ""
        let urlString = netWork.basicUrlString
            + "/rooms/?search=seoul&ordering=total_rating&page_size=5&page=1"
            + "&start_date=\(startDate)&end_date=\(endDate)"
        
        netWork.getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json, success) in
            guard success else {
                return
            }
            
            guard let object = json as? [String: Any]
                , let resultArray = object["results"] as? [[String: Any]]
                else { print("object convert error"); return }
            
            guard let data = try? JSONSerialization.data(withJSONObject: resultArray) else {
                print("‼️ CalendarVC data convert error")
                return
            }
            guard var houseArray = try? self.jsonDecoder.decode([HouseDataInList].self, from: data)
                , houseArray.count > 0 else {
                print("‼️ CalendarVC result decoding convert error")
                completion(nil, false)
                return
            }
            
            for i in 0..<houseArray.count {
                guard let url = URL(string: houseArray[i].image) else { print("‼️ CalendarVC kingfisher url "); return }
                self.kingfisher.downloadImage(with: url, completionHandler: { (result) in
                    switch result {
                    case .success(let value):
                        houseArray[i].imageArray.append(value.image)
                    case .failure(let error):
                        print("‼️ LaunchVC kinfisher: ", error.localizedDescription)
                    }
                    
                    (i == houseArray.count - 1) ? completion(houseArray, true) : ()
                })
            }
        }
    }

}


extension CalenderViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        print("--------------------------[ShouldSelect]--------------------------")
        guard calendar.cell(for: date, at: monthPosition)?.isPlaceholder == false else {
            print("placeholder cell")
            return false
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        let selectDateString = dateFormatter.string(from: date)
        print("selectDateString: ", selectDateString)
        
        
        dateFormatter.dateFormat = "MM.dd"
        let currentDay = dateFormatter.string(from: currentDate)
        let selectDay = dateFormatter.string(from: date)
        print("currentDay: ", currentDay)
        print("selectDay: ", selectDay)
        
        return true
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return currentDate
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        let laterDate = Calendar.current.date(byAdding: .month, value: 2, to: currentDate)!
        let lastDayMonth = lastDayOfMonth(date: laterDate)
        
        return lastDayMonth
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("--------------------------[DidSelect]--------------------------")
        refreshBtn.isEnabled = true
        refreshBtn.layer.opacity = 1
        
        switch selectedDatesArray.count {
        case 0:
            print("currentCount: ", selectedDatesArray.count)
            selectedDatesArray.append(date)
            print(selectedDatesArray)
        case 1:
            // 이미 1개가 선택되어있을때
            print("currentCount: ", selectedDatesArray.count)
            selectedDatesArray.append(date)
            selectedDatesArray.sort()
            
            selectDateCells()
            
            selectedDatesArray.sort()
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
    
    private func selectDateCells() {
        let timeGap = selectedDatesArray.last!.timeIntervalSince(selectedDatesArray.first!)
        let oneDayValue: TimeInterval = 3600 * 24
        let daysGap = Int(timeGap / oneDayValue)
        
        for i in 1...daysGap {
            let day = Calendar.current.date(byAdding: .day, value: i, to: selectedDatesArray.first!)!
            calendar.select(day)

            guard !selectedDatesArray.contains(day) else { continue }
            selectedDatesArray.append(day)
        }
//        selectedDatesArray.removeLast()
    }
    
    private func setTextFromDate(datesArray: [Date]) -> String{
        var dayString = ""
        
        let componentsStartDay = Calendar.current.dateComponents([.month, .day], from: selectedDatesArray.first!)
        
        if datesArray.count > 1 {
            let componentsEndDay = Calendar.current.dateComponents([.month, .day], from: selectedDatesArray.last!)
            dayString = "\(componentsStartDay.month!)월 \(componentsStartDay.day!)일 ~ \(componentsEndDay.month!)월 \(componentsEndDay.day!)일"
            return dayString
        }
        dayString = "\(componentsStartDay.month!)월 \(componentsStartDay.day!)일"
        return dayString
    }
}
