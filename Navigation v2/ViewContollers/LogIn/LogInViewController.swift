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
        imageView.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        return imageView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email "
        textField.borderColor = .lightGray
        textField.borderWidth = 0.5
        textField.tintColor = .tintColor
        textField.autocapitalizationType = .none
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.toAutoLayout()
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderColor = .lightGray
        textField.borderWidth = 0.5
        textField.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
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
        stackView.cornerRadius = 10
        stackView.backgroundColor = .systemGray6
        stackView.borderColor = .lightGray
        stackView.borderWidth = 0.5
        stackView.spacing = 0
        stackView.toAutoLayout()
        return stackView
    }()
    
    private lazy var logoInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "blue_pixel")
        button.cornerRadius = 10
        button.titleLabel?.textColor = .white
        button.setTitle("Log In", for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.didTransitionButton), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.cornerRadius = 10
        label.toAutoLayout()
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "!"
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let minLength = 6
    private let maxLength = 64
    
    private func drawSelf() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubviews(logoImageView, stackLabelView, logoInButton, alertLabel)
        self.stackLabelView.addArrangedSubview(self.emailTextField)
        self.stackLabelView.addArrangedSubview(self.passwordTextField)
        
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor ),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.heightAnchor.constraint(equalToConstant: 456),
            
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
            
            self.alertLabel.topAnchor.constraint(equalTo: self.logoInButton.bottomAnchor, constant: 0),
            self.alertLabel.leadingAnchor.constraint(equalTo: self.stackLabelView.leadingAnchor),
            self.alertLabel.trailingAnchor.constraint(equalTo: self.stackLabelView.trailingAnchor),
            self.alertLabel.heightAnchor.constraint(equalToConstant: 70)
            
        ])
    }
    
    let emailValidType: String.ValidTypes = .email
    let passwordValidType: String.ValidTypes = .password
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        passwordTextField.delegate = self
        emailTextField.delegate = self
        drawSelf()
        setupTapGesture()
        registerKeyboardNotification()
    }
    deinit {
        removeKeyboardNotification()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc private func didTransitionButton() {
//        pushViewController(ProfileViewController(), "назад")
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        
        if emailText.isEmpty && passwordText.isEmpty {
            emailTextField.borderColor = .red
            emailTextField.borderWidth = 2
            
            passwordTextField.borderColor = .red
            passwordTextField.borderWidth = 2
            
            alertLabel.isHidden = false
            
            alertLabel.text = "Заполните поля email и password"
            
        } else {
            
            emailTextField.borderColor = .lightGray
            emailTextField.borderWidth = 0.5
            passwordTextField.borderColor = .lightGray
            passwordTextField.borderWidth = 0.5
//            let emailStandard = "test_2022@test.com"
//            let passwordStandart = "Test_2022"
            if emailText.isValid(validType: emailValidType) && passwordText.isValid(validType: passwordValidType) && emailText == emailStandard && passwordText == passwordStandart {
                
                pushViewController(ProfileViewController(), "назад")
                
            }  else {
                
                alertTap(title: "Неверный логин или пароль", message: "Исправить?", titleAgreeAction: "Да", styleAgreeAction: .default, titleDisagreeAction: "", styleDisagreeAction: .default)
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showTabBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    private func setupTapGesture() {
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        
    }
    @objc private func handleTapDismiss(){
        contentView.endEditing(true)
    }
    private func setTextField(textField: UITextField, label: UILabel, validType: String.ValidTypes, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }

        textField.text = result
        
        if result.isValid(validType: validType) {
            alertLabel.isHidden = false
            alertLabel.textColor = .systemGreen
            alertLabel.text = validMessage
        } else {
            alertLabel.isHidden = false
            alertLabel.textColor = .systemRed
            alertLabel.text = wrongMessage
        }
        
    }
    
}


extension LogInViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case emailTextField: setTextField(textField: emailTextField,
                                          label: alertLabel,
                                          validType: emailValidType,
                                          validMessage: "Email is valid",
                                          wrongMessage: "Email is not correct name@domen.com",
                                          string: string,
                                          range: range)
        case passwordTextField: setTextField(textField: passwordTextField,
                                             label: alertLabel,
                                             validType: passwordValidType,
                                             validMessage: "Password is valid",
                                             wrongMessage: "Введите не менее 6 символов \nбуквы из верхнего и нижнего регистра, цифры и символы \n!@#$%^&*_?",
                                             string: string,
                                             range: range)
            
        default:
            break
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
}

extension LogInViewController {
    
    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbdShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbdHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeKeyboardNotification() {
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height + 50
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0,
                                                                    left: 0, bottom: kbdSize.height / 2, right: 0)
        }
        
    }
    @objc private func kbdHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    
}

