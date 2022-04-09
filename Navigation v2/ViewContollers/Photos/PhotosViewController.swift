//
//  PhotosViewController.swift
//  Navigation v2
//
//  Created by Alex Alex on 26.03.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    
    private enum Constants {
        
        static let itemCount: CGFloat = 3
    }
    
    private var dataSource: [PhotosProtocol] = []
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.toAutoLayout()
        return collectionView
    }()
    
    private lazy var forPhotoView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.toAutoLayout()
        return view
    }()
    
    private lazy var photoImageView: PhotosCollectionViewCell = {
        let imageView = PhotosCollectionViewCell(frame: .zero)
        imageView.toAutoLayout()
        return imageView
    }()
    
    private lazy var alphaView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.toAutoLayout()
        return view
    }()
    
    private lazy var crossButton: UIButton = {
        let button = UIButton()
        button.cornerRadius = 20
        button.alpha = 0
        button.clipsToBounds = true
        button.setImage(.init(systemName: "xmark.circle"), for: .normal)
        button.addTarget(self, action: #selector(self.didTapCrossButton), for: .touchUpInside)
        button.backgroundColor = .systemRed
        button.toAutoLayout()
        return button
    }()
    
    
    private let tapGestureRecogniger = UITapGestureRecognizer()
    private var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPhotos()
        self.setupPhotoGallery()
        self.setupNavigationBar("Photos Gallery")
        self.hideTabBar()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setupPhotoGallery() {
        
        self.view.backgroundColor = .systemGray6
        self.view.addSubviews(collectionView, forPhotoView, alphaView, crossButton)
        self.forPhotoView.addSubview(photoImageView)
        self.view.bringSubviews(alphaView, forPhotoView, crossButton)
        self.forPhotoView.alpha = 0
        self.alphaView.alpha = 0
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            forPhotoView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            forPhotoView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            forPhotoView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            forPhotoView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            photoImageView.centerXAnchor.constraint(equalTo: forPhotoView.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: forPhotoView.centerYAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            photoImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            alphaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            alphaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            alphaView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            alphaView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            crossButton.topAnchor.constraint(equalTo: forPhotoView.topAnchor, constant: -80),
            crossButton.trailingAnchor.constraint(equalTo: forPhotoView.trailingAnchor, constant: -10),
            crossButton.heightAnchor.constraint(equalToConstant: 40),
            crossButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    private func itemSize (for width:  CGFloat, with spacing: CGFloat) -> CGSize {
        
        let itemWidth = (UIScreen.main.bounds.width / Constants.itemCount - 2 * spacing)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    private func loadPhotos() {
        for i in 0...photoNameArray.count - 1 {
            dataSource.append(PhotosCollectionViewCell.PhotoModel(
                photo: photoNameArray[i]))
            
        }
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoNameArray.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        let photoModel = PhotosCollectionViewCell.PhotoModel(photo: dataSource[indexPath.row].photo)
        cell.setupPhoto(with: photoModel)
        cell.photoGalleryImageView.contentMode = .scaleAspectFill
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        photoImageView.photoGalleryImageView.image =  UIImage(named: photoNameArray[indexPath.row])
        self.isExpanded.toggle()
        self.forPhotoView.alpha = self.isExpanded ? 1 : 0
        
        UIView.animate(withDuration: 0.5) {
            self.alphaView.alpha = self.isExpanded ? 0.7 : 0
            self.view.layoutIfNeeded()
        } completion: { _ in
        }
        if self.isExpanded {
            self.alphaView.isHidden = false
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3) {
            self.crossButton.alpha = self.isExpanded ? 1 : 0
            self.crossButton.isHidden = false
        } completion: { _ in
            self.crossButton.isHidden = !self.isExpanded
        }
    }
    @objc private func didTapCrossButton() {
        
        UIView.animate(withDuration: 0.5) {
            self.forPhotoView.alpha = self.isExpanded ? 0 : 1
            self.alphaView.alpha = self.isExpanded ? 0 : 0.7
            self.view.layoutIfNeeded()
        } completion: { _ in  }
        
        UIView.animate(withDuration: 0.3) {
            self.crossButton.alpha = self.isExpanded ? 0 : 1
        } completion: { _ in
            self.crossButton.isHidden = false
            self.isExpanded = false
        }
    }
}










