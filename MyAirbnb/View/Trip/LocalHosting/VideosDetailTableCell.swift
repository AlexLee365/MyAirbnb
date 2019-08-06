//
//  VideosDetailTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 15/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit

class VideosDetailTableCell: UITableViewCell {
    static let identifier = "VideosDetailTableCell"
    
    let courseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.text = "6일 여행 코스"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let regionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shortIntroLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 17.5)
        label.textColor = .white
        label.text = "Island hop around Galapagos for wild, up-close encounters and local food."
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 4.0)
        return label
    }()
    
    let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1).withAlphaComponent(0.3)
        return view
    }()
    
    let infoArray = [("진행시간", "6일"),
                     ("활동 강도", "낮음"),
                     ("제공 언어", "영어"),
                     ("포함사항", "Equipment, Transportation, Drinks, Accommodations, Food")]
    
    var infoCategoryViewArray = [InfoCategoryView]()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    
        setInfoView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.selectionStyle = .none
        contentView.backgroundColor = .black
        
        contentView.addSubview(courseLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(regionLabel)
        contentView.addSubview(shortIntroLabel)
        contentView.addSubview(separatorLineView)
    }
    
    private func setAutolayout() {
        courseLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        courseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: courseLabel.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        regionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        regionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        shortIntroLabel.snp.makeConstraints { (make) in
            make.top.equalTo(regionLabel.snp.bottom).offset(30)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        separatorLineView.snp.makeConstraints { (make) in
            make.top.equalTo(shortIntroLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(0.35)
        }
    }
    
    
    private func setInfoView() {
        for i in 0..<infoArray.count {
            let infoCategoryView = InfoCategoryView()
            
            infoCategoryView.iconImageView.image = setIconImage(category: infoArray[i].0)
            infoCategoryView.categoryTitleLabel.text = infoArray[i].0
            
            infoCategoryViewArray.append(infoCategoryView)
        }
        
        for i in 0..<infoCategoryViewArray.count {
            contentView.addSubview(infoCategoryViewArray[i])
            
            let viewWidth = ((UIScreen.main.bounds.width - 40) / 2) - 5
            
            infoCategoryViewArray[i].snp.makeConstraints { (make) in
                make.width.equalTo(viewWidth)
            }
            
            switch i {
            case 0:
                infoCategoryViewArray[i].snp.makeConstraints { (make) in
                    make.top.equalTo(separatorLineView.snp.bottom).offset(20)
                    make.leading.equalTo(20)
                }
            case 1:
                infoCategoryViewArray[i].snp.makeConstraints { (make) in
                    make.top.equalTo(separatorLineView.snp.bottom).offset(20)
                    make.trailing.equalTo(-20)
                }
            case 2:
                infoCategoryViewArray[i].snp.makeConstraints { (make) in
                    make.top.equalTo(infoCategoryViewArray[i - 2].snp.bottom).offset(20)
                    make.leading.equalTo(20)
                }
            case 3:
                infoCategoryViewArray[i].snp.makeConstraints { (make) in
                    make.top.equalTo(infoCategoryViewArray[i - 2].snp.bottom).offset(20)
                    make.trailing.equalTo(-20)
                    make.bottom.equalTo(-30)
                }
            default: break
            }
        }
    }
    
    
    private func setIconImage(category: String) -> UIImage {
        var imageString = ""
        
        switch category {
        case "진행시간":
            imageString = "videoDetail_timeIcon"
        case "활동 강도":
            imageString = "videoDetail_activityLevelIcon"
        case "제공 언어":
            imageString = "videoDetail_langIcon"
        case "포함사항":
            imageString = "videoDetail_includeIcon"
        case "그룹당 인원":
            imageString = "videoDetail_capsIcon"
        default: break
        }
        
        return UIImage(named: imageString)!
    }
    

    var flag = false

    func setData(tripDetail: TripDetail) {
        guard flag == false else { return }
        
        flag = true
        
        titleLabel.text = tripDetail.name
        regionLabel.text = "\(tripDetail.state.name), \(tripDetail.state.country)"
        infoCategoryViewArray[0].descLabel.text = "\(tripDetail.durationTime)일"
        infoCategoryViewArray[1].descLabel.text = tripDetail.strength
        infoCategoryViewArray[2].descLabel.text = tripDetail.language
        
        var provideString = ""
        
        if tripDetail.provides.isEmpty {
            infoCategoryViewArray[3].iconImageView.isHidden = true
            infoCategoryViewArray[3].categoryTitleLabel.isHidden = true
            infoCategoryViewArray[3].descLabel.text = ""
            
            infoCategoryViewArray[2].snp.makeConstraints { (make) in
                make.top.equalTo(infoCategoryViewArray[0].snp.bottom).offset(20)
                make.leading.equalTo(20)
                make.bottom.equalTo(-20)
            }
            
            infoCategoryViewArray[3].snp.makeConstraints { (make) in
                make.top.equalTo(infoCategoryViewArray[1].snp.bottom).offset(20)
                make.trailing.equalTo(-20)
            }
            
        } else {
            for i in 0..<tripDetail.provides.count {
                provideString += "\(tripDetail.provides[i]?.provideSet ?? ""), "
            }
            provideString.removeLast()
            provideString.removeLast()
    
            infoCategoryViewArray[3].descLabel.text = provideString
        }
    }
}
