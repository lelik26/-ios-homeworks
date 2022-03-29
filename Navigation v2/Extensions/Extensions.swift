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


//Добавляем расширение для UIViewController:

  public extension UIViewController {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
      func showTabBar(){
          self.tabBarController?.tabBar.isHidden = false
      }
      func hideTabBar(){
          self.tabBarController?.tabBar.isHidden = true
          
      }
      
      func pushViewController(_ vc: UIViewController,_ backTitle: String){
          self.navigationController?.pushViewController(vc, animated: true)
          self.navigationItem.backButtonTitle = backTitle
         
      }
      func setupNavigationBar(_ title: String) {
          self.navigationController?.navigationBar.prefersLargeTitles = true
          self.navigationItem.title = title
      
  }
      
      
      
  }


