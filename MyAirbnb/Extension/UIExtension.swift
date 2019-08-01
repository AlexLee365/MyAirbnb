//
//  UIExtension.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 09/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

extension UILabel {
    func configureMainTableViewCellsTitle() {   // MainView의 TableViewCell들의 타이틀 텍스트 설정을 통일시켜주는 메소드
        self.font = .systemFont(ofSize: StandardUIValue.shared.sizeTitleBoldText, weight: .bold)
        self.textAlignment = .left
        self.numberOfLines = 0
        self.textColor = #colorLiteral(red: 0.3221844435, green: 0.3202747703, blue: 0.3236560524, alpha: 1)
    }
    
    func configureMainTableViewCellsTitleDetails() {
        self.font = .systemFont(ofSize: StandardUIValue.shared.sizeSubTitleText, weight: .regular)
        self.textAlignment = .left
        self.numberOfLines = 0
        self.textColor = #colorLiteral(red: 0.3221844435, green: 0.3202747703, blue: 0.3236560524, alpha: 1)
    }
    
    func configureTripDetailTitle() {
        self.font = UIFont(name: "AirbnbCerealApp-Medium", size: 18)
        self.setLineSpacing(lineSpacing: 4)
        self.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        UIFont.systemFont(ofSize: StandardUIValue.shared.sizeTitleBoldText, weight: .semibold)
    }
    
    func configureTripDetailDesc() {
        self.font = UIFont(name: "AirbnbCerealApp-Book", size: 16)
        self.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        self.setLineSpacing(lineSpacing: 4)
        self.numberOfLines = 0
    }
    
    func configureHouseDetailMainText() {
        self.textColor = StandardUIValue.shared.colorRegularText
        self.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    func configureHouseDetailSubText() {
        self.textColor = StandardUIValue.shared.colorRegularText
        self.font = .systemFont(ofSize: 14, weight: .regular)
        self.numberOfLines = 0
    }
    
    // MARK: - For UILabel Line Spacing
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    
    // MARK: - For read more action
    
    //    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
    //        let readMoreText: String = trailingText + moreText
    //
    //        let lengthForVisibleString: Int = self.vissibleTextLength
    //        let mutableString: String = self.text!
    //        let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.text?.count)! - lengthForVisibleString)), with: "")
    //        let readMoreLength: Int = (readMoreText.count)
    //        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: ((trimmedString?.count ?? 0) - readMoreLength), length: readMoreLength), with: "") + trailingText
    //        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font])
    //        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
    //        answerAttributed.append(readMoreAttributed)
    //        self.attributedText = answerAttributed
    //
    //    }
    //
    //    var vissibleTextLength: Int {
    //        let font: UIFont = self.font
    //        let mode: NSLineBreakMode = self.lineBreakMode
    //        let labelWidth: CGFloat = self.frame.size.width
    //        let labelHeight: CGFloat = self.frame.size.height
    //        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
    //
    //        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
    //        let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedString.Key : Any])
    //        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)
    //
    //        if boundingRect.size.height > labelHeight {
    //            var index: Int = 0
    //            var prev: Int = 0
    //            let characterSet = CharacterSet.whitespacesAndNewlines
    //            repeat {
    //                prev = index
    //                if mode == NSLineBreakMode.byCharWrapping {
    //                    index += 1
    //                } else {
    //                    index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
    //                }
    //            } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
    //            return prev
    //        }
    //        return self.text!.count
    //    }
}


extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}

//extension NSMutableAttributedString {
//
//    func setColorForText(textForAttribute: String, withColor color: UIColor) {
//        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
//
//        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
//    }
//}

extension UITableViewCell {
    func hideSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
    }
}


class UIButtonWithHighlightEffect: UIButton {
    open override var isHighlighted: Bool {
        didSet {
            self.layer.backgroundColor = isHighlighted ? #colorLiteral(red: 0.8454582095, green: 0.8404331207, blue: 0.8493215442, alpha: 0.4461151541) : UIColor.clear.cgColor
        }
    }
    
    open override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let previousLocation = touch.previousLocation(in: self)
        let currentLocation = touch.location(in: self)
        
        if previousLocation.y != currentLocation.y {
            isHighlighted = false
            return false
        } else {
            return true
        }
    }
}


extension Date {
    func getDateStringFormatYearMonthDay(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

extension String {
    func limitFractionDigits() -> String {  // 숫자를 세자리 수마다 , 찍어서 반환
        //        guard let number = Double(numString) else { return "0" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let num = formatter.number(from: self) ?? 0
        let result = formatter.string(from: num) ?? ""
        return result
    }
}

extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        self.contentOffset.y = -positiveTopOffset
    }
}

