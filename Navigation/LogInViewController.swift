//
//  LogInViewController.swift
//  Navigation
//
//  Created by Alex Alex on 08.03.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var logoImageView: UIImageView = {    // установка изображения
        let imageView = UIImageView(image: UIImage(named: "logoVK.jpg"))
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email of phone"
        textField.tintColor = .tintColor
        textField.autocapitalizationType = .none
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
      
        //        label.tintColor = .accentColor
        //        label.autocapitalizationType = .none
        //       label.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.layer.borderWidth = 0.5
        textField.placeholder = "Password"
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.tintColor = .tintColor
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
     
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var stackLabelView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .systemGray6
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.spacing = 0 //зазор между лабел
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var logoInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.textColor = .white
        button.setTitle("Log In", for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.didTransitionButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    
    private func drawSelf() {
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.logoInButton)
        
        self.scrollView.addSubview(self.logoImageView)
        self.scrollView.addSubview(self.stackLabelView)
        
        self.stackLabelView.addArrangedSubview(self.emailTextField)
        self.stackLabelView.addArrangedSubview(self.passwordTextField)
       
                //Constrain scroll view
        let scrollViewLeftConstraint =  self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let scrollViewRightConstraint = self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.logoInButton.topAnchor, constant: 16)
        
        let logoImageTopConstraint = self.logoImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 120)
        let positionXLogoImage = self.logoImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let heightLogoImage = self.logoImageView.heightAnchor.constraint(equalToConstant: 100)
        let widthLogoImage = self.logoImageView.widthAnchor.constraint(equalToConstant: 100)
        
        
        let topStackLabelConstraint = self.stackLabelView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 120)
        let leadingStackLabelConstraint = self.stackLabelView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let trailingStackLabelConstraint = self.stackLabelView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        let heightStackLabelConstraint = self.stackLabelView.heightAnchor.constraint(equalToConstant: 100)
        
        
        let topButtonConstraint = self.logoInButton.topAnchor.constraint(equalTo: self.stackLabelView.bottomAnchor, constant: 16)
        let leadingButtonConstraint = self.logoInButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let trailingButtonConstraint = self.logoInButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        let heightButtonConstraint = self.logoInButton.heightAnchor.constraint(equalToConstant: 50)
        
        
        
        NSLayoutConstraint.activate([logoImageTopConstraint, positionXLogoImage, heightLogoImage, widthLogoImage, topStackLabelConstraint, leadingStackLabelConstraint, trailingStackLabelConstraint, heightStackLabelConstraint, leadingButtonConstraint, trailingButtonConstraint, heightButtonConstraint, topButtonConstraint, scrollViewTopConstraint, scrollViewLeftConstraint, scrollViewRightConstraint, scrollViewBottomConstraint].compactMap({ $0 }))
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.drawSelf()
        self.view.backgroundColor = .white
    }
    
    
    private func setupNavigationBar() {   // установка Navigation controller
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func didTransitionButton() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
    // подписаться на уведомления
    let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name:
    UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name:
    UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    // отписаться от уведомлений
    let nc = NotificationCenter.default
        nc.removeObserver(self, name:
    UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name:
    UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // Изменение отступов при появлении клавиатуры
    @objc private func kbdShow(notification: NSNotification) { if let kbdSize =
    (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0,
    left: 0, bottom: kbdSize.height, right: 0)
    }
        
    }
    @objc private func kbdHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
   
                                                 
  
     
}



