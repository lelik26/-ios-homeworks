//
//  UIViewController+extensions.swift
//  Navigation v2
//
//  Created by Alex Alex on 09.04.2022.
//

import UIKit

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
      
    
    func alertTap(title: String, message: String , titleAgreeAction: String, styleAgreeAction: UIAlertAction.Style, titleDisagreeAction: String, styleDisagreeAction: UIAlertAction.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let agreeButton = UIAlertAction(title: titleAgreeAction, style: styleAgreeAction, handler: nil)
        let disagreeButton = UIAlertAction(title: titleDisagreeAction, style: styleDisagreeAction, handler: nil)
        alert.addAction(agreeButton)
        alert.addAction(disagreeButton)
        present(alert, animated: true, completion: nil)
       // print("alert work")
    }
    
   

}

