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
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell") // зарегистрировали ячейку и заполнили индефикатор и ниже переиспользуем ячейку
        collectionView.toAutoLayout()
        return collectionView
    }()
    
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
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
    }
    private func itemSize (for width:  CGFloat, with spacing: CGFloat) -> CGSize {
        // функция где хотим использовать 3 элемента в ряду : Получаем ширину ячейки и расстоянием между ячеек
        
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
    
}


