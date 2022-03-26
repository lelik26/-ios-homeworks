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
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell") // зарегистрировали ячейку и заполнили индефикатор и ниже переиспользуем ячейку
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPhotos()
        self.setupPhotoGallery()
        self.setupNavigationBar()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupNavigationBar() {   // установка Navigation controller
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Photos Gallery"
        
    }
    private func setupPhotoGallery() {
        
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 8)
        ].compactMap({ $0 }))
        
    }
    private func itemSize (for width:  CGFloat, with spacing: CGFloat) -> CGSize {
        // функция где хотим использовать 3 элемента в ряду : Получаем ширину ячейки и расстоянием между ячеек
        
        let needWidth = width - 2 * spacing // необходимая ширина ячейки
        let itemWidth = floor(needWidth / Constants.itemCount) //  ширина ячейки = необходимая ширина делимое на кол-во ячеек
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        let itemPhoto = self.dataSource[indexPath.row]
        let photoModel = PhotosCollectionViewCell.PhotoModel(photo: itemPhoto.photo)
        cell.setupPhoto(with: photoModel)
        return cell
    }
    
}


