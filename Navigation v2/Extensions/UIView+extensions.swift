//
//  String+extension.swift
//  Navigation v2
//
//  Created by Alex Alex on 23.03.2022.
//

import UIKit

public extension UIView {
    
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
    
      var cornerRadius:CGFloat {
           get {
               return layer.cornerRadius
           }
           set {
               layer.cornerRadius = newValue
               layer.masksToBounds = newValue > 0
           }
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



      
      
  



