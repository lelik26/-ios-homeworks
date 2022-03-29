//
//  String+extension.swift
//  Navigation v2
//
//  Created by Alex Alex on 23.03.2022.
//

import UIKit

public extension UIView {

func toAutoLayout() {
    translatesAutoresizingMaskIntoConstraints = false
}

func addSubviews(_ subviews: UIView...) {
    subviews.forEach { addSubview($0) }
    
}
    
    func bringSubviews (_ subviews: UIView...){
        subviews.forEach { bringSubviewToFront($0)}
        
    }
}




