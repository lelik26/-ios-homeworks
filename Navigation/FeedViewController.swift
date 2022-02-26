//
//  FeedViewController.swift
//  Navigation
//
//  Created by Alex Alex on 23.02.2022.
//

import UIKit

class FeedViewController: UIViewController {


    private lazy var transitionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = .systemGreen
        button.setTitle("Перейти на экран Поста", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapTransitionButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
        self.view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
    }
    private func setupView() {
        self.view.addSubview(self.transitionButton)
        self.activateConstraints()
    }
    
    private func activateConstraints() {
      
        self.transitionButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.transitionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        self.transitionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        self.transitionButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc private func didTapTransitionButton() {
        let postVC = PostViewController()
    
        navigationController?.pushViewController(postVC, animated: true)
    }
}

struct Post {
    let title: String
    //let title: String = "Мой Пост"
}
//let myPost = Post()

