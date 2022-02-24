//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Alex Alex on 23.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var avatar: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Smurf.jpg"))
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 64.0
        imageView.clipsToBounds = true
        return imageView
    }() //autoSetDimensions(to: CGSize(width: 128.0, height: 128.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        setupImage()
        setupTitle()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        activateViewConstraints()
        
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Смурф"
    }
    
    private func setupImage() {
        
    }
    private func setupTitle() {
        
    }
    private func activateViewConstraints() {
        let constrains = [
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constrains)
        //        self.setupImage.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        //        self.setupImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        //        self.setupImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        //        self.setupImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
}

    
   


