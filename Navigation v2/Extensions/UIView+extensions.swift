//
//  String+extension.swift
//  Navigation v2
//
//  Created by Alex Alex on 23.03.2022.
//

import UIKit

public extension UIView {
    
    var shadowColor:UIColor? {
        get {
            if let color = self.layer.shadowColor {
                return  UIColor(cgColor: color)
            }
            return .lightGray
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    var borderColor:UIColor? {
        get {
            if let color = self.layer.borderColor {
                return  UIColor(cgColor: color)
            }
            return .lightGray
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    var borderWidth:CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    var shadowOpacity:Float {
        get {
            return  layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    var shadowRadius:CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    var cornerRadius:CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
   
    func shadowOffset(_ subview: UIView, width: CGFloat, height: CGFloat) -> CGSize {
        
        return subview.layer.shadowOffset
    }
   
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func toInteraction() {
        isUserInteractionEnabled = true
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
        
    }
    
    func bringSubviews (_ subviews: UIView...){
        subviews.forEach { bringSubviewToFront($0)}
        
    }
}









