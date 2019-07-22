//
//  KeyboardNotiCenter.swift
//  MyAirbnb
//
//  Created by 김광준 on 22/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation
import UIKit

class KeyboardNotiCenter: NotificationCenter {
    
    var bottomLayout: NSLayoutConstraint!
    var keyboardHeight: CGFloat = 0
    var bottomInsets: CGFloat = 0
    
    // 가려지는 nextBtn을 키보드 위에 붙이기 위해 사용한 노티센터
    func registForKeyboardNotification(_ vc: UIViewController) {
        NotificationCenter.default.addObserver(vc, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(vc, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 노티센터 옵저버 해제
    func unregistForKeyboardNotification(_ vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(vc, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // 키보드에 의해 가려지는 nextBtn 과 nextBtnBackground 키보드와 함께 올리기
    @objc func keyboardWillShow(_ sender: Notification) {
        let userInfo: NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRect = keyboardFrame.cgRectValue
        
        print("키보드 높이 : \(keyboardRect.height)")
        keyboardHeight = keyboardRect.height - bottomInsets
        print("safeAreaInsets을 뺀 키보드 높이 : \(keyboardHeight)")
        bottomLayout.constant = -keyboardHeight
    }
    
    // 키보드에 의해 가려지는 nextBtn 과 nextBtnBackground 키보드와 내리기
    @objc func keyboardWillHide(_ sender: Notification) {
        
        let userInfo: NSDictionary = sender.userInfo! as NSDictionary
        let hideKeyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameBeginUserInfoKey) as! NSValue
        let hideKeyboardRect = hideKeyboardFrame.cgRectValue
        let hideKeyboardHeight = hideKeyboardRect.height
        print("내려간 키보드 높이 : \(hideKeyboardHeight)")
        bottomLayout.constant = 0
    }
}
