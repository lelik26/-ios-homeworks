//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Alex Alex on 23.02.2022.
//

import UIKit




protocol ProfileHeaderViewProtocol: AnyObject { // добавляем протокол с функцией didTapStatusButton с активным текстовым полем
    func buttonPressed(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

class ProfileHeaderView: UIView {
    
    private lazy var avatar: UIImageView = {    // установка изображения
        let imageView = UIImageView(image: UIImage(named: "Smurf.jpg"))
        imageView.backgroundColor = .clear
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.text = "Смурф"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.text = "Waiting for something"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var stackLabelView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10 //зазор между лабел
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var infoStackView: UIStackView = { // стэк горизонтальный
        let stackView = UIStackView()
        // stackView.backgroundColor = .systemPink
        stackView.axis = .horizontal
        stackView.spacing = 20 // между лабел и картинкой
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.titleLabel?.textColor = .white
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = .init(width: 4, height: 4)
        button.setTitle("Set Status!", for: .normal)
        button.setTitle("Selected Status", for: .selected)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)// добавляем активную кнопку
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var buttonTopConstraint: NSLayoutConstraint? // выносим констрейт в свойство и делаем опционально
    weak var delegate: ProfileHeaderViewProtocol?  // добавляем делегат
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        
        textField.isHidden = true
        textField.placeholder = "Enter some status here"
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.clipsToBounds = true
        textField.backgroundColor = .white
        
        textField.addTarget(self, action: #selector(statusTextChanged(_:) ), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.addSubview(self.statusButton)
        self.addSubview(self.textField)
        self.addSubview(self.infoStackView)   // в view добавляем горизонтальный стэк
        
        
        self.infoStackView.addArrangedSubview(self.avatar) //  добавляем аватар
        self.infoStackView.addArrangedSubview(self.stackLabelView) // добавляем вертикальный стэк
        self.stackLabelView.addArrangedSubview(self.nameLabel) // в вертикальный стэк добавляем label
        self.stackLabelView.addArrangedSubview(self.statusLabel) //
        
        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        
        //       let heightConstraint = self.infoStackView.heightAnchor.constraint(equalToConstant: 100) // высота ? надо определить точнее
        //        let topStackLabelConstraint = self.stackLabelView.topAnchor.constraint(equalTo: self.infoStackView.topAnchor, constant: 11 )
        //        let bottonStackLabelConstraint = self.stackLabelView.bottomAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: -18 )
        //
        let imageViewAspectRatio = self.avatar.heightAnchor.constraint(equalTo: self.avatar.widthAnchor, multiplier: 1.0) // задаем размер картинки и соотношение  сторон 1:1
        
        self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 16)// чтобы кнопка имела динамический констрейт задаем опционал
        
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999) // и приоритет
        
        let leadingButtonConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
        let trailingButtonConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let heightButtonConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        let bottomButtonConstraint = self.statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        
        //         heightConstraint,topStackLabelConstraint, bottonStackLabelConstraint,
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, self.buttonTopConstraint,leadingButtonConstraint, trailingButtonConstraint,bottomButtonConstraint, heightButtonConstraint, imageViewAspectRatio].compactMap({ $0 })) // объявление всех constrait и активирует расчет
    }
    @objc private func buttonPressed() {
        if self.textField.isHidden {
            self.addSubview(self.textField)
            
            self.buttonTopConstraint?.isActive = false // Необходимо деактивировать констрейнт, иначе будет конфликт констрейнтов, и Auto Layout не сможет однозначно определить фреймы textField'а.
            
            let topConstraint = self.textField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 16)
            let leadingConstraint = self.textField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor)
            let trailingConstraint = self.textField.trailingAnchor.constraint(equalTo: self.statusLabel.trailingAnchor)
            let heightTextFieldConstraint = self.textField.heightAnchor.constraint(equalToConstant: 34) // Не указав высоту textField'а, получается неоднозначность/неопределенность констрейнтов. Auto Layout на основе этой неопределенности имеет множество решений (height для stackView, textField), выбирая оптимальное, а не необходимое, то есть вместо 34pts для textField'а растягивается stackView.
            self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20)
            self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 998)
            
            NSLayoutConstraint.activate([
                topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint, self.buttonTopConstraint
            ].compactMap({ $0 }))
        }
               else {
                  // self.textField.isHidden = false
        //#warning("Убрать textField из вью!")
              }
        
        self.delegate?.buttonPressed(textFieldIsVisible: self.textField.isHidden) { [weak self] in
            self?.textField.isHidden.toggle()
        }
    }
    
    private var statusText: String?
    @objc private func statusTextChanged (_ textField: UITextField) {
      
        statusText = textField.text!
    }
    
}

/*
 Добавьте обработку нажатия по кнопке addTarget, UIEvent выбрать .touchUpInside. Добавьте функцию, которую будет принимать обработчик, например, @objc func buttonPressed()
 
 Функция должна выводить в консоль текст из поля "статус".
 При нажатии на кнопку должен происходить вызов функции.
 
 Добавьте экземпляр класса UITextField в класс ProfileHeaderView, выполните необходимые настройки согласно макету.
 
 Добавьте обработку изменения введенного текста при помощи addTarget, UIEvent выбрать .editingChanged. Добавьте функцию, которую будет принимать обработчик, например, @objc func statusTextChanged(_ textField: UITextField).
 
 Добавьте приватную переменную statusText с типом данных String.
 Функция statusTextChanged(_ :) должна записывать текст в переменную statusText.
 Измените функцию buttonPressed() так, чтобы при нажатии на кнопку введенный текст устанавливался в качестве статуса.
 
 
 
 
 */



 

    

