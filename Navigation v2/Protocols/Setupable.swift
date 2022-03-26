//
//  Setupable.swift
//  Navigation v2
//
//  Created by Alex Alex on 23.03.2022.
//

import UIKit

protocol ViewModelProtocol {
    var author: String {get set}
    var description: String {get set}
    var image: String {get set} // имя картинки из каталога Assets.xcassets
    var likes: Int {get set}  //количество лайков
    var views: Int {get set}// количество просмотров
   
}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}

protocol PhotosProtocol {
    var photo: String {get set}
}

var photoNameArray: [String] = ["images 1", "images 2", "images 3", "images 4", "images 5", "images 6", "images 7", "images 8", "images 9", "images 10", "images 11", "images 12", "images 13", "images 14", "images 15", "images 16", "images 17", "images 18", "images 19", "images 20"]

protocol SetupablePhotos {
    
    func setupPhoto(with photoModel: PhotosProtocol)
    
}
