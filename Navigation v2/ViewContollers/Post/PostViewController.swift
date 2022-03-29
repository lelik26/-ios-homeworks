//
//  PostViewController.swift
//  Navigation v2
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: Post?
    
    // Mark: - создание прозрачной view
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.toAutoLayout()
        return view
    }()
    private lazy var myView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 45
        view.backgroundColor = .clear
        view.toAutoLayout()
        return view
    }()
    
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
   
   private lazy var alphaView: UIView = {
       let view = UIView()
       view.backgroundColor = .clear
       view.toAutoLayout()
       return view
   }()
   
   // Mark: - создание кнопки крестик
   private lazy var crossButton: UIButton = {
       let button = UIButton()
       button.layer.cornerRadius = 20
       button.alpha = 0
       button.clipsToBounds = true
       button.setImage(.init(systemName: "xmark.circle"), for: .normal)
       button.addTarget(self, action: #selector(self.didTapCrossButton), for: .touchUpInside)
       button.backgroundColor = .systemRed
       button.toAutoLayout()
       return button
   }()
   private let tapGestureRecogniger = UITapGestureRecognizer()
   
   private var leftXConstraint: NSLayoutConstraint?
   private var widthConstraint: NSLayoutConstraint?
   private var heightConstraint: NSLayoutConstraint?
   private var topConstraint: NSLayoutConstraint?

   private var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.title
        let infoButton = UIBarButtonItem(title: "info" , style: .plain, target: self, action: #selector(didTapTransitionInfoButton))
        self.navigationItem.setRightBarButton(infoButton, animated: true)
        view.backgroundColor = .white
        self.setupView()
        self.setupGesture()
    }
    
    private func setupView() {
        self.view.addSubview(self.backView)
        self.backView.addSubviews(myView, alphaView, crossButton)
        self.myView.addSubview(self.avatarImageView)
        self.backView.bringSubviews(alphaView, myView, crossButton)
               
        self.myView.layer.cornerRadius = 45
        self.alphaView.alpha = 0
        
        self.leftXConstraint = self.myView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        self.topConstraint = self.myView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 16)
        self.heightConstraint = myView.heightAnchor.constraint(equalToConstant: 90)
        self.widthConstraint =  self.myView.widthAnchor.constraint(equalToConstant: 90)

        
        NSLayoutConstraint.activate([
            
            self.backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.backView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor ,constant: 0),
            self.backView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            self.backView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor,constant: 0),

            self.avatarImageView.topAnchor.constraint(equalTo: myView.topAnchor),
            self.avatarImageView.bottomAnchor.constraint(equalTo: myView.bottomAnchor),
            self.avatarImageView.leadingAnchor.constraint(equalTo: myView.leadingAnchor),
            self.avatarImageView.trailingAnchor.constraint(equalTo: myView.trailingAnchor),
            
            self.alphaView.topAnchor.constraint(equalTo: backView.topAnchor),
            self.alphaView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            self.alphaView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            self.alphaView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            
            self.crossButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.crossButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.crossButton.heightAnchor.constraint(equalToConstant: 40),
            self.crossButton.widthAnchor.constraint(equalToConstant: 40),
            
            self.leftXConstraint,
            self.topConstraint,
            self.heightConstraint,
            self.widthConstraint
            
            
        ].compactMap({ $0 }))
    }
    private func setupGesture() {
        self.tapGestureRecogniger.addTarget(self, action: #selector(self.handleTapGesture(_ :)))
        self.myView.addGestureRecognizer(self.tapGestureRecogniger)
        
    }
    
    @objc private func handleTapGesture (_ gestureRecognizer: UITapGestureRecognizer){
        guard self.tapGestureRecogniger === gestureRecognizer else { return }
        
        self.isExpanded.toggle()  //в первой картинке
        self.leftXConstraint?.constant = self.isExpanded ?  0 : 16
        self.topConstraint?.constant = self.isExpanded ?  (backView.bounds.height - UIScreen.main.bounds.width ) * 0.5  : 16
        
        self.widthConstraint?.constant = self.isExpanded ?  (UIScreen.main.bounds.width) : 90
        self.heightConstraint?.constant = self.isExpanded ? (UIScreen.main.bounds.width) : 90
        
        UIView.animate(withDuration: 0.5) {
            self.myView.layer.cornerRadius = self.isExpanded ? 0 : 45
            self.avatarImageView.layer.cornerRadius = self.isExpanded ? 0 : 45
            self.alphaView.alpha = self.isExpanded ? 1 : 0
            self.view.layoutIfNeeded()
        } completion: { _ in
        }
        
        if self.isExpanded {
            self.alphaView.isHidden = false
            self.crossButton.isHidden = false
          
        }
        
        UIView.animate(withDuration: 0.5 ){
            self.crossButton.alpha = self.isExpanded ? 1 : 0

        } completion: { _ in
            self.crossButton.isHidden = !self.isExpanded
           
        }
        
    }
    
    @objc private func didTapCrossButton() {
       
        self.leftXConstraint?.constant = self.isExpanded ?  16 :  (UIScreen.main.bounds.width) / 2
        self.topConstraint?.constant = self.isExpanded ?   16 :  (UIScreen.main.bounds.height) / 2
        
        self.widthConstraint?.constant = self.isExpanded ?  90 : (UIScreen.main.bounds.width)
        self.heightConstraint?.constant = self.isExpanded ? 90 : (UIScreen.main.bounds.width)
        self.avatarImageView.layer.cornerRadius = 45

        
        UIView.animate(withDuration: 0.5) {
          self.myView.layer.cornerRadius = 45
            self.alphaView.alpha = 0
            self.view.layoutIfNeeded()
    
        } completion: { _ in

        }

        UIView.animate(withDuration: 0.3) { //, delay: 0.5
            self.crossButton.alpha = 0
        } completion: { _ in
            self.crossButton.isHidden = false
            self.isExpanded = false
        }
    }
    
    
    @objc func didTapTransitionInfoButton() {
        pushViewController(InfoViewController(),"назад")
    }
}
