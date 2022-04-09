//
//  PhotosTableViewCell.swift
//  Navigation v2
//
//  Created by Alex Alex on 26.03.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = " Photos"
        label.textAlignment = NSTextAlignment.left
        label.toAutoLayout()
        return label
    }()
    
    private lazy var rightArrow: UIImageView = {
        let rightArrow = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(frame: .zero)
        imageView.image = rightArrow
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        return imageView
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.toAutoLayout()
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.toAutoLayout()
        return stackView
    }()
    
    private lazy var photoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.toAutoLayout()
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupBackPhotoView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    private func setupBackPhotoView() {
        contentView.addSubview(stackView)
        contentView.backgroundColor = .white
        self.stackView.addArrangedSubview(self.infoStackView)
        self.stackView.addArrangedSubview(self.photoStackView)
        self.infoStackView.addArrangedSubview(self.titleLabel)
        self.infoStackView.addArrangedSubview(self.rightArrow)
        
        for i in 0...3 {
            let image = UIImageView(image: UIImage(named: "\(photoNameArray[i])"))
            image.backgroundColor = .white
            //            Mark:- проверить необходимость
            image.frame.size.height = (UIScreen.main.bounds.width - 48) / 4
            image.frame.size.width = image.frame.size.height
            //            __________
            
            image.cornerRadius = 6
            image.clipsToBounds = true
            image.toAutoLayout()
            self.photoStackView.addArrangedSubview(image)
        }
        
        NSLayoutConstraint.activate([
            
            self.stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            self.stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            self.stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            self.stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
        ])
    }
    
    
}

