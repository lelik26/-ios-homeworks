//
//  ProfileHeaderView.swift
//  Navigation v2
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject { // добавляем протокол с функцией didTapStatusButton с активным текстовым полем
    func buttonPressed(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

class ProfileHeaderView: UIView {
    
    //private lazy
    var avatarImageView: UIImageView = {    // установка изображения
        let imageView = UIImageView(image: UIImage(named: "smurf.jpg"))
        imageView.backgroundColor = .clear
        imageView.borderWidth = 3.0
        imageView.borderColor = .white
        imageView.cornerRadius = 45
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
        button.cornerRadius = 4
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
    
    weak var delegate: ProfileHeaderViewProtocol?  // добавляем делегат
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        textField.placeholder = statusLabel.text   //"Enter some status here"
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.cornerRadius = 12
        textField.borderWidth = 1.0
        textField.borderColor = .black
        textField.clipsToBounds = true
        textField.backgroundColor = .white
        textField.addTarget(self, action: #selector(statusTextChanged(_:) ), for: .editingChanged)
        textField.toAutoLayout()
        return textField
    }()
    
    private var statusText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // нет установки XIB
        
    }
    
    private func drawSelf() {
        self.backgroundColor = .lightGray
        addSubviews(setStatusButton, avatarImageView, stackLabelView, textField)
        
        self.stackLabelView.addArrangedSubview(self.fullNameLabel)
        self.stackLabelView.addArrangedSubview(self.statusLabel)
        
        
        NSLayoutConstraint.activate([
            self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0),
            
            self.stackLabelView.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            self.stackLabelView.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 10),
            self.stackLabelView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.stackLabelView.heightAnchor.constraint(equalToConstant: 61),
            
            self.textField.topAnchor.constraint(equalTo: self.stackLabelView.bottomAnchor, constant: 34),
            self.textField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor),
            self.textField.trailingAnchor.constraint(equalTo: self.statusLabel.trailingAnchor),
            self.textField.heightAnchor.constraint(equalToConstant: 40),
            
            self.setStatusButton.leadingAnchor.constraint(equalTo: self.avatarImageView.leadingAnchor),
            
            self.setStatusButton.trailingAnchor.constraint(equalTo: self.stackLabelView.trailingAnchor),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.setStatusButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 10),
            
        ])
    }
    @objc private func handleTapDismiss(){
        textField.resignFirstResponder()
        
    }
    
    @objc private func buttonPressed(_ button: UIButton) {
        
        button.isSelected = !button.isSelected
    textField.isHidden = false
        guard let status = textField.text else {return}
        
        if !status.isEmpty {
            UIView.animate(withDuration: 0.5) {
                self.textField.text = self.statusLabel.text
                self.textField.text = .none
                button.isSelected = true
                
            } completion: { _ in
            }
        }
        if status.isEmpty {
            UIView.animate(withDuration: 0.5) { [self] in
                self.textField.isHidden = false
                self.textField.borderColor = .red
                self.textField.borderWidth = 2
                button.isSelected = false
                
            } completion: { _ in
            }
           
            
        } else {
            textField.borderColor = .black
            textField.borderWidth = 0.5
            endEditing(true)
            
        }

    }
    
    @objc private func statusTextChanged (_ textField: UITextField) {
        
        statusText = textField.text!
        statusLabel.text = statusText
    }
    
}




 

    

