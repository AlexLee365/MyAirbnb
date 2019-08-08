//
//  EmailValidation.swift
//  MyAirbnb
//
//  Created by 김광준 on 08/08/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class Vaildation {
    func isValidEmail(emailStr: String) -> Bool {
        let emailExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPredict = NSPredicate(format: "SELF MATCHES %@", emailExpression)
        return emailPredict.evaluate(with: emailStr)
    }
    
}
