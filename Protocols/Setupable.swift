//
//  Setupable.swift
//  Navigation
//
//  Created by Alex Alex on 13.03.2022.
//

import Foundation

protocol ViewModelProtocol {}   // заполнение ячееек , согласно протокола модели  ViewModelProtocol

protocol Setupable {
    func setup(with postViewModel: ViewModelProtocol)
}
