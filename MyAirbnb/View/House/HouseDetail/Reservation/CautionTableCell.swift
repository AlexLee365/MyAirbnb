//
//  CautionTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 01/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class CautionTableCell: UITableViewCell {
    static let identifier = "CautionTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "주의할 사항"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 18)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let cautionView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 0.367963399)
        return view
    }()
    
    let cautionLabel: UILabel = {
        let label = UILabel()
        label.text = "숙소에 일산화탄소 경보기가 설치되어 있는지 호스트가 신고하지 않았습니다. 휴대용 경보기를 챙겨가실것을 권해드립니다."
        label.numberOfLines = 0
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 17)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.setLineSpacing(lineSpacing: 4.0)
        return label
    }()
    
    let cautionsArray = ["키패드(으)로 셀프 체크인", "어린이(만 2~12세)에게 적합함", "유아(만 2세 미만)에게 적합하지 않음", "반려동물 동반 불가", "파티나 이벤트 금지", "흡연 금지", "계단을 올라가야 함"]
    
    var cautionViewsArray = [UIView]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.selectionStyle = .none
        self.hideSeparator()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(cautionView)
        cautionView.addSubview(cautionLabel)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
        }
        
        cautionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        cautionLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20)
            make.trailing.bottom.equalTo(-20)
        }
        
        setCautionView()
    }
    
    private func setCautionView() {
        for i in 0..<cautionsArray.count {
            let view = CautionWithImageView()
            
            view.imageView.image = setCautionImage(caution: cautionsArray[i])
            view.label.text = cautionsArray[i]
            cautionViewsArray.append(view)
        }
        
        for i in 0..<cautionViewsArray.count {
            contentView.addSubview(cautionViewsArray[i])
            
            cautionViewsArray[i].snp.makeConstraints { (make) in
                make.leading.equalTo(20)
                make.trailing.equalTo(-20)
            }
            
            switch i {
            case 0:
                cautionViewsArray[i].snp.makeConstraints { (make) in
                    make.top.equalTo(cautionView.snp.bottom).offset(15)
                }
            case cautionViewsArray.count - 1:
                cautionViewsArray[i].snp.makeConstraints { (make) in
                    make.bottom.equalTo(-20)
                }
                fallthrough
            default:
                cautionViewsArray[i].snp.makeConstraints { (make) in
                    make.top.equalTo(cautionViewsArray[i-1].snp.bottom).offset(20)
                }
            }
        }
    }
    
    
    private func setCautionImage(caution: String) -> UIImage {
        var imageString = ""
        
        switch caution {
        case "키패드(으)로 셀프 체크인":
            imageString = "selfKeypadCheck"
        case "어린이(만 2~12세)에게 적합함":
            imageString = "ageTwoToTwelve"
        case "유아(만 2세 미만)에게 적합하지 않음":
            imageString = "notUndertwo"
        case "반려동물 동반 불가":
            imageString = "noPets"
        case "파티나 이벤트 금지":
            imageString = "noParty"
        case "흡연 금지":
            imageString = "noSmoke"
        case "계단을 올라가야 함":
            imageString = "stairs"
        default: break
        }
        return UIImage(named: imageString) ?? UIImage()
    }
}


class CautionWithImageView: UIView {
  
    let view: UIView = {
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.8786119435)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 3
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(view)
        view.addSubview(imageView)
        self.addSubview(label)
    }
    
    private func setAutolayout() {
        view.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalToSuperview()
            make.width.height.equalTo(55)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(view.snp.trailing).offset(10)
        }
    }
}
