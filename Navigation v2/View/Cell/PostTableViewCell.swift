//
//  PostTableViewCell.swift
//  Navigation v2
//
//  Created by Alex Alex on 23.03.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
 
    struct PostModel: ViewModelProtocol {
        

     var author: String
     var description: String
     var image: String // имя картинки из каталога Assets.xcassets
     var likes: Int  //количество лайков
     var views: Int // количество просмотров
 }
  

 private lazy var backView: UIView = {
     let view = UIView()
     view.backgroundColor = .white
     view.contentMode = .scaleAspectFit
     view.toAutoLayout()
     return view
 }()
 
 private lazy var authorLabel: UILabel = {
     let label = UILabel()
     label.backgroundColor = .white
     label.numberOfLines = 2
     label.font = .systemFont(ofSize: 20, weight: .bold)
     label.textColor = .black
     label.text = " Автор:"
     label.toAutoLayout() //translatesAutoresizingMaskIntoConstraints = false
     return label
 }()
   
    private lazy var image: UIImageView = {    // установка изображения
     let imageView = UIImageView(image: UIImage(named: "smurf.jpg"))
        imageView.backgroundColor = .black
        imageView.frame.size.width =  UIScreen.main.bounds.width
        imageView.frame.size.height = imageView.frame.size.width
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        return imageView
    }()
        
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = NSTextAlignment.left
        label.text = "Описание: "
        label.toAutoLayout()
        return label
    }()

 private lazy var likesLabel: UILabel = {
     let label = UILabel()
     label.backgroundColor = .white
     label.font = .systemFont(ofSize: 16, weight: .regular)
     label.textColor = .black
     label.text = "Likes: "
     label.toAutoLayout()
     return label
 }()
 
 private lazy var viewsLabel: UILabel = {
     let label = UILabel()
     label.backgroundColor = .white
     label.font = .systemFont(ofSize: 16, weight: .regular)
     label.textColor = .black
     label.textAlignment = NSTextAlignment.right
     label.text = "Views: "
     label.toAutoLayout()
     return label
 }()
 

 private lazy var stackView: UIStackView = {
     let stackView = UIStackView()
     stackView.backgroundColor = .white
     stackView.axis = .vertical
     stackView.spacing = 10
     stackView.toAutoLayout()
     return stackView
 }()
 private lazy var infoStackView: UIStackView = {
     let stackView = UIStackView()
     stackView.axis = .horizontal
     stackView.spacing = 10
     stackView.distribution = .fillEqually
     stackView.toAutoLayout()
     return stackView
 }()
 

 override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
     self.setupBackView()
 }
 
 required init?(coder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
 }
 
 override func prepareForReuse() {
     super.prepareForReuse()
     self.authorLabel.text = nil
     self.descriptionLabel.text = nil
     self.image.image = nil
     self.likesLabel.text = nil
     self.viewsLabel.text = nil
     
 }
 
 private func setupBackView() {
     self.contentView.addSubview(self.backView)
     self.backView.addSubview(self.stackView)
     self.stackView.addArrangedSubview(self.authorLabel)
     self.stackView.addArrangedSubview(self.image)
     self.stackView.addArrangedSubview(self.descriptionLabel)
     self.stackView.addArrangedSubview(self.infoStackView)
     self.infoStackView.addArrangedSubview(self.likesLabel)
     self.infoStackView.addArrangedSubview(self.viewsLabel)
     
     NSLayoutConstraint.activate([
        self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
        self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
        self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
        self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
        
        self.stackView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 0),
        self.stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16),
        self.stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16),
        self.stackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: 0)
     ])
 }
    
}
extension PostTableViewCell: Setupable {
    
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? PostModel else { return }
        
        self.authorLabel.text = viewModel.author
     self.descriptionLabel.text = viewModel.description
     self.image.image = UIImage(named: "\(viewModel.image)")
     self.likesLabel.text = "Likes: \(String(viewModel.likes))"
     self.viewsLabel.text = "Views: \(String(viewModel.views))"
 }
}

