//
//  LogInViewController.swift
//  Navigation v2
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

class LogInViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
       contentView.toAutoLayout()
        return contentView
    }()
    
    private lazy var logoImageView: UIImageView = {    
        let imageView = UIImageView(image: UIImage(named: "logoVK.jpg"))
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        return imageView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        textField.tintColor = .tintColor
        textField.autocapitalizationType = .none
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.toAutoLayout()
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
        textField.toAutoLayout()
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
        stackView.spacing = 0
        stackView.toAutoLayout()
        return stackView
    }()
    
    private lazy var logoInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "blue_pixel")
        button.layer.cornerRadius = 10
        button.titleLabel?.textColor = .white
        button.setTitle("Log In", for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.didTransitionButton), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private func drawSelf() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubviews(logoImageView, stackLabelView, logoInButton)
    
//        self.contentView.addSubview(self.logoImageView)
//        self.contentView.addSubview(self.stackLabelView)
//        self.contentView.addSubview(self.logoInButton)
        
        self.stackLabelView.addArrangedSubview(self.emailTextField)
        self.stackLabelView.addArrangedSubview(self.passwordTextField)
       
                //Constraint activate
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.heightAnchor.constraint(equalToConstant: 386),//386
            
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor ),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.heightAnchor.constraint(equalToConstant: 386),
            
            self.logoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 100),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            self.stackLabelView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 120),

            self.stackLabelView.heightAnchor.constraint(equalToConstant: 100),
            self.stackLabelView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
     
            self.logoInButton.topAnchor.constraint(equalTo: self.stackLabelView.bottomAnchor, constant: 16),
            self.logoInButton.leadingAnchor.constraint(equalTo: self.stackLabelView.leadingAnchor),
            self.logoInButton.trailingAnchor.constraint(equalTo: self.stackLabelView.trailingAnchor),
            self.logoInButton.heightAnchor.constraint(equalToConstant: 50),
          

        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawSelf()
        self.view.backgroundColor = .white
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }


    @objc private func didTransitionButton() {
        pushViewController(ProfileViewController(), "назад")
    }
    
//   Mark: - Keyboard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showTabBar()
    
    // подписаться на уведомления
    let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    // отписаться от уведомлений
    let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    
    }
    
    // Изменение отступов при появлении клавиатуры
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height + 50
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0,
    left: 0, bottom: kbdSize.height, right: 0)
    }
        
    }
    @objc private func kbdHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
   
       private func setupTapGesture() {
           contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))

        }
        @objc private func handleTapDismiss(){
            contentView.endEditing(true)
        }

}
