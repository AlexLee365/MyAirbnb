//
//  CheckboxTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 19/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class CheckboxTableCell: UITableViewCell {
    static let identifier = "CheckboxTableCell"
    
    static let style = UITableViewCell.CellStyle.init(rawValue: 0)
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.8, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seeAllBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var currentIndex = 0
    
    var chekcBoxSelectedState = false
    
    var inputCheckboxData: CheckBoxData?
    var checkBoxViewArray = [CheckBoxContainerView]()
    var customViewsAreMade = false
    let notiCenter = NotificationCenter.default
    var seeAllBtnArray = [UIButton]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("--------------------------[Cell init]--------------------------")
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        guard setDataOnce == false else { return }
        for checkboxView in checkBoxViewArray {
            checkboxView.isHidden = true
        }
//        seeAllBtnArray.last?.isHidden = true
    }
    
    
    private func configure() {
        self.selectionStyle = .none
        contentView.addSubview(title)
        contentView.addSubview(seeAllBtn)
    }
    
    private func setAutolayout() {
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        seeAllBtn.translatesAutoresizingMaskIntoConstraints = false
        seeAllBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        seeAllBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        seeAllBtn.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    
    var setDataOnce = false
    func setData(inputData: CheckBoxData) {
        guard setDataOnce == false else { return }
        title.text = inputData.title
        seeAllBtn.setTitle(inputData.buttonTitle, for: .normal)
        seeAllBtn.addTarget(self, action: #selector(seeAllBtnDidTap(_:)), for: .touchUpInside)
        seeAllBtn.tag = 99
        
        let viewsCount = inputData.seeAllBtnState ? inputData.contentArray.count : 3
        print("setData viewsCount: ", viewsCount)
        
        makeContainerViews(checkBoxData: inputData, viewsCount: viewsCount)
        setCheckBoxState(contentArray: inputData.contentArray, viewsCount: viewsCount)
        setDataOnce = true
    }
    
    private func makeContainerViews(checkBoxData: CheckBoxData, viewsCount: Int) {
        print("makeContainerViews")
        checkBoxViewArray.removeAll()
        for index in 0..<viewsCount {
            print("for문 ", index)
            
            let customView = CheckBoxContainerView()
            customView.checkBox.addTarget(self, action: #selector(checkBoxBtnDidTap(_:)), for: .touchUpInside)
            customView.checkBox.tag = index
            customView.typeLabel.text = checkBoxData.contentArray[index].type
            
            checkBoxViewArray.append(customView)
            
            contentView.addSubview(customView)

            customView.translatesAutoresizingMaskIntoConstraints = false
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

            switch index {
            case 0:
                customView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25).isActive = true
            case viewsCount-1:
                // 마지막 customView => 바텀 추가적으로 잡아줌
                customView.bottomAnchor.constraint(equalTo: seeAllBtn.topAnchor, constant: -25).isActive = true
                fallthrough
            default:
                customView.topAnchor.constraint(equalTo: checkBoxViewArray[index - 1].bottomAnchor, constant: 25).isActive = true
            }
            print("type명: ", customView.typeLabel.text!)
        }
        
//        let seeAllBtn = UIButton()
//        contentView.addSubview(seeAllBtn)
//        seeAllBtn.snp.makeConstraints { (make) in
//            make.top.equalTo(checkBoxViewArray.last!.snp.bottom).offset(10)
//            make.leading.equalTo(20)
//            make.height.equalTo(35)
//            make.bottom.equalTo(-10)
//        }
//        seeAllBtn.setTitle(checkBoxData.buttonTitle, for: .normal)
//        seeAllBtn.addTarget(self, action: #selector(seeAllBtnDidTap(_:)), for: .touchUpInside)
//        seeAllBtn.tag = 99
//        seeAllBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
//        seeAllBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        seeAllBtnArray.append(seeAllBtn)
        
        

        print("함수 내 customViewsAreMade:  \(customViewsAreMade), view갯수: \(checkBoxViewArray.count)")
    }
    
    
    @objc func checkBoxBtnDidTap(_ sender: UIButton) {
        print("button did Tap")
        checkBoxViewArray[sender.tag].checkBtnSelectedState.toggle()
        notiCenter.post(name: .facilitiesInsideChecked, object: sender, userInfo: ["index": currentIndex])
    }
    
    @objc func seeAllBtnDidTap(_ sender: UIButton) {
        notiCenter.post(name: .facilitiesInsideSeeMoreBtnDidTap, object: sender, userInfo: ["index": currentIndex])
    }

    
    private func setCheckBoxState(contentArray: [Content], viewsCount: Int) {
        
        print("--------------------------[setCheckBoxState]--------------------------")
        print("viewCount: ", viewsCount)
        for index in 0..<viewsCount {
            print("for문 index: ", index)
            let containerView = checkBoxViewArray[index]
            containerView.checkBtnSelectedState = contentArray[index].checkBoxState
        }
        
    }
    

    
   
}


