//
//  LogInView.swift
//  Navigation v2
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

class PhotoView: UIView {
    
    private lazy var forImageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 0
        view.backgroundColor = .clear
        view.toAutoLayout()
        return view
    }()
    var photoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "images 10"))
        imageView.backgroundColor = .clear
        imageView.borderColor = .white
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupPhotoView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhotoView() {
        addSubviews(forImageView, alphaView)
        self.forImageView.addSubview(photoImage)
        bringSubviews(alphaView, forImageView )
        self.alphaView.alpha = 0
        
        NSLayoutConstraint.activate([
            
            self.photoImage.topAnchor.constraint(equalTo: forImageView.topAnchor),
            self.photoImage.bottomAnchor.constraint(equalTo: forImageView.bottomAnchor),
            self.photoImage.leadingAnchor.constraint(equalTo: forImageView.leadingAnchor),
            self.photoImage.trailingAnchor.constraint(equalTo: forImageView.trailingAnchor),
            
            self.alphaView.topAnchor.constraint(equalTo: self.topAnchor),
            self.alphaView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.alphaView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.alphaView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
        ].compactMap({ $0 }))
    }
}
