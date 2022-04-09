//
//  DetailedPostViewController.swift
//  Navigation v2
//
//  Created by Alex Alex on 05.04.2022.
//

import UIKit

class DetailedPostViewController: UIViewController {
    
    var detailedName, detailedDescription, detailedImage: String?
    
    var detailedLike, detailedViews: Int?
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    private lazy var postView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        //view.contentMode = .scaleAspectFit
        view.toAutoLayout()
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        if let text = detailedName {
            label.text = text
            
        }
        
        label.toAutoLayout() //translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var image: UIImageView = {    // установка изображения
        let imageView = UIImageView()
        if let image = detailedImage {
            imageView.image =  UIImage(named:  image)
        }
        imageView.backgroundColor = .black
        //           imageView.frame.size.width =  UIScreen.main.bounds.width
        //           imageView.frame.size.height = imageView.frame.size.width
        imageView.contentMode = .scaleAspectFit
        // imageView.clipsToBounds = true
        imageView.toAutoLayout()
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = NSTextAlignment.left
        if let text = detailedDescription {
            label.text = text
            
        }
        label.toAutoLayout()
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        if let likes =  detailedLike {
            label.text = "Likes: " + String(likes)
        }
        label.isUserInteractionEnabled = true
        label.toAutoLayout()
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = NSTextAlignment.right
        if let views =  detailedViews {
            label.text = "Views: "  + String(views)
        }
        label.toAutoLayout()
        return label
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        // stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.isUserInteractionEnabled = false
        stackView.spacing = 10
        stackView.toAutoLayout()
        return stackView
    }()
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.backgroundColor = .white
        // stackView.distribution = .fillEqually
        stackView.toAutoLayout()
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPostView()
        hideTabBar()
        setupNavigationBar("Описание")
        print(image)
        print(authorLabel)
        print(descriptionLabel)
        
        
        
    }
    
    private func setupPostView() {     //
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(postView)
        self.postView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.authorLabel)
        self.stackView.addArrangedSubview(self.image)
        self.stackView.addArrangedSubview(self.descriptionLabel)
        self.stackView.addArrangedSubview(self.infoStackView)
        self.infoStackView.addArrangedSubview(self.likesLabel)
        self.infoStackView.addArrangedSubview(self.viewsLabel)
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            self.postView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0),
            self.postView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 0),
            self.postView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: 0),
            self.postView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0),
            
            self.stackView.topAnchor.constraint(equalTo: self.postView.topAnchor, constant: 0),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.stackView.bottomAnchor.constraint(equalTo: self.postView.bottomAnchor, constant: 0)
        ])
    }
    
    
    
    
}
