//
//  PhotosCollectionViewCell.swift
//  Navigation v2
//
//  Created by Alex Alex on 26.03.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    struct PhotoModel: PhotosProtocol {
        
        var photo: String // имя картинки из каталога Assets.xcassets
    }
    
    var photoGalleryImageView: UIImageView = {
        
        let imageView = UIImageView(image: UIImage(named: photoNameArray[0]))
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(photoGalleryImageView)
        
        NSLayoutConstraint.activate([
            self.photoGalleryImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.photoGalleryImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.photoGalleryImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            self.photoGalleryImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() { 
        super.prepareForReuse()
        self.photoGalleryImageView.image = nil
    }
}
extension PhotosCollectionViewCell: SetupablePhotos {
    func setupPhoto(with photoModel: PhotosProtocol) {
        guard let photoModel = photoModel as? PhotoModel else { return }
        self.photoGalleryImageView.image = UIImage(named: "\(photoModel.photo)")
        
    }
}

