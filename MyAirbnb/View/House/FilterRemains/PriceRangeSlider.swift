//
//  PriceRangeSlider.swift
//  MyAirbnb
//
//  Created by Solji Kim on 18/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class PriceRangeSlider: UIControl {
    var minimumValue: CGFloat = 0
    var maximumValue: CGFloat = 1
    var lowerValue: CGFloat = 0.0
    var upperValue: CGFloat = 1.0
    
    var pointGapWhenTwoBtnsMeet: CGFloat = .zero
    
    var trackTintColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    var trackHighlightTintColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
    
    var thumbImage = UIImage(named: "sliderIcon")
    
//    private let trackLayer = CALayer()
    private let trackLayer = RangeSliderTrackLayer()
    private let lowerThumbImageView = UIImageView()
    private let upperThumbImageView = UIImageView()
    
    private var previousLocation = CGPoint()
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        updateLayerFrames()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        lowerThumbImageView.image = thumbImage
        lowerThumbImageView.contentMode = .scaleAspectFit
        addSubview(lowerThumbImageView)
        
        upperThumbImageView.image = thumbImage
        upperThumbImageView.contentMode = .scaleAspectFit
        addSubview(upperThumbImageView)
    }
    
    let buttonSize = CGSize(width: 35, height: 35)
    
    private func updateLayerFrames() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 2.7)
        trackLayer.setNeedsDisplay()
        lowerThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowerValue), size: buttonSize)
        upperThumbImageView.frame = CGRect(origin: thumbOriginForValue(upperValue) , size: buttonSize)
        
//        lowerThumbImageView.backgroundColor = .yellow
//        upperThumbImageView.backgroundColor = .yellow
    }
    
    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * value
    }
    
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
//  기존
//        let x = positionForValue(value) - thumbImage.size.width / 2.0
//        return CGPoint(x: x, y: (bounds.height - thumbImage.size.height) / 2.0)
        
        let x = positionForValue(value) - 1.5
            - buttonSize.width / 2.0
        return CGPoint(x: x, y: (bounds.height - buttonSize.height) / 2.0)
    }
    
    
}


extension PriceRangeSlider {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        print("beginTracking")
        
        pointGapWhenTwoBtnsMeet = ( self.frame.width / 100000 * 37.5 )
        let values = "(\(self.lowerValue) \(self.upperValue))"
        let pointGap = self.upperValue - self.lowerValue
        print("poinrtGap: \(pointGap)  /  slider value: \(values)")
        
        
        print("pointGapWhenTwoBtnsMeet: \(pointGapWhenTwoBtnsMeet)")
//        guard pointGap > pointGapWhenTwoBtnsMeet else { return false }
        
        
        previousLocation = touch.location(in: self)
        let lowerBtnFrame = lowerThumbImageView.frame
        let upperBtnFrame = upperThumbImageView.frame
        let expandPoint: CGFloat = 30
        
        let lowerBtnExpandFrame = CGRect(x: lowerBtnFrame.origin.x - expandPoint,
                                         y: lowerBtnFrame.origin.y - expandPoint,
                                         width: lowerBtnFrame.width + expandPoint * 2,
                                         height: lowerBtnFrame.height + expandPoint * 2)
        
        let upperBtnExpandFrame = CGRect(x: upperBtnFrame.origin.x - expandPoint,
                                         y: upperBtnFrame.origin.y - expandPoint,
                                         width: upperBtnFrame.width + expandPoint * 2,
                                         height: upperBtnFrame.height + expandPoint * 2)
        
        if lowerBtnExpandFrame.contains(previousLocation) {
            lowerThumbImageView.isHighlighted = true
        } else if upperBtnExpandFrame.contains(previousLocation) {
            upperThumbImageView.isHighlighted = true
        }
        return lowerThumbImageView.isHighlighted || upperThumbImageView.isHighlighted
    }
    
    // slider values are updated inside this function.
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        print("continue Tracking")
        let values = "(\(self.lowerValue) \(self.upperValue))"
        let pointGap = self.upperValue - self.lowerValue
        print("poinrtGap: \(pointGap)  /  slider value: \(values)")
        
//        guard pointGap > pointGapWhenTwoBtnsMeet
        if pointGap > pointGapWhenTwoBtnsMeet {
            
        } else {
            upperValue = max(upperValue, lowerValue + pointGapWhenTwoBtnsMeet)
        }
        
//            else { return false }
        
        
        
        
        let location = touch.location(in: self)
        
        let deltaLocation = location.x - previousLocation.x
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
        
        previousLocation = location
        
        if lowerThumbImageView.isHighlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue,
                                    upperValue: upperValue)
        } else if upperThumbImageView.isHighlighted {
            upperValue += deltaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue,
                                    upperValue: maximumValue)
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        updateLayerFrames()
        
        CATransaction.commit()
        
        sendActions(for: .valueChanged)
        
        return true
    }
    
    private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat, upperValue: CGFloat) -> CGFloat {
        return min(max(value, lowerValue), upperValue)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        print("endTracking")
        lowerThumbImageView.isHighlighted = false
        upperThumbImageView.isHighlighted = false
    }
}
