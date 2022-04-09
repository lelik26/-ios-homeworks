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



protocol SetupablePhotos {
    
    func setupPhoto(with photoModel: PhotosProtocol)
    
}

protocol ClickLikesLabelDelegate: AnyObject {
    func clickLikesLabel()
}
