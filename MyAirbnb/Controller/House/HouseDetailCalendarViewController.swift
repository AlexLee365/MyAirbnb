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
    
    private weak var calendar: FSCalendar!
    
    
    // MARK: - Properties
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    let notiCenter = NotificationCenter.default
    let netWork = NetworkCommunicator()
    let jsonDecoder = JSONDecoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendar()
        setAutoLayout()
        configureViewsOptions()
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
        
        view.addSubview(calendar)
        calendar.snp.makeConstraints { (make) in
            make.top.equalTo(seperateLineViewTop.snp.bottom).offset(0)
            make.bottom.leading.trailing.equalTo(safeGuide)
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
//        deleteBtn.backgroundColor = .yellow
        
        let font = UIFont.systemFont(ofSize: 23, weight: .regular)
        let textColor = StandardUIValue.shared.colorRegularText
        
        checkInTextLabel.font = font
        checkInTextLabel.textColor = textColor
        checkInTextLabel.text = "체크인"
        
        checkInDateLabel.font = font
        checkInDateLabel.textColor = textColor
        checkInDateLabel.text = "8월 1일"
        
        topCenterImageView.contentMode = .scaleAspectFit
        topCenterImageView.image = UIImage(named: "diagnoalLine")
        
        checkOutTextLabel.font = font
        checkOutTextLabel.textColor = textColor
        checkOutTextLabel.text = "체크아웃"
        checkOutTextLabel.textAlignment = .right
        
        checkOutDateLabel.font = font
        checkOutDateLabel.textColor = textColor
        checkOutDateLabel.text = "8월 5일"
        checkOutDateLabel.textAlignment = .right
        
        seperateLineViewTop.backgroundColor = #colorLiteral(red: 0.7567283511, green: 0.7522315383, blue: 0.7601861954, alpha: 0.4162831764)
        
        
        
    }
    
    @objc private func cancelBtnDidTap(_ sender: UIButton) {
        dismiss(animated: true)
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
        calendar.appearance.titleDefaultColor = #colorLiteral(red: 0.1990053952, green: 0.1978290677, blue: 0.1999138892, alpha: 0.8544252997)
        calendar.appearance.titlePlaceholderColor = #colorLiteral(red: 0.7327679992, green: 0.7284137607, blue: 0.7361161113, alpha: 0.4171660959)
        calendar.appearance.subtitleFont = .systemFont(ofSize: 13, weight: .bold)
        calendar.appearance.selectionColor = UIColor(red:0.09, green:0.51, blue:0.54, alpha:1.0)
        
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
}
