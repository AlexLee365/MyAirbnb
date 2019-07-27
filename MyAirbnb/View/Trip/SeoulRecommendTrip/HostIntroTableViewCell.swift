//
//  HostIntroTableViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 10/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class HostIntroTableViewCell: UITableViewCell {
    static let identifier = "hostIntroTableViewCell"
    
    var textIntroBody =
    """
        안녕하세요. 저는 비건 화장품 '멜릭서’의 대표 이하나입니다. \n멜릭서는 100% 식물성 성분만을 사용하며, 화장품 동물실험에 반대하는 비건 화장품 브랜드입니다. "내가 매일 사용하는 화장품으로도 환경에 기여할 수있을까?" 저는 지난 6년동안 화장품 회사에서 일을 하면서 수없이 생산되는 화장품들을 접했습니다. 오랜 시간에걸쳐 사람들이 조금 더 예뻐지기 위한 - 피부 미용을 위한 제품인 '화장품’의 생산 과정들을 알게 되었습니다. 그 과정에서 발생하는 많은 플라스틱으로 인한 환경 파괴와 동물 학대에 대해 알게되었고, 비거니즘을 화장품에 적용하면 어떨까라는 생각을 했습니다. 그래서 동물의 희생도 줄이고 또 동시에 피부에도 좋은 비건 화장품 브랜드를 만들게 되었습니다. 멜릭서는 비건이라는 생소한 분야를 알리고 비건 커뮤니티를 더 키워가고 싶어 이 클래스를 시작하였습니다:)
        """
    var textAddedGesture = ""
    
    let hostIntroLabel: UILabel = {
        let label = UILabel()
        label.configureTripDetailHostInfoTitle()
        label.text = "호스트 Hana님 소개"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "hana")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let touchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let messageButton: UIButton = {
        let button = UIButton()
        button.setTitle("메시지", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let introBody: UILabel = {
        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 17)
        label.setLineSpacing(lineSpacing: 4)
        label.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
        
    }
    
    var isLayout = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        if isLayout {
            
            isLayout = false
        }
        addGestureToIntroBodyLabel()
        print("layoutSubviews: ", introBody.attributedText?.string)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        contentView.addSubview(hostIntroLabel)
        contentView.addSubview(profileImage)
        contentView.addSubview(touchButton)
        contentView.addSubview(messageButton)
        contentView.addSubview(introBody)
        
        introBody.numberOfLines = 4
        introBody.text =
        """
        안녕하세요. 저는 비건 화장품 '멜릭서’의 대표 이하나입니다. \n멜릭서는 100% 식물성 성분만을 사용하며, 화장품 동물실험에 반대하는 비건 화장품 브랜드입니다.\n\n"내가 매일 사용하는 화장품으로도 환경에 기여할 수있을까?"\n\n저는 지난 6년동안 화장품 회사에서 일을 하면서 수없이 생산되는 화장품들을 접했습니다. 오랜 시간에걸쳐 사람들이 조금 더 예뻐지기 위한 - 피부 미용을 위한 제품인 '화장품’의 생산 과정들을 알게 되었습니다.\n\n그 과정에서 발생하는 많은 플라스틱으로 인한 환경 파괴와 동물 학대에 대해 알게되었고, 비거니즘을 화장품에 적용하면 어떨까라는 생각을 했습니다. 그래서 동물의 희생도 줄이고 또 동시에 피부에도 좋은 비건 화장품 브랜드를 만들게 되었습니다.\n\n멜릭서는 비건이라는 생소한 분야를 알리고 비건 커뮤니티를 더 키워가고 싶어 이 클래스를 시작하였습니다 :)
        """
        
        let readmoreFont = UIFont(name: "Helvetica-Oblique", size: 17.0)
        let readmoreFontColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        
        DispatchQueue.main.async {
            self.introBody.addTrailing(with: "...", moreText: "더 보기", moreTextFont: readmoreFont!, moreTextColor: readmoreFontColor)
        }
        
    }
    
    private func addGestureToIntroBodyLabel() {
        textAddedGesture = introBody.attributedText!.string
        //        introBody.text = text2
        introBody.textColor =  UIColor.black
        let underlineAttriString = NSMutableAttributedString(string: textAddedGesture)
        let range1 = (textAddedGesture as NSString).range(of: "더 보기")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Helvetica-Oblique", size: 17.0), range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1), range: range1)
        introBody.attributedText = underlineAttriString
        introBody.isUserInteractionEnabled = true
        introBody.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        print(textAddedGesture)
        let termsRange = (textAddedGesture as NSString).range(of: "더 보기")
        // comment for now
        let privacyRange = (textAddedGesture as NSString).range(of: "Privacy Policy")
        
        if gesture.didTapAttributedTextInLabel(label: introBody, inRange: termsRange) {
            print("Tapped terms")
            guard let superTableView = self.superview as? UITableView else { print("Failed");return }
            let currentY = superTableView.contentOffset.y
            print(currentY)
            
            introBody.numberOfLines = 0
            
            self.introBody.text = self.textIntroBody
            
//            DispatchQueue.main.async {
//            superTableView.contentOffset.y = currentY
//                superTableView.reloadData()
//            superTableView.contentOffset = CGPoint(x: 0, y: currentY)
//            superTableView.moveRow(at: IndexPath(row: 1, section: 0), to: IndexPath(row: 1, section: 0))
//            superTableView.reloadData()
//            superTableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
//            superTableView.scrollToRow(at: [IndexPath(row: 1, section: 0)], at: .top, animated: true)
            superTableView.reloadSections(IndexSet.init(integer: 0), with: .none)
            
//            }
            self.layoutIfNeeded()
            
            
        } else if gesture.didTapAttributedTextInLabel(label: introBody, inRange: privacyRange) {
            print("Tapped privacy")
        } else {
            print("Tapped none")
        }
    }
    
    private func setAutolayout() {
        
        let sideMargin = StandardUIValue.shared.mainViewSideMargin
        
        hostIntroLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        hostIntroLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        
        profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        profileImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideMargin).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        touchButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        touchButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        touchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        touchButton.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        messageButton.topAnchor.constraint(equalTo: hostIntroLabel.bottomAnchor, constant: 15).isActive = true
        messageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        
        introBody.topAnchor.constraint(equalTo: touchButton.bottomAnchor, constant: 5).isActive = true
        introBody.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
        introBody.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideMargin).isActive = true
        
        let space = UIView()
        space.backgroundColor = .yellow
        contentView.addSubview(space)
        space.translatesAutoresizingMaskIntoConstraints = false
        space.topAnchor.constraint(equalTo: introBody.bottomAnchor).isActive = true
        space.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        space.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        //        space.heightAnchor.constraint(equalToConstant: 3).isActive = true
        space.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    
}
