//
//  PhotosTableViewCell.swift
//  Navigation v2
//
//  Created by Alex Alex on 26.03.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var backPhotoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = " Photos"
        label.textAlignment = NSTextAlignment.left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
}()
    
    private lazy var rightArrow: UIImageView = {
        let rightArrow = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.image = rightArrow
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
}()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var photoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        self.titleLabel.text = nil
        self.rightArrow.image = nil

}
    private func setupBackPhotoView() {
        self.contentView.addSubview(self.backPhotoView)
        self.backPhotoView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.infoStackView)
        self.stackView.addArrangedSubview(self.photoStackView)
        self.infoStackView.addArrangedSubview(self.titleLabel)
        self.infoStackView.addArrangedSubview(self.rightArrow)
        
        for i in 0...3 {
            let image = UIImageView(image: UIImage(named: "\(photoNameArray[i])"))
            image.backgroundColor = .white
            image.frame.size.width =  (UIScreen.main.bounds.width - 48) / 4
            image.frame.size.height = image.frame.size.width
            image.contentMode = .scaleAspectFit
            image.layer.cornerRadius = 6
            image.clipsToBounds = true
            image.translatesAutoresizingMaskIntoConstraints = false
            self.photoStackView.addArrangedSubview(image)
        }

        NSLayoutConstraint.activate([
            self.backPhotoView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.backPhotoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.backPhotoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            self.backPhotoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            self.stackView.topAnchor.constraint(equalTo: self.backPhotoView.topAnchor, constant: 12),
            self.stackView.leadingAnchor.constraint(equalTo: self.backPhotoView.leadingAnchor, constant: 12),
            self.stackView.trailingAnchor.constraint(equalTo: self.backPhotoView.trailingAnchor, constant: -12),
            self.stackView.bottomAnchor.constraint(equalTo: self.backPhotoView.bottomAnchor, constant: 0)
            
        ].compactMap({ $0 }))
    }
       
   
}

