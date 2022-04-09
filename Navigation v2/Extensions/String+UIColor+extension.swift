//
//  UIColor+extension.swift
//  Navigation v2
//
//  Created by Alex Alex on 23.03.2022.
//

import UIKit

extension String {
    
    enum  ValidTypes {
        
        case email
        case password
    }
    
    enum Regex: String {
        case email = "[A-Z0-9a-z._%+-]+@[a-zA-Z]+\\.[a-zA-Z]{2,100}"// Буквы из нижнего и верхнего регистра
        
        case password = "(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*_?|±])[a-zA-Z0\\d!@#$%^&*_?|±].{6,100}"
    }
    
    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"  // вводим формат для сравнения c соотвествующего регулярного выражения для Predicate
        var regex = ""
        switch validType {
            
        case .email: regex = Regex.email.rawValue
        case .password: regex = Regex.password.rawValue
            
            
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
        
    }
}


extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.currentIndex = scanner.string.startIndex
        }
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}
