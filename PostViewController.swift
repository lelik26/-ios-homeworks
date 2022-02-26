//
//  PostViewController.swift
//  Navigation
//
//  Created by Alex Alex on 23.02.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lazy var myPost = Post(title: "Мой Пост")
        title = myPost.title
        
        let infoButton = UIBarButtonItem(title: "info" , style: .plain, target: self, action: #selector(didTapTransitionInfoButton))
        self.navigationItem.setRightBarButton(infoButton, animated: true)
        self.view.backgroundColor = .yellow
    }
    
    
    @objc func didTapTransitionInfoButton() {
        let infoVC = InfoViewController()
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
}
