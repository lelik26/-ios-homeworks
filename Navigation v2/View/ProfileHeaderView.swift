//
//  ProfileHeaderView.swift
//  Navigation v2
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

//protocol ProfileHeaderViewProtocol: AnyObject {
//    func buttonPressed(textFieldIsVisible: Bool, completion: @escaping () -> Void)
//}
//
//class ProfileHeaderView: UIView {
//
//    private lazy var avatarImageView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "smurf.jpg"))
//        imageView.backgroundColor = .clear
//        imageView.layer.borderWidth = 3.0
//        imageView.layer.borderColor = UIColor.white.cgColor
//        imageView.layer.cornerRadius = 45
//        imageView.clipsToBounds = true
//        imageView.toAutoLayout()
//        //translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    private lazy var fullNameLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .lightGray
//        label.text = "Смурф"
//        label.font = .systemFont(ofSize: 18, weight: .bold)
//        label.textColor = .black
//        label.toAutoLayout()
//        return label
//    }()
//    private lazy var statusLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .lightGray
//        label.text = "Waiting for something"
//        label.font = .systemFont(ofSize: 14, weight: .regular)
//        label.textColor = .gray
//        label.toAutoLayout()
//        return label
//    }()
//    private lazy var stackLabelView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//        stackView.spacing = 10
//        stackView.toAutoLayout()
//        return stackView
//    }()
//
//    private lazy var setStatusButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .systemBlue
//        button.layer.cornerRadius = 4
//        button.titleLabel?.textColor = .white
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOpacity = 0.7
//        button.layer.shadowRadius = 4
//        button.layer.shadowOffset = .init(width: 4, height: 4)
//        button.setTitle("Show Status", for: .normal)
//        button.clipsToBounds = true
//        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
//        button.setTitle("Set Status", for: .selected)
//
//        button.toAutoLayout()
//        return button
//    }()
//
//    private var buttonTopConstraint: NSLayoutConstraint?
//    private var buttonPressTopConstraint: NSLayoutConstraint?
//    weak var delegate: ProfileHeaderViewProtocol?
//
//    private lazy var textField: UITextField = {
//        let textField = UITextField()
//        textField.isHidden = true
//        textField.placeholder = statusLabel.text   //"Enter some status here"
//        textField.textColor = .black
//        textField.font = .systemFont(ofSize: 15, weight: .regular)
//        textField.layer.cornerRadius = 12
//        textField.layer.borderWidth = 1.0
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.clipsToBounds = true
//        textField.backgroundColor = .white
//        textField.addTarget(self, action: #selector(statusTextChanged(_:) ), for: .editingChanged)
//        textField.toAutoLayout()
//        return textField
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.drawSelf()
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented") // нет установки XIB
//
//    }
//
//    private func drawSelf() {
//        self.backgroundColor = .lightGray
//        self.addSubview(self.setStatusButton)
//        self.addSubview(self.textField)
//        self.addSubview(self.avatarImageView)
//        self.addSubview(self.stackLabelView)
//
//        self.stackLabelView.addArrangedSubview(self.fullNameLabel)
//        self.stackLabelView.addArrangedSubview(self.statusLabel)
//
//        self.buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.stackLabelView.bottomAnchor, constant: 34)
//        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
//
//
//
//        NSLayoutConstraint.activate([
////            self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
//            self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            self.avatarImageView.heightAnchor.constraint(equalToConstant: 90),
//            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0),
//            self.stackLabelView.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
//            self.stackLabelView.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 10),
//            self.stackLabelView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            self.stackLabelView.heightAnchor.constraint(equalToConstant: 61),
//            self.setStatusButton.leadingAnchor.constraint(equalTo: self.avatarImageView.leadingAnchor),
//            self.setStatusButton.trailingAnchor.constraint(equalTo: self.stackLabelView.trailingAnchor),
//            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50),
//            self.buttonTopConstraint
//
//        ].compactMap({ $0 })) // объявление всех constrait и активирует расчет
//    }
//    @objc private func buttonPressed(_ button: UIButton) {
//        button.isSelected = !button.isSelected
//
//        if self.textField.isHidden {
//            self.addSubview(self.textField)
//
//            self.buttonTopConstraint?.isActive = false
//            self.buttonPressTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.stackLabelView.bottomAnchor, constant: 84)
//            self.buttonPressTopConstraint?.priority = UILayoutPriority(rawValue: 999)
//
//
//            NSLayoutConstraint.activate([
//
//                self.textField.topAnchor.constraint(equalTo: self.stackLabelView.bottomAnchor, constant: 34),
//                self.textField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor),
//                self.textField.trailingAnchor.constraint(equalTo: self.statusLabel.trailingAnchor),
//                self.textField.heightAnchor.constraint(equalToConstant: 40),
//                self.buttonPressTopConstraint
//            ].compactMap({ $0 }))
//        }
//               else {
//                   self.buttonPressTopConstraint?.isActive = false
//                   self.buttonTopConstraint?.isActive = true
//                   textField.removeFromSuperview()
//              }
//
//        self.delegate?.buttonPressed(textFieldIsVisible: self.textField.isHidden) { [weak self] in
//        self?.textField.isHidden.toggle()
//        }
//    }
//
//    private var statusText: String?
//    @objc private func statusTextChanged (_ textField: UITextField) {
//
//        statusText = textField.text!
//        statusLabel.text = statusText
//    }
//
//}
//
//

protocol ProfileHeaderViewProtocol: AnyObject { // добавляем протокол с функцией didTapStatusButton с активным текстовым полем
    func buttonPressed(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

class ProfileHeaderView: UIView {
    
    //private lazy
    var avatarImageView: UIImageView = {    // установка изображения
        let imageView = UIImageView(image: UIImage(named: "smurf.jpg"))
        imageView.backgroundColor = .clear
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        return imageView
    }()
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.text = "Смурф"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.text = "Waiting for something"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.toAutoLayout()
        return label
    }()
    private lazy var stackLabelView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10 //зазор между лабел
        stackView.toAutoLayout()
        return stackView
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.titleLabel?.textColor = .white
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = .init(width: 4, height: 4)
        button.setTitle("Show Status", for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.setTitle("Set Status", for: .selected)
        
        button.toAutoLayout()
        return button
    }()
    
    private var buttonTopConstraint: NSLayoutConstraint?
    private var buttonPressTopConstraint: NSLayoutConstraint?// выносим констрейт в свойство и делаем опционально
    weak var delegate: ProfileHeaderViewProtocol?  // добавляем делегат
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        textField.placeholder = statusLabel.text   //"Enter some status here"
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.clipsToBounds = true
        textField.backgroundColor = .white
        textField.addTarget(self, action: #selector(statusTextChanged(_:) ), for: .editingChanged)
        textField.toAutoLayout()
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // нет установки XIB
        
    }
    
    private func drawSelf() {
        self.backgroundColor = .lightGray
//        self.addSubview(self.setStatusButton)
//        self.addSubview(self.avatarImageView)
//        self.addSubview(self.stackLabelView)
//        self.addSubview(self.textField)
        addSubviews(setStatusButton, avatarImageView, stackLabelView, textField)
        
        self.stackLabelView.addArrangedSubview(self.fullNameLabel)
        self.stackLabelView.addArrangedSubview(self.statusLabel)
        
        self.buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.stackLabelView.bottomAnchor, constant: 34)
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
        
        NSLayoutConstraint.activate([
            self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0),
            self.stackLabelView.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            self.stackLabelView.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 10),
            self.stackLabelView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.stackLabelView.heightAnchor.constraint(equalToConstant: 61),
            self.setStatusButton.leadingAnchor.constraint(equalTo: self.avatarImageView.leadingAnchor),
            self.setStatusButton.trailingAnchor.constraint(equalTo: self.stackLabelView.trailingAnchor),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            self.buttonTopConstraint
            
        ].compactMap({ $0 })) // объявление всех constrait и активирует расчет
    }
    @objc private func buttonPressed(_ button: UIButton) {
        button.isSelected = !button.isSelected
        
        if self.textField.isHidden {
            self.addSubview(self.textField)
           
            self.buttonTopConstraint?.isActive = false
            self.buttonPressTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.stackLabelView.bottomAnchor, constant: 84)
            self.buttonPressTopConstraint?.priority = UILayoutPriority(rawValue: 999)

            NSLayoutConstraint.activate([
                
                self.textField.topAnchor.constraint(equalTo: self.stackLabelView.bottomAnchor, constant: 34),
                self.textField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor),
                self.textField.trailingAnchor.constraint(equalTo: self.statusLabel.trailingAnchor),
                self.textField.heightAnchor.constraint(equalToConstant: 40),
                self.buttonPressTopConstraint
            ].compactMap({ $0 }))
        }
               else {
                   self.buttonPressTopConstraint?.isActive = false
                   self.buttonTopConstraint?.isActive = true
                   textField.removeFromSuperview()
              }
        
        self.delegate?.buttonPressed(textFieldIsVisible: self.textField.isHidden) { [weak self] in
        self?.textField.isHidden.toggle()
        }
    }
    
    private var statusText: String?
    @objc private func statusTextChanged (_ textField: UITextField) {
      
        statusText = textField.text!
        statusLabel.text = statusText
    }
    
}




 

    

