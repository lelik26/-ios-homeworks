//
//  PostViewController.swift
//  Navigation
//
<<<<<<< HEAD
//  Created by Alex Alex on 23.02.2022.
=======
//  Created by Alex Alex on 13.03.2022.
>>>>>>> 0fb6cca20e1d02103dbc4db38c60ff3afe854a4b
//

import UIKit

class PostViewController: UIViewController {
<<<<<<< HEAD
=======

>>>>>>> 0fb6cca20e1d02103dbc4db38c60ff3afe854a4b
    var post: Post?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.title
        let infoButton = UIBarButtonItem(title: "info" , style: .plain, target: self, action: #selector(didTapTransitionInfoButton))
        self.navigationItem.setRightBarButton(infoButton, animated: true)
        self.view.backgroundColor = .yellow
    }
    
    
    @objc func didTapTransitionInfoButton() {
        let infoVC = InfoViewController()
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
}
