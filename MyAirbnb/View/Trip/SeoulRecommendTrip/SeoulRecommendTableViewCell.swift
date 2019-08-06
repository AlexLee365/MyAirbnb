//
//  SeoulRecommendTableViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 09/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class SeoulRecommendTableViewCell: UITableViewCell {
    static let identifier = "seoulRecommendTableViewCell"
    
    var images = ["bathbomb", "designownbathbomb", "shareyourconcept", "natural", "vegantherapy", "addcolors", "variousdesign", "perfectsouvenier"]
    var categories = ["공예 클래스", nil, nil, nil, nil, nil, nil, nil]
    var titles = ["나만의 색과 향을 담은 배쓰밤을 만들어보세요!", "Design your own bath bomb", "Share your concepts", "Vegan & Natural Ingredients", "Vegan Therapy", "Add colors as you want", "Various design", "Perfect souvenirs from Korea:)"]
    var scrollImageArray = [TopScrollView]()

    var iconsArray = ["locationIcon", "timeIcon", "serviceIcon", "langIcon"]
    var infoViewArray = [InfoView]()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let tempHeight = UIScreen.main.bounds.height * 0.8
    
    var offSet: CGFloat = 0
    var scrollingTimer = Timer()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
        
        self.offSet = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .black
        self.selectionStyle = .none
        
        contentView.addSubview(scrollView)
        
        createScrollViews()
        
        scrollingTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(scrollAutomatically(_:)), userInfo: nil, repeats: true)
    }
    
    private func setAutolayout() {
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: tempHeight).isActive = true
    }

    private func createScrollViews() {
        let frame = UIScreen.main.bounds

        for i in 0..<images.count {
            let tempPoint = CGPoint(x: (frame.width * CGFloat(i)), y: 0)
            let tempSize = CGSize(width: frame.width, height: tempHeight)

            let tempFrame = CGRect(origin: tempPoint, size: tempSize)

            let uiView = TopScrollView(frame: tempFrame)
            uiView.topImageView.image = UIImage(named: images[i])

            if categories[i] != nil {
                uiView.categoryLabel.text = categories[i]
                uiView.titleLabel.text = titles[i]
            } else {
                uiView.titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                uiView.titleLabel.text = titles[i]
            }
            scrollView.addSubview(uiView)
        }
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(images.count), height: tempHeight-5)
    }
    
    
    var flag = false
    
    func setData(tripDetailData: TripDetail) {
        guard flag == false else { return }
        
        flag = true
        
        var provideText = ""
        
        if !tripDetailData.provides.isEmpty {
            for i in 0..<tripDetailData.provides.count {
                provideText += "\(tripDetailData.provides[i]?.provideSet ?? ""), "
            }
            provideText.removeLast()
            provideText.removeLast()
        }
        
        let infoLabelArray: [String] =
            [tripDetailData.state.name, "총 \(tripDetailData.durationTime)시간", (provideText == "") ? nil : provideText, tripDetailData.language].compactMap{ $0 }

        if provideText == "" {
            iconsArray.remove(at: 2)
        }
        
        for i in 0..<infoLabelArray.count {
            let infoView = InfoView()
            infoView.icon.image = UIImage(named: iconsArray[i])
            infoView.label.text = infoLabelArray[i]
            infoViewArray.append(infoView)
        }
        
        for (index, value) in infoViewArray.enumerated() {
            contentView.addSubview(value)
            
            value.translatesAutoresizingMaskIntoConstraints = false
            value.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            value.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
            value.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            switch index {
            case 0:
                value.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5).isActive = true
            case (infoViewArray.count - 1):
                value.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
                fallthrough
            default:
                value.topAnchor.constraint(equalTo: infoViewArray[index - 1].bottomAnchor, constant: 20).isActive = true
            }
        }
    }
    
    @objc private func scrollAutomatically(_ sender: Timer) {
        let totalPossibleOffset = CGFloat(images.count - 1) * UIScreen.main.bounds.size.width
        if offSet == totalPossibleOffset {
            offSet = 0 // come back to the first image after the last image
        } else {
            offSet += UIScreen.main.bounds.size.width
        }
        
        DispatchQueue.main.async() {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIView.AnimationOptions.curveLinear,
                           animations: {
                            self.scrollView.contentOffset.x = CGFloat(self.offSet) },
                           completion: nil)
        }
    }
}
